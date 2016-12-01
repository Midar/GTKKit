/*! @file GTKKeyedUnarchiver.m
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

#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>

#import "GTKKeyedUnarchiver.h"

@interface GTKKeyedUnarchiver (Private)
- (Class)classForKey:(OFString *)key;
@end

/*!
 * @brief A class representing keyed archiver objects which have the ability to
 * write themselves to files.
 */
@implementation GTKKeyedUnarchiver
+ (instancetype)keyedUnarchiverWithContentsOfURL:(OFURL *)url
{
    OFString *string = [OFString stringWithContentsOfURL: url];

    return [self keyedUnarchiverWithXMLString: string];
}

+ (instancetype)keyedUnarchiverWithXMLString:(OFString *)string
{
    GTKKeyedUnarchiver *coder = [self new];
    OFXMLElement *data = [OFXMLElement elementWithXMLString: string];
    coder.data = data;
    return coder;
}

+ (id)unarchiveObjectOfClass:(Class)class
                   withCoder:(GTKKeyedUnarchiver *)coder
{
    id object = [[class alloc] initWithCoder: coder];
    return object;
}

+ (id)unarchiveObjectOfClass:(Class)class
                     withURL:(OFURL *)url
{
    GTKKeyedUnarchiver *coder = [self keyedUnarchiverWithContentsOfURL: url];
    return [self unarchiveObjectOfClass: class
                              withCoder: coder];
}

- (bool)allowsKeyedCoding
{
    return true;
}

- (bool)containsValueForKey:(OFString *)key
{
    INVALID_KEY_EXCEPTION_CHECK

    return [[self.data elementsForName: key] count] > 0;
}

- (bool)decodeBoolForKey:(OFString *)key
{
    INVALID_KEY_EXCEPTION_CHECK

    OFXMLElement *element = [self.data elementForName: key];
    OFString *string = element.stringValue;
    return [string isEqual: @"true"];
}

- (double)decodeDoubleForKey:(OFString *)key
{
    INVALID_KEY_EXCEPTION_CHECK

    OFXMLElement *element = [self.data elementForName: key];
    OFNumber *number = element.stringValue.objectByDeserializing;
    return number.doubleValue;
}

- (float)decodeFloatForKey:(OFString *)key
{
    INVALID_KEY_EXCEPTION_CHECK

    OFXMLElement *element = [self.data elementForName: key];
    OFNumber *number = element.stringValue.objectByDeserializing;
    return number.floatValue;
}

- (int)decodeIntForKey:(OFString *)key
{
    INVALID_KEY_EXCEPTION_CHECK

    OFXMLElement *element = [self.data elementForName: key];
    OFNumber *number = element.stringValue.objectByDeserializing;
    return number.intValue;
}

- (OFString *)decodeStringForKey:(OFString *)key
{
    INVALID_KEY_EXCEPTION_CHECK

    OFXMLElement *element = [self.data elementForName: key];
    return element.stringValue;
}

- (id)decodeObjectForKey:(OFString *)key
{
    INVALID_KEY_EXCEPTION_CHECK

    Class class = [self classForKey: key];

    if (class == OFString.class) {
        return [self decodeStringForKey: key];
    }

    OFXMLElement *xml = [self.data elementForName: key];
    GTKKeyedUnarchiver *coder = [[GTKKeyedUnarchiver alloc] initWithSerialization: xml];
    return [[class alloc] initWithCoder: coder];
}

- (SEL)decodeSelectorforKey:(OFString *)key
{
    INVALID_KEY_EXCEPTION_CHECK

    OFString *selector = [self decodeStringForKey: key];
    return OFSelectorFromString(selector);
}
@end

@implementation GTKKeyedUnarchiver (Private)
- (Class)classForKey:(OFString *)key
{
    INVALID_KEY_EXCEPTION_CHECK

    OFXMLElement *classNames = [self.data elementForName: @"GTKKit.coding.classNames"];
    OFString *className = [[classNames attributeForName: key] stringValue];
    Class class = objc_getClass(className.UTF8String);
    return class;
}
@end
