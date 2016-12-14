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

@interface GTKBackgroundDispatchQueue: GTKDispatchQueue
@property (nonnull) OFThread *thread;
- initWithLabel: (OFString *)label
       priority: (float)priority;
@end

@interface GTKMainDispatchQueue: GTKDispatchQueue
@end

@interface GTKGUIDispatchQueue: GTKDispatchQueue
@end

@interface GTKCallback: OFObject
@property (copy) DispatchWorkItem  block;
@property        GMutex           *mutex;
@property        GCond            *cond;
@property        gboolean          flag;
- (void)lock;
- (void)unlock;
- (void)wait;
- (void)signal;
- (void)async: (DispatchWorkItem)block;
- (void)sync: (DispatchWorkItem)block;
@end

static gboolean
runBlockInGTKThreadCallback (gpointer userdata)
{
	GTKCallback *callback = (__bridge_transfer GTKCallback *) userdata;
	[callback lock];
	callback.block();
	callback.flag = true;
	[callback signal];
	[callback unlock];
	return false;
}

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
	static GTKDispatchQueue *backgroundQueue;
	if (backgroundQueue == nil) {
		backgroundQueue = [GTKBackgroundDispatchQueue queueWithLabel: @"Default Background Queue"
								    priority: 0.5];
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

- (void)sync: (DispatchWorkItem)block
{

}

- (void)async: (DispatchWorkItem)block
{

}

- (void)asyncAfter: (unsigned int)seconds
	   execute: (_Nonnull DispatchWorkItem)block
{

}

- (void)asyncRepeatAfter: (unsigned int)seconds
		 execute: (_Nonnull DispatchWorkItem)block
{

}

+ (nonnull GTKDispatchQueue *)queueWithLabel: (nonnull OFString *)label
				    priority: (float)priority
{
	GTKBackgroundDispatchQueue *queue = \
		[[GTKBackgroundDispatchQueue alloc] initWithLabel: label
							 priority: priority];
	return queue;
}

+ (nonnull GTKDispatchQueue *)queueWithLabel: (nonnull OFString *)label
{
	GTKBackgroundDispatchQueue *queue = \
		[[GTKBackgroundDispatchQueue alloc] initWithLabel: label
							 priority: 0.5];
	return queue;
}
@end

@implementation GTKBackgroundDispatchQueue
- init
{
	self = [super init];
	self.label = @"Background Queue";
	self.thread = [OFThread thread];
	[self.thread start];
	return self;
}

- initWithLabel: (OFString *)label
       priority: (float)priority
{
	self = [super init];
	self.label = label;
	self.thread = [OFThread new];
	self.thread.priority = priority;
	[self.thread start];
	return self;
}

- (void)sync: (DispatchWorkItem)block
{
	if (OFThread.currentThread == self.thread) {
		block();
	} else {
		OFTimer *timer = [OFTimer timerWithTimeInterval: 0
							repeats: false
							  block: ^ (OFTimer *timer) { block(); }];
		[self.thread.runLoop addTimer: timer];
		[timer waitUntilDone];
	}
}

- (void)async: (DispatchWorkItem)block
{
	if (OFThread.currentThread == self.thread) {
		OFThread *thread = [OFThread threadWithThreadBlock: ^id _Nullable {
			[self async: block];
			return nil;
		 }];
		[thread start];
	} else {
		OFTimer *timer = [OFTimer timerWithTimeInterval: 0
							repeats: false
							  block: ^ (OFTimer *timer) { block(); }];
		[self.thread.runLoop addTimer: timer];
	}
}

- (void)asyncAfter: (unsigned int)seconds
	   execute: (_Nonnull DispatchWorkItem)block
{
	OFTimer *timer = [OFTimer timerWithTimeInterval: seconds
						repeats: false
						  block: ^ (OFTimer *timer) { block(); }];
	[self.thread.runLoop addTimer: timer];
}

- (void)asyncRepeatAfter: (unsigned int)seconds
		 execute: (_Nonnull DispatchWorkItem)block
{
	OFTimer *timer = [OFTimer timerWithTimeInterval: seconds
						repeats: true
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

- (void)sync: (DispatchWorkItem)block
{
	if (of_thread_is_current(gtkkit_objfw_thread)) {
		block();
	} else {
		OFTimer *timer = [OFTimer timerWithTimeInterval: 0
							repeats: false
							  block: ^ (OFTimer *timer) { block(); }];
		[[OFRunLoop mainRunLoop] addTimer: timer];
		[timer waitUntilDone];
	}
}

- (void)async: (DispatchWorkItem)block
{
	if (of_thread_is_current(gtkkit_objfw_thread)) {
		block();
	} else {
		OFTimer *timer = [OFTimer timerWithTimeInterval: 0
							repeats: false
							  block: ^ (OFTimer *timer) { block(); }];
		[[OFRunLoop mainRunLoop] addTimer: timer];
	}
}

- (void)asyncAfter: (unsigned int)seconds
	   execute: (_Nonnull DispatchWorkItem)block
{
	OFTimer *timer = [OFTimer timerWithTimeInterval: seconds
						repeats: false
						  block: ^ (OFTimer *timer) { block(); }];
	[[OFRunLoop mainRunLoop] addTimer: timer];
}

- (void)asyncRepeatAfter: (unsigned int)seconds
		 execute: (_Nonnull DispatchWorkItem)block
{
	OFTimer *timer = [OFTimer timerWithTimeInterval: seconds
						repeats: true
						  block: ^ (OFTimer *timer) { block(); }];
	[[OFRunLoop mainRunLoop] addTimer: timer];
}
@end

@implementation GTKCallback
- init
{
	self = [super init];
	self.mutex = g_malloc0(sizeof(GMutex));
	self.cond = g_malloc0(sizeof(GCond));
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
	g_free(self.mutex);
	g_free(self.cond);
}

- (void)sync: (DispatchWorkItem)block
{
	if (of_thread_is_current(gtkkit_gtk_thread)) {
		block();
	} else {
		self.flag = false;
		[self lock];
		self.block = block;
		g_idle_add(
			runBlockInGTKThreadCallback,
			(__bridge_retained gpointer) self);
		[self wait];
		[self unlock];
		self.flag = false;
	}
}

- (void)async: (DispatchWorkItem)block
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

- (void)sync: (_Nonnull DispatchWorkItem)block
{
	[[GTKCallback new] sync: block];
}

- (void)async: (_Nonnull DispatchWorkItem)block
{
	[[GTKCallback new] async: block];
}

- (void)asyncAfter: (unsigned int)seconds
	   execute: (_Nonnull DispatchWorkItem)block
{
	[[OFThread threadWithThreadBlock: ^id _Nullable (){
		sleep(seconds);
		[[GTKCallback new] sync: block];
		return nil;
	}] start];
}

- (void)asyncRepeatAfter: (unsigned int)seconds
		 execute: (_Nonnull DispatchWorkItem)block
{
	[[OFThread threadWithThreadBlock: ^id _Nullable (){
		while (true) {
			sleep(seconds);
			[[GTKCallback new] sync: block];
		}
		return nil;
	}] start];
}
@end
