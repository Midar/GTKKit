/*! @file GTKActionConnection.m
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

#import "GTKActionConnection.h"
#import "GTKCoder.h"
#import "GTKKeyedArchiver.h"
#import "GTKKeyedUnarchiver.h"

@implementation GTKActionConnection
- (instancetype)initWithCoder:(GTKKeyedUnarchiver *)decoder
{
	self = [super init];
	self.objectKeyPath = [decoder decodeStringForKey: @"GTKKit.coding.actionConnection.objectKeyPath"];
	self.targetKeyPath = [decoder decodeStringForKey: @"GTKKit.coding.actionConnection.targetKeyPath"];
	self.actionSelector = [decoder decodeSelectorforKey: @"GTKKit.coding.actionConnection.actionSelector"];
  	return self;
}

- (void)encodeWithCoder:(GTKKeyedArchiver *)encoder
{
	[encoder encodeString: self.objectKeyPath forKey: @"GTKKit.coding.actionConnection.objectKeyPath"];
	[encoder encodeString: self.targetKeyPath forKey: @"GTKKit.coding.actionConnection.targetKeyPath"];
	[encoder encodeSelector: self.actionSelector forKey: @"GTKKit.coding.actionConnection.actionSelector"];
}
@end
