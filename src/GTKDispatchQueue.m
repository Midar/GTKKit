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
#import "GTKApplication.h"

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

+ (nonnull GTKDispatchQueue *)queueWithLabel:(nonnull OFString *)label
{
	GTKBackgroundDispatchQueue *queue = [GTKBackgroundDispatchQueue new];
	queue.label = label;
	return queue;
}
@end

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

@implementation GTKMainDispatchQueue
- init
{
	self = [super init];
	self.label = @"Main Dispatch Queue";
	return self;
}

- (void)sync:(DispatchWorkItem)block
{
	if (of_thread_is_current(gtkkit_objfw_thread)) {
	    block();
	} else {
		OFTimer *timer = [OFTimer
			timerWithTimeInterval: 0
			repeats: false
			block: ^ (OFTimer *timer) { block(); }];
		[[OFRunLoop mainRunLoop] addTimer: timer];
		[timer waitUntilDone];
	}
}

- (void)async:(DispatchWorkItem)block
{
	if (of_thread_is_current(gtkkit_objfw_thread)) {
	    block();
	} else {
		OFTimer *timer = [OFTimer
			timerWithTimeInterval: 0
			repeats: false
			block: ^ (OFTimer *timer) { block(); }];
		[[OFRunLoop mainRunLoop] addTimer: timer];
	}
}
@end

@interface GTKCallback: OFObject
@property (copy) DispatchWorkItem block;
@property GMutex *mutex;
@property GCond *cond;
@property gboolean flag;
- (void)lock;
- (void)unlock;
- (void)wait;
- (void)signal;
- (void)async:(DispatchWorkItem)block;
- (void)sync:(DispatchWorkItem)block;
@end

static gboolean
runBlockInGTKThreadCallback(gpointer userdata)
{
	GTKCallback *callback = (__bridge_transfer GTKCallback *)(userdata);
    [callback lock];
    callback.block();
    callback.flag = true;
    [callback signal];
    [callback unlock];
    return false;
}

@implementation GTKCallback
- init
{
    self = [super init];
    self.mutex = calloc(1, sizeof(GMutex));
    self.cond = calloc(1, sizeof(GCond));
    g_mutex_init(self.mutex);
    g_cond_init(self.cond);
    return self;
}

- (void)lock
{
    g_mutex_lock(self.mutex);
}

- (void)unlock
{
    g_mutex_unlock(self.mutex);
}

- (void)wait
{
	// Waiting on the flag is to guard against spurious wakeups, per the
	// Glib documentation.
    while (self.flag == false) {
        g_cond_wait(self.cond, self.mutex);
    }
}

- (void)signal
{
    g_cond_signal(self.cond);
}

- (void)dealloc
{
    g_cond_clear(self.cond);
    g_mutex_clear(self.mutex);
    free(self.mutex);
    free(self.cond);
}

- (void)sync:(DispatchWorkItem)block
{
	if (of_thread_is_current(gtkkit_gtk_thread)) {
	    block();
	} else {
	    self.flag = false;
	    [self lock];
	    self.block = block;
	    g_idle_add(
			runBlockInGTKThreadCallback,
			(__bridge_retained gpointer)(self));
		[self wait];
	    [self unlock];
		self.flag = false;
	}
}

- (void)async:(DispatchWorkItem)block
{
	[[OFThread threadWithThreadBlock: ^id _Nullable (){
		[[GTKCallback new] sync: block];
		return nil;
	}] start];
}
@end

@implementation GTKGUIDispatchQueue
- init
{
	self = [super init];
	self.label = @"GTK+ Dispatch Queue";
	return self;
}

- (void)sync:(_Nonnull DispatchWorkItem)block
{
    [[GTKCallback new] sync: block];
}

- (void)async:(_Nonnull DispatchWorkItem)block
{
    [[GTKCallback new] async: block];
}
@end
