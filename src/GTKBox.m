/*! @file GTKBox.m
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

#import "GTKBox.h"
#import "GTKApplication.h"
#import "GTKKeyedArchiver.h"
#import "GTKKeyedUnarchiver.h"

@implementation GTKBox
- (void)createMainWidget
{
    [GTKApp.dispatch.gtk sync: ^{
        self.mainWidget = gtk_frame_new(NULL);
    }];
}

+ (instancetype)boxWithLabel:(OFString *)label;
{
    return [[self alloc] initWithLabel: label];
}

- (instancetype)initWithLabel:(OFString *)label;
{
    self = [self init];
    self.label = label;
    return self;
}

- (instancetype)initWithCoder:(GTKKeyedUnarchiver *)decoder
{
	self = [super initWithCoder: decoder];
    self.label = [decoder decodeStringForKey: @"GTKKit.coding.box.label"];
    return self;
}

- (void)encodeWithCoder:(GTKKeyedArchiver *)encoder
{
    [super encodeWithCoder: encoder];
    [encoder encodeString: self.label forKey: @"GTKKit.coding.box.label"];
}

- (OFString *)label
{
    return _label;
}

- (void)setLabel:(OFString *)label
{
    _label = label;
    [GTKApp.dispatch.gtk sync: ^{
        gtk_frame_set_label(GTK_FRAME(self.mainWidget), label.UTF8String);
    }];
}
@end
