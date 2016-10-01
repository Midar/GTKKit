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

#import "GTKInvisible.h"

GtkWidget *
gtkkit_gtk_invisible_new()
{
	GTKCallbackInfo *info = makeGTKCallbackInfo();

	// Lock the mutex. This prevents the callback from doing anything until
	// we reach g_cond_wait() below.
	g_mutex_lock(info->mutex);

    // Register the callback.
    g_idle_add(gtkkit_callback_gtk_invisible_new, info);

    // Unlock the mutex, then wait for the callback to complete, then lock
	// the mutex again.
	while(info->flag == false) {
		g_cond_wait(info->cond, info->mutex);
	}

    // Unlock the mutex.
    g_mutex_unlock(info->mutex);

    // Now that the callback has returned, we can extract the return value.
    GtkWidget *widget = info->data.widgetValue;

    // Now we dispose of the struct's memory.
    freeGTKCallbackInfo(info);

    // And return the return value.
    return widget;
}

gboolean
gtkkit_callback_gtk_invisible_new(gpointer userdata)
{
	// Cast the argument to the appropriate type.
    GTKCallbackInfo *info = (GTKCallbackInfo *)userdata;

	// Lock the mutex.
    g_mutex_lock(info->mutex);

	// Perform the GTK+ calls.
    info->data.widgetValue = gtk_invisible_new();

	// Clear the flags and return.
    info->flag = true;
    g_cond_signal(info->cond);
    g_mutex_unlock(info->mutex);
    return false;
}
