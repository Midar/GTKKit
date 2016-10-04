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

of_thread_t gtkkit_gtk_thread;
of_thread_t gtkkit_objfw_thread;
const of_thread_attr_t gtkkit_objfw_thread_attr;

static gboolean
runInGTKThreadCallback(gpointer userdata)
{
	GTKCallbackBlock block = (__bridge_transfer GTKCallbackBlock)(userdata);
    block();
    return false;
}

void
GTKCallback(GTKCallbackBlock block)
{
	gpointer userdata = (__bridge_retained gpointer)(block);
	g_main_context_invoke(NULL, runInGTKThreadCallback, userdata);
}

void
ObjFWCallback(GTKCallbackBlock block)
{
	OFTimer *timer = [OFTimer
		timerWithTimeInterval: 0
		repeats: false
		block: ^ (OFTimer *timer) { block(); }];

	[[OFRunLoop mainRunLoop] addTimer: timer];

	[timer waitUntilDone];
}
