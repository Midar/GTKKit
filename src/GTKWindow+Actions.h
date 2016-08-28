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

#import "GTKContainer.h"
#import "GTKWindow.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKWindow (Actions)
/*!
 * @brief Show the window to the user.
 *
 * This may mean unminimizing it, stealing focus, etc.
 *
 * @throws GTKDestroyedWidgetException
 */
- (void)present;

/*!
 * @brief Activates the default widget of the window.
 *
 * @throws GTKDestroyedWidgetException
 */
- (bool)activateDefaultWidget;

/*!
 * @brief Activates the focused widget of the window.
 *
 * @throws GTKDestroyedWidgetException
 */
- (bool)activateFocusedWidget;

/*!
 * @brief Close the window.
 *
 * @throws GTKDestroyedWidgetException
 */
- (void)close;

/*!
 * @brief Minimize the window.
 *
 * @throws GTKDestroyedWidgetException
 */
- (void)minimize;

/*!
 * @brief Unminimize the window.
 *
 * @throws GTKDestroyedWidgetException
 */
- (void)unminimize;

/*!
 * @brief Maximize the window.
 *
 * @throws GTKDestroyedWidgetException
 */
- (void)maximize;

/*!
 * @brief Unmaximize the window.
 *
 * @throws GTKDestroyedWidgetException
 */
- (void)unmaximize;

/*!
 * @brief Make the window fullscreen.
 *
 * @throws GTKDestroyedWidgetException
 */
- (void)fullscreen;

/*!
 * @brief Make the window not fullscreen.
 *
 * @throws GTKDestroyedWidgetException
 */
- (void)unfullscreen;
@end

OF_ASSUME_NONNULL_END
