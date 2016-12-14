/*! @file OFList+GTKCoding.m
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

#import "OFArray+GTKCoding.h"
#import "GTKCoder.h"
#import "GTKKeyedArchiver.h"
#import "GTKKeyedUnarchiver.h"

@implementation OFList (GTKCoding)
- (instancetype)initWithCoder:(GTKKeyedUnarchiver *)decoder
{
	self = [self init];
	GTKCoder *coder = [GTKKeyedUnarchiver new];
	coder.data = [decoder.data elementForName: @"GTKKit.coding.list"];
	OFArray *array = [GTKKeyedUnarchiver unarchiveObjectOfClass: OFArray.class
													  withCoder: coder];
	for (id object in array) {
		[self appendObject: object];
	}
	return self;
}

- (void)encodeWithCoder:(GTKKeyedArchiver *)encoder
{
	OFArray *array = self.objectEnumerator.allObjects;
	GTKCoder *coder = [GTKKeyedArchiver archiveRootObject: array];
	coder.data.name = @"GTKKit.coding.list";
	[encoder.data addChild: coder.data];
}
@end
