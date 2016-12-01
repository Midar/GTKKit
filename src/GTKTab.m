/*! @file GTKTab.m
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

#import "GTKTab.h"
#import "GTKKeyedArchiver.h"
#import "GTKKeyedUnarchiver.h"

@implementation GTKTab
- init
{
    self = [super init];
    self.tag = -1;
    self.contentView = [GTKView new];
    return self;
}

- (instancetype)initWithCoder:(GTKKeyedUnarchiver *)decoder
{
	self = [self init];
    self.tag = [decoder decodeIntForKey: @"GTKKit.coding.tab.tag"];
    self.contentView = [decoder decodeObjectForKey: @"GTKKit.coding.tab.contentView"];
    return self;
}

- (void)encodeWithCoder:(GTKKeyedArchiver *)encoder
{
    [encoder encodeInt: self.tag forKey: @"GTKKit.coding.tab.tag"];
    [encoder encodeObject: self.contentView forKey: @"GTKKit.coding.tab.contentView"];
}
@end
