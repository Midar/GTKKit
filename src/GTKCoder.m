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

@implementation GTKCoderInvalidKeyException
- (OFString *)description
{
    return @"Error: Invalid key.";
}
@end

@implementation GTKCoder
- init
{
    self = [super init];
    self.data = [OFXMLElement elementWithName: @"GTKKit.coding.coder"];
    OFXMLElement *classNames = [OFXMLElement elementWithName: @"GTKKit.coding.classNames"];
    [self.data addChild: classNames];
    return self;
}
@end

@implementation GTKCoder (KeyedCoding)
- (bool)allowsKeyedCoding
{
    return false;
}

- (bool)containsValueForKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
    INVALID_KEY_EXCEPTION_CHECK

    return false;
}

- (void)setClass:(Class)class
          forKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
}

- (Class)classForKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
    return nil;
}

- (void)encodeBool:(bool)value
            forKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
}

- (void)encodeDouble:(double)value
              forKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
}

- (void)encodeFloat:(float)value
             forKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
}

- (void)encodeInt:(int)value
           forKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
}

- (void)encodeString:(OFString *)value
              forKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
}

- (void)encodeObject:(OFObject<GTKCoding> *)object
              forKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
}

- (void)encodeSelector:(SEL)selector
                forKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
}

- (bool)decodeBoolForKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
    return false;
}

- (double)decodeDoubleForKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
    return 0.0;
}

- (float)decodeFloatForKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
    return 0.0f;
}

- (int)decodeIntForKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
    return 0;
}

- (OFString *)decodeStringForKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
    return nil;
}

- (id)decodeObjectForKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
    return nil;
}

- (SEL)decodeSelectorforKey:(OFString *)key
{
    KEYED_CODING_EXCEPTION_CHECK
    return NULL;
}
@end

@implementation GTKCoder (OFCopying)
- (GTKCoder *)copy
{
    GTKCoder *copy = [self.class new];
    copy.data = self.data.copy;
    return copy;
}
@end

@implementation GTKCoder (OFSerialization)
- initWithSerialization:(OFXMLElement *)element
{
    self = [self init];
    self.data = element.copy;
    return self;
}

- (OFXMLElement *)XMLElementBySerializing
{
    return self.data.copy;
}

- (OFString *)XMLString
{
    return self.data.XMLString;
}
@end
