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

/*! @file GTKWindowDelegate.h */

#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>

OF_ASSUME_NONNULL_BEGIN

/*!
 * @brief A protocol composed of the optional methods GTKWindowViewController
 *	  delegate classes can implement.
 */
@protocol GTKWindowDelegate
@optional

/*!
 * @brief Ask the delegete whether or not the window should allow itself to be
 *	  closed.
 */
- (bool)windowShouldClose;

/*!
 * @brief Inform the delegate that the window will be closed.
 */
- (void)windowWillClose;

/*!
 * @brief Inform the delegate that the window has been closed.
 */
- (void)windowDidClose;

/*!
 * @brief Ask the delegate whether or not the window should allow itself to be
 *	  minimized.
 */
- (bool)windowShouldMinimize;

/*!
 * @brief Inform the delegate that the window will be minimized.
 */
- (void)windowWillMinimize;

/*!
 * @brief Inform the delegate that the window has been minimized.
 */
- (void)windowDidMinimize;

/*!
 * @brief Ask the delegate whether or not the window should allow itself to be
 *	  maximized.
 */
- (bool)windowShouldMaximize;

/*!
 * @brief Inform the delegate that the window will be maximized.
 */
- (void)windowWillMaximize;

/*!
 * @brief Inform the delegate that the window has been maximized.
 */
- (void)windowDidMaximize;
@end

OF_ASSUME_NONNULL_END
