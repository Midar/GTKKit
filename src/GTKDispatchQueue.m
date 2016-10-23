/*! @file GTKDispatchQueue.m
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

#import "GTKDispatchQueue.h"
#import "GTKMainDispatchQueue.h"
#import "GTKBackgroundDispatchQueue.h"
#import "GTKGUIDispatchQueue.h"

@implementation GTKDispatchQueue
+ main
{
    static GTKMainDispatchQueue *mainQueue;
    if (mainQueue == nil) {
        mainQueue = [GTKMainDispatchQueue new];
    }
    return mainQueue;
}

+ background
{
    static GTKBackgroundDispatchQueue *backgroundQueue;
    if (backgroundQueue == nil) {
        backgroundQueue = [GTKBackgroundDispatchQueue new];
    }
    return backgroundQueue;
}

+ gtk
{
    static GTKGUIDispatchQueue *gtkQueue;
    if (gtkQueue == nil) {
        gtkQueue = [GTKGUIDispatchQueue new];
    }
    return gtkQueue;
}

- init
{
    self = [super init];
    self.label = @"";
    return self;
}

- (void)sync:(DispatchWorkItem)block
{

}

- (void)async:(DispatchWorkItem)block
{

}

+ (nonnull GTKBackgroundDispatchQueue *)backgroundQueueWithLabel:(nonnull OFString *)label
{
	GTKBackgroundDispatchQueue *queue = [GTKBackgroundDispatchQueue new];
	queue.label = label;
	return queue;
}
@end
