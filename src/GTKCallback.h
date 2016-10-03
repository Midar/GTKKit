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

#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "defines.h"

@class GTKCallback;

typedef void (^GTKCallbackBlock)();

/*!
 * @brief A class representing callbacks into the GTK+ thread.
 *
 * This class encapsulates the annoying GTK+ "idle callback" method of
 * inter-thread communication and hides it behind a simple block-based
 * API; given a block, this class's public methdod run that block inside
 * the GTK+ thread, either synchronously or asynchronously, depending on
 * which method is used.  Note that the code in the block will be run as an
 * idle-time callback in the GTK+ thread, so it's probably a very bad idea
 * to put any long-running function calls or endless loops in the block, or
 * you risk bogging down the user interface. Instead, put your long-running
 * code into an OFThread which itself calls into the GTK+ thread at need using
 * this class.
 *
 * As each instance of this class represents a single callback to the GTK+
 * thread, there isn't much point retaining the isnstances -- and thus, the
 * public interface wraps that in class methods that create temporary
 * instances for a single use, which are then discarded.
 */
@interface GTKCallback: OFObject
{
    GTKCallbackBlock _block;
    GMutex *_mutex;
    GCond *_cond;
    gboolean _flag;
}

/*!
 * @brief Run the given block in the GTK+ thread synchronously.
 *
 * This means that this method will not return until the block you provide
 * does.
 *
 * @param block The block to run
 */
+ (void)sync:(GTKCallbackBlock)block;

/*!
 * @brief Run the given block in the GTK+ thread asynchronously.
 *
 * This means that this method returns almost immediately, regardless of the
 * code in the block you supply.
 *
 * @param block The block to run
 */
+ (void)async:(GTKCallbackBlock)block;
@end
