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

typedef void (^GTKCallbackBlock)(GTKCallback *callback);

/*!
 * @brief A class representing callbacks into the GTK+ thread.
 *
 * This class encapsulates the annoying GTK+ "idle callback" method of
 * inter-thread communication and hides it behind a simple block-based
 * API; given a block, this class's methods execute that block in the
 * GTK+ thread synchronously - that is, it doesn't return until the block
 * does.
 */
@interface GTKCallback: OFObject
{
    GTKCallbackBlock _block;
    GMutex *_mutex;
    GCond *_cond;
    gboolean _flag;
}
/*!
 * @brief Create a GTKCallbackBlock instance, and have it run the given
 * block in the GTK+ thread synchronously.
 *
 * @param block The block to run
 */
+ (void)sync:(GTKCallbackBlock)block;
/*!
 * @brief Run the given block in the GTK+ thread asynchronously.
 *
 * @param block The block to run
 */
+ (void)async:(GTKCallbackBlock)block;
/*!
 * @brief Run the given block in the GTK+ thread synchronously.
 *
 * @param block The block to run
 */
- (void)sync:(GTKCallbackBlock)block;
/*!
 * @brief Run the given block in the GTK+ thread asynchronously.
 *
 * @param block The block to run
 */
- (void)async:(GTKCallbackBlock)block;
@end
