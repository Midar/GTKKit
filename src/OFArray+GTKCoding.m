/*! @file OFArray+GTKCoding.m
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

@implementation OFArray (GTKCoding)
- (instancetype)initWithCoder:(GTKKeyedUnarchiver *)decoder
{
	OFMutableArray *array = [OFMutableArray new];

	unsigned long i = 0;

	OFString *key = [OFString stringWithFormat: @"GTKKIT.objects.array.%lu", i];
	id value = [decoder decodeObjectForKey: key];

	while (value != nil) {
		[array addObject: value];
		i++;
		key = [OFString stringWithFormat: @"GTKKIT.objects.array.%lu", i];
		value = [decoder decodeObjectForKey: key];
	}

	self = [self initWithArray: array];

	return self;
}

- (void)encodeWithCoder:(GTKKeyedArchiver *)encoder
{
	unsigned long i;

	for (i = 0; i < self.count; i++) {
		OFString *key = [OFString stringWithFormat: @"GTKKIT.objects.array.%lu", i];

		id object = [self objectAtIndex: i];

		if ([object isKindOfClass: OFString.class]) {
			object = [OFString stringWithString: object];
		}

		[encoder encodeObject: object
					   forKey: key];
	}
}
@end
