/*! @file GTKBackgroundDispatchQueue.m
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

#import "GTKBackgroundDispatchQueue.h"
#import "GTKApplication.h"

@implementation GTKBackgroundDispatchQueue
- init
{
	self = [super init];
	self.label = @"Background Queue";
	self.thread = [OFThread new];
	[self.thread start];
	return self;
}

- (void)sync:(DispatchWorkItem)block
{
	OFTimer *timer = [OFTimer
			timerWithTimeInterval: 0
			repeats: false
			block: ^ (OFTimer *timer) { block(); }];
	[self.thread.runLoop addTimer: timer];
	[timer waitUntilDone];
}

- (void)async:(DispatchWorkItem)block
{
	OFTimer *timer = [OFTimer
			timerWithTimeInterval: 0
			repeats: false
			block: ^ (OFTimer *timer) { block(); }];
	[self.thread.runLoop addTimer: timer];
}
@end
