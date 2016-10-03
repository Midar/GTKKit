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

#import "GTKCallback.h"

static bool _sharedCallbackInitRun = false;

@interface GTKCallback ()
@property (copy) GTKCallbackBlock block;
@property GMutex *mutex;
@property GCond *cond;
@property gboolean flag;
- (void)lock;
- (void)unlock;
- (void)wait;
- (void)signal;
@end

static gboolean
runBlockInGTKThreadCallback(gpointer userdata)
{
	GTKCallback *callback = (__bridge GTKCallback *)(userdata);
    [callback lock];
    callback.block(callback);
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

- (GTKCallbackBlock)block;
{
	return _block;
}

- (void)setBlock:(GTKCallbackBlock)block
{
	_block = [block copy];
}

- (GCond *)cond;
{
	return _cond;
}

- (void)setCond:(GCond *)cond
{
	_cond = cond;
}

- (GMutex *)mutex;
{
	return _mutex;
}

- (void)setMutex:(GMutex *)mutex
{
	_mutex = mutex;
}

- (gboolean)flag;
{
	return _flag;
}

- (void)setFlag:(gboolean)flag
{
	_flag = flag;
}

+ (instancetype)sharedCallback;
{
	__strong static GTKCallback *_sharedCallback;
	if (_sharedCallbackInitRun == false) {
		_sharedCallback = [self new];
		_sharedCallbackInitRun = true;
	}
	return _sharedCallback;
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

- (void)sync:(GTKCallbackBlock)block
{
    self.flag = false;
    [self lock];
    self.block = block;
    g_idle_add(
		runBlockInGTKThreadCallback,
		(__bridge gpointer)(self));
    [self wait];
    [self unlock];
	self.flag = false;
}

+ (void)sync:(GTKCallbackBlock)block
{
    [self.sharedCallback sync: block];
}

- (void)async:(GTKCallbackBlock)block
{
	[[OFThread threadWithThreadBlock: ^id _Nullable (){
		[GTKCallback sync: block];
		return NULL;
	}] start];
}

+ (void)async:(GTKCallbackBlock)block
{
    [self.sharedCallback async: block];
}
@end
