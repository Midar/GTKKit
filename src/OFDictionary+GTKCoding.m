/*! @file OFDictionary+GTKCoding.m
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

#import "OFDictionary+GTKCoding.h"
#import "GTKCoder.h"
#import "GTKKeyedArchiver.h"
#import "GTKKeyedUnarchiver.h"

@implementation OFDictionary (GTKCoding)
- (instancetype)initWithCoder:(GTKCoder *)decoder
{
    GTKCoder *keyCoder, *valueCoder;
    OFArray *keys, *values;

    keyCoder = (GTKCoder *)[decoder elementForName: @"GTKKit.coding.dictionary.keys"];
    valueCoder = (GTKCoder *)[decoder elementForName: @"GTKKit.coding.dictionary.values"];

    keys = [GTKKeyedUnarchiver unarchiveObjectOfClass: OFArray.class withCoder: keyCoder];
    values = [GTKKeyedUnarchiver unarchiveObjectOfClass: OFArray.class withCoder: valueCoder];

    self = [self initWithObjects: values forKeys: keys];
    return self;
}

- (void)encodeWithCoder:(GTKCoder *)encoder
{
    GTKCoder *keys, *values;
    keys = [GTKKeyedArchiver archiveRootObject: self.allKeys];
    values = [GTKKeyedArchiver archiveRootObject: self.allObjects];
    keys.name = @"GTKKit.coding.dictionary.keys";
    values.name = @"GTKKit.coding.dictionary.values";
    [encoder addChild: keys];
    [encoder addChild: values];
}
@end
