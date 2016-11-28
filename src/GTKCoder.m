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

#define KEYED_CODING_EXCEPTION_CHECK                                           \
    if (!self.allowsKeyedCoding) {                                             \
         @throw [GTKCoderKeyedCodingNotAllowedException exception];            \
    }                                                                          \

#define INVALID_KEY_EXCEPTION_CHECK                                            \
    if (![key isKindOfClass: OFString.class]) {                                \
         @throw [GTKCoderInvalidKeyException exception];                       \
    }                                                                          \

#define REMOVE_OLD_VALUE_FOR_KEY                                               \
    OFArray *elements = [self.data elementsForName: key];                      \
    for (OFXMLElement *element in elements) {                                  \
        [self.data removeChild: element];                                      \
    }                                                                          \

@implementation GTKCoderKeyedCodingNotAllowedException
- (OFString *)description
{
    return @"Error: Keyed coding not allowed.";
}
@end

@implementation GTKCoderInvalidKeyException
- (OFString *)description
{
return @"Error: Invalid key.";
}
@end

@implementation GTKCodingKeyReference
- (instancetype)initWithCoder:(GTKCoder *)decoder
{
    self = [self init];
    self.key = [decoder decodeStringForKey: @"GTKKit.coding.keyReference.key"];
    return self;
}

- (void)encodeWithCoder:(GTKCoder *)encoder
{
    [encoder encodeString: self.key forKey: @"GTKKit.coding.keyReference.key"];
}
@end

@interface GTKCoder (Private)
/*!
* @brief Decode the object for the supplied key.
*/
- (id)decodeObjectOfClass:(Class)class
                   forKey:(OFString *)key;
@end

@implementation GTKCoder
- init
{
    self = [super init];
    self.data = [OFXMLElement elementWithName: self.className];
    OFXMLElement *classNames = [OFXMLElement elementWithName: @"GTKKit.coding.classNames"];
    [self.data addChild: classNames];
    return self;
}

- (bool)allowsKeyedCoding
{
    return false;
}

- (bool)containsValueForKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
    INVALID_KEY_EXCEPTION_CHECK

    return nil != [self.data elementsForName: key];
}

- (void)setClass:(Class)class
          forKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
    INVALID_KEY_EXCEPTION_CHECK

    OFString *className = [OFString stringWithUTF8String: class_getName(class.class)];

    OFXMLElement *classNames = [self.data elementForName: @"GTKKit.coding.classNames"];
    [classNames removeAttributeForName: key];
    [classNames addAttributeWithName: key
                         stringValue: className];
}

- (Class)classForKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
    INVALID_KEY_EXCEPTION_CHECK

    OFXMLElement *classNames = [self.data elementForName: @"GTKKit.coding.classNames"];
    OFString *className = [[classNames attributeForName: key] stringValue];
    Class class = objc_getClass(className.UTF8String);
    return class;
}

- (void)encodeBool:(bool)value
            forKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
    INVALID_KEY_EXCEPTION_CHECK
    REMOVE_OLD_VALUE_FOR_KEY

    OFString *string = value ? @"true" : @"false";
    OFXMLElement *element = string.XMLElementBySerializing;
    element.name = key;
    [self.data addChild: element];
}

- (void)encodeDouble:(double)value
              forKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
    INVALID_KEY_EXCEPTION_CHECK
    REMOVE_OLD_VALUE_FOR_KEY

    OFNumber *number = [OFNumber numberWithDouble: value];
    OFXMLElement *element = [OFXMLElement elementWithName: key];
    element.stringValue = number.stringBySerializing;
    [self.data addChild: element];
}

- (void)encodeFloat:(float)value
             forKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
    INVALID_KEY_EXCEPTION_CHECK
    REMOVE_OLD_VALUE_FOR_KEY

    OFNumber *number = [OFNumber numberWithFloat: value];
    OFXMLElement *element = [OFXMLElement elementWithName: key];
    element.stringValue = number.stringBySerializing;
    [self.data addChild: element];
}

- (void)encodeInt:(int)value
           forKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
    INVALID_KEY_EXCEPTION_CHECK
    REMOVE_OLD_VALUE_FOR_KEY

    OFNumber *number = [OFNumber numberWithInt: value];
    OFXMLElement *element = [OFXMLElement elementWithName: key];
    element.stringValue = number.stringBySerializing;
    [self.data addChild: element];
}

- (void)encodeString:(OFString *)value
              forKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
    INVALID_KEY_EXCEPTION_CHECK
    REMOVE_OLD_VALUE_FOR_KEY

    OFXMLElement *element = [OFXMLElement elementWithName: key];
    element.stringValue = value;
    [self.data addChild: element];
}

- (void)encodeObject:(OFObject<GTKCoding> *)object
              forKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
    INVALID_KEY_EXCEPTION_CHECK
    REMOVE_OLD_VALUE_FOR_KEY

    [self setClass: object.class forKey: key];
    GTKKeyedArchiver *coder = [GTKKeyedArchiver new];
    [object encodeWithCoder: coder];
    coder.data.name = key;
    [self.data addChild: coder.data];
}

- (void)encodeSelector:(SEL)selector
                forKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
    INVALID_KEY_EXCEPTION_CHECK

    [self encodeString: OFStringFromSelector(selector) forKey: key];
}

- (bool)decodeBoolForKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
    INVALID_KEY_EXCEPTION_CHECK

    OFXMLElement *element = [self.data elementForName: key];
    OFString *string = [[OFString alloc] initWithSerialization: element];
    return [string isEqual: @"true"];
}

- (double)decodeDoubleForKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
    INVALID_KEY_EXCEPTION_CHECK

    OFXMLElement *element = [self.data elementForName: key];
    OFNumber *number = element.stringValue.objectByDeserializing;
    return number.doubleValue;
}

- (float)decodeFloatForKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
    INVALID_KEY_EXCEPTION_CHECK

    OFXMLElement *element = [self.data elementForName: key];
    OFNumber *number = element.stringValue.objectByDeserializing;
    return number.floatValue;
}

- (int)decodeIntForKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
    INVALID_KEY_EXCEPTION_CHECK

    OFXMLElement *element = [self.data elementForName: key];
    OFNumber *number = element.stringValue.objectByDeserializing;
    return number.intValue;
}

- (OFString *)decodeStringForKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
    INVALID_KEY_EXCEPTION_CHECK

    OFXMLElement *element = [self.data elementForName: key];
    return element.stringValue;
}

- (id)decodeObjectForKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
    INVALID_KEY_EXCEPTION_CHECK

    Class class = [self classForKey: key];

    return [self decodeObjectOfClass: class forKey: key];
}

- (SEL)decodeSelectorforKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
    INVALID_KEY_EXCEPTION_CHECK

    OFString *selector = [self decodeStringForKey: key];
    return OFSelectorFromString(selector);
}
@end

@implementation GTKCoder (Private)
- (id)decodeObjectOfClass:(Class)class
                   forKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
    INVALID_KEY_EXCEPTION_CHECK

    GTKKeyedUnarchiver *coder = [GTKKeyedUnarchiver new];
    coder.data = [self.data elementForName: key];
    id object = [[class alloc] initWithCoder: coder];
    return object;
}
@end
