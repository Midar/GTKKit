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
#import "OFArray+GTKCoding.h"

@implementation OFDictionary (GTKCoding)
- (instancetype)initWithCoder: (GTKKeyedUnarchiver *)decoder
{
	GTKCoder *keyCoder, *valueCoder;
	OFArray *keys, *values;

	keyCoder = [GTKKeyedUnarchiver new];
	keyCoder.data = [decoder.data elementForName: @"GTKKit.coding.dictionary.keys"];

	valueCoder = [GTKKeyedUnarchiver new];
	valueCoder.data = [decoder.data elementForName: @"GTKKit.coding.dictionary.values"];

	keys = [GTKKeyedUnarchiver unarchiveObjectOfClass: OFArray.class withCoder: keyCoder];
	values = [GTKKeyedUnarchiver unarchiveObjectOfClass: OFArray.class withCoder: valueCoder];

	self = [self initWithObjects: values forKeys: keys];
	return self;
}

- (void)encodeWithCoder: (GTKKeyedArchiver *)encoder
{
	GTKCoder *keys, *values;
	keys = [GTKKeyedArchiver archiveRootObject: self.allKeys];
	values = [GTKKeyedArchiver archiveRootObject: self.allObjects];
	keys.data.name = @"GTKKit.coding.dictionary.keys";
	values.data.name = @"GTKKit.coding.dictionary.values";
	[encoder.data addChild: keys.data];
	[encoder.data addChild: values.data];
}
@end
