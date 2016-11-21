/*! @file GTKCoder.m
 *
 * Copyright (c) 2014, 2015, 2016
 *   Kyle Cardoza <Kyle.Cardoza@icloud.com>
 *
 * All rights reserved.
 *
 * This file is part of GTKKit. It may be distributed under the terms of the
 * 2-clause BSD License, which can be found in the file COPYING.BSD included in
 * the packaging of this file.
 *
 * Alternatively, it may be distributed under the terms of the GNU Lesser
 * General Public License, either version 2 or 3, which can be found in the
 * files COPYING.LGPL2 and COPYING.LGPL3, respectively, both also included in
 * the packaging of this file.
 */

 #import "GTKCoder.h"
 #import "GTKKeyedArchiver.h"
 #import "GTKKeyedUnarchiver.h"
 #import "OFNumber+GTKCoding.h"
 #import "OFString+GTKCoding.h"
 #import "OFArray+GTKCoding.h"
 #import "OFDictionary+GTKCoding.h"

 @implementation GTKCoderKeyedCodingNotAllowedException
 - (OFString *)description
 {
     return @"Error: Keyed coding not allowed.";
 }
 @end

@implementation GTKCoder
- init
{
    self = [self initWithName: self.className];
    OFXMLElement *classNames = [OFXMLElement elementWithName: @"GTKKit.coding.classNames"];
    [self addChild: classNames];
    return self;
}

- (bool)allowsKeyedCoding
{
    return false;
}

- (bool)containsValueForKey:(OFString *)key
{
    if (!self.allowsKeyedCoding) {
        @throw [GTKCoderKeyedCodingNotAllowedException exception];
    }
    return nil != [self elementsForName: key];
}

- (void)setClass:(Class)class
          forKey:(OFString *)key
{
    if (!self.allowsKeyedCoding) {
        @throw [GTKCoderKeyedCodingNotAllowedException exception];
    }
    OFString *className = [OFString stringWithUTF8String: class_getName(class.class)];

    OFXMLElement *classNames = [self elementForName: @"GTKKit.coding.classNames"];
    [classNames removeAttributeForName: key];
    [classNames addAttributeWithName: key
                         stringValue: className];
}

- (Class)classForKey:(OFString *)key
{
    if (!self.allowsKeyedCoding) {
        @throw [GTKCoderKeyedCodingNotAllowedException exception];
    }
    OFXMLElement *classNames = [self elementForName: @"GTKKit.coding.classNames"];
    OFString *className = [[classNames attributeForName: key] stringValue];
    Class class = objc_getClass(className.UTF8String);
    return class;
}

- (void)encodeBool:(bool)value
            forKey:(OFString *)key
{
    if (!self.allowsKeyedCoding) {
        @throw [GTKCoderKeyedCodingNotAllowedException exception];
    }
    OFArray *elements = [self elementsForName: key];
    for (OFXMLElement *element in elements) {
        [self removeChild: element];
    }

    OFString *string = value ? @"true" : @"false";
    OFXMLElement *element = string.XMLElementBySerializing;
    element.name = key;
    [self addChild: element];
}

- (void)encodeDouble:(double)value
              forKey:(OFString *)key
{
    if (!self.allowsKeyedCoding) {
        @throw [GTKCoderKeyedCodingNotAllowedException exception];
    }
    OFArray *elements = [self elementsForName: key];
    for (OFXMLElement *element in elements) {
        [self removeChild: element];
    }

    OFNumber *number = [OFNumber numberWithDouble: value];
    OFXMLElement *element = [OFXMLElement elementWithName: key];
    element.stringValue = number.stringBySerializing;
    [self addChild: element];
}

- (void)encodeFloat:(float)value
             forKey:(OFString *)key
{
    if (!self.allowsKeyedCoding) {
        @throw [GTKCoderKeyedCodingNotAllowedException exception];
    }
    OFArray *elements = [self elementsForName: key];
    for (OFXMLElement *element in elements) {
        [self removeChild: element];
    }

    OFNumber *number = [OFNumber numberWithFloat: value];
    OFXMLElement *element = [OFXMLElement elementWithName: key];
    element.stringValue = number.stringBySerializing;
    [self addChild: element];
}

