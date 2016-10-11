/*
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

#import "OFCallback.h"

@interface OFCallback ()
- (void)sync:(OFCallbackBlock)block;
- (void)async:(OFCallbackBlock)block;
@end

@implementation OFCallback
- (void)sync:(OFCallbackBlock)block
{
	OFTimer *timer = [OFTimer
		timerWithTimeInterval: 0
		repeats: false
		block: ^ (OFTimer *timer) { block(); }];

	[[OFRunLoop mainRunLoop] addTimer: timer];

	[timer waitUntilDone];
}

+ (void)sync:(OFCallbackBlock)block
{
    [[self new] sync: block];
}

- (void)async:(OFCallbackBlock)block
{
	[[OFThread threadWithThreadBlock: ^id _Nullable (){
		[OFCallback sync: block];
		return nil;
	}] start];
}

+ (void)async:(OFCallbackBlock)block
{
    [[self new] async: block];
}
@end
