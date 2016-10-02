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

@interface GTKCallback ()
@property (copy) GTKCallbackBlock block;
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

- (void)waitForBlock:(GTKCallbackBlock)block
{
    self.flag = false;
    [self lock];
    self.block = block;
    g_idle_add(runBlockInGTKThreadCallback, (__bridge gpointer)(self));
    [self wait];
    [self unlock];
	self.flag = false;
}

+ (void)waitForBlock:(GTKCallbackBlock)block
{
    [[self new] waitForBlock: block];
}
@end