- (void)encodeInt:(int)value
           forKey:(OFString *)key
{
    if (!self.allowsKeyedCoding) {
        @throw [GTKCoderKeyedCodingNotAllowedException exception];
    }
    OFArray *elements = [self elementsForName: key];
    for (OFXMLElement *element in elements) {
        [self removeChild: element];
    }

    OFNumber *number = [OFNumber numberWithInt: value];
    OFXMLElement *element = [OFXMLElement elementWithName: key];
    element.stringValue = number.stringBySerializing;
    [self addChild: element];
}

- (void)encodeString:(OFString *)value
              forKey:(OFString *)key
{
    if (!self.allowsKeyedCoding) {
        @throw [GTKCoderKeyedCodingNotAllowedException exception];
    }
    OFArray *elements = [self elementsForName: key];
    for (OFXMLElement *element in elements) {
        [self removeChild: element];
    }

    OFXMLElement *element = [OFXMLElement elementWithName: key];
    element.stringValue = value;
    [self addChild: element];
}

- (void)encodeObject:(OFObject<GTKCoding> *)object
              forKey:(OFString *)key
{
    if (!self.allowsKeyedCoding) {
        @throw [GTKCoderKeyedCodingNotAllowedException exception];
    }
    OFArray *elements = [self elementsForName: key];
    for (OFXMLElement *element in elements) {
        [self removeChild: element];
    }

    [self setClass: object.class forKey: key];

    GTKKeyedArchiver *coder = [GTKKeyedArchiver new];
    [object encodeWithCoder: coder];
    coder.name = key;
    [self addChild: coder];
}

- (void)encodeSelector:(SEL)selector
                forKey:(OFString *)key
{
    if (!self.allowsKeyedCoding) {
        @throw [GTKCoderKeyedCodingNotAllowedException exception];
    }
    [self encodeString: OFStringFromSelector(selector) forKey: key];
}

- (bool)decodeBoolForKey:(OFString *)key
{
    if (!self.allowsKeyedCoding) {
        @throw [GTKCoderKeyedCodingNotAllowedException exception];
    }
    OFXMLElement *element = [self elementForName: key];
    OFString *string = [[OFString alloc] initWithSerialization: element];
    return [string isEqual: @"true"];
}

- (double)decodeDoubleForKey:(OFString *)key
{
    if (!self.allowsKeyedCoding) {
        @throw [GTKCoderKeyedCodingNotAllowedException exception];
    }
    OFXMLElement *element = [self elementForName: key];
    OFNumber *number = element.stringValue.objectByDeserializing;
    return number.doubleValue;
}

- (float)decodeFloatForKey:(OFString *)key
{
    if (!self.allowsKeyedCoding) {
        @throw [GTKCoderKeyedCodingNotAllowedException exception];
    }
    OFXMLElement *element = [self elementForName: key];
    OFNumber *number = element.stringValue.objectByDeserializing;
    return number.floatValue;
}

- (int)decodeIntForKey:(OFString *)key
{
    if (!self.allowsKeyedCoding) {
        @throw [GTKCoderKeyedCodingNotAllowedException exception];
    }
    OFXMLElement *element = [self elementForName: key];
    OFNumber *number = element.stringValue.objectByDeserializing;
    return number.intValue;
}

- (OFString *)decodeStringForKey:(OFString *)key
{
    if (!self.allowsKeyedCoding) {
        @throw [GTKCoderKeyedCodingNotAllowedException exception];
    }
    OFXMLElement *element = [self elementForName: key];
    return element.stringValue;
}

- (id)decodeObjectForKey:(OFString *)key
{
    if (!self.allowsKeyedCoding) {
        @throw [GTKCoderKeyedCodingNotAllowedException exception];
    }
    Class class = [self classForKey: key];
    id object = [self decodeObjectOfClass: class forKey: key];
    return object;
}

- (id)decodeObjectOfClass:(Class)class
                   forKey:(OFString *)key
{
    if (!self.allowsKeyedCoding) {
        @throw [GTKCoderKeyedCodingNotAllowedException exception];
    }
    GTKKeyedUnarchiver *coder = (GTKKeyedUnarchiver *)([self elementForName: key]);
    id object = [[class alloc] initWithCoder: coder];
    return object;
}

- (SEL)decodeSelectorforKey:(OFString *)key
{
    if (!self.allowsKeyedCoding) {
        @throw [GTKCoderKeyedCodingNotAllowedException exception];
    }
    OFString *selector = [self decodeStringForKey: key];
    return OFSelectorFromString(selector);
}
@end
