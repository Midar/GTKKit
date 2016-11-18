/*! @file OFString+GTKCoding.m
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

#import "OFString+GTKCoding.h"
#import "GTKCoder.h"

@implementation OFString (GTKCoding)
- (instancetype)initWithCoder:(GTKCoder *)decoder
{
    OFString *value = [[decoder attributeForName: @"GTKKit.GTKCoding.string"] stringValue];

    self = [self initWithString: value];

    return self;
}

- (void)encodeWithCoder:(GTKCoder *)encoder
{
    [encoder addAttributeWithName: @"GTKKit.GTKCoding.string"
                      stringValue: self];
}
@end
