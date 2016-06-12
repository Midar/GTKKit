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

@interface GTKWindow (Properties)
/*!
 * @brief The title of the window.
 * @throws GTKDestroyedWidgetException
 */
@property OFString *title;
/*!
 * @brief Whether or not the window is resizable.
 * @throws GTKDestroyedWidgetException
 */
@property bool resizable;
/*!
 * @brief Whether or not the window prevents interacting with any other windows
 * in the same application.
 * @throws GTKDestroyedWidgetException
 */
@property bool modal;
/*!
 * @brief The position of the window. Note that it is impossible to guarantee
 * this will be pixel-accurate, as window systems are inconsistent in their
 * handling of window positions.
 * @throws GTKDestroyedWidgetException
 */
@property of_point_t position;
/*!
 * @brief The window for which this window is transient.
 * @throws GTKDestroyedWidgetException
 */
@property GTKWindow *transientForWindow;
/*!
 * @brief The window to which this window is attached.
 * @throws GTKDestroyedWidgetException
 */
@property GTKWindow *attachedToWindow;
/*!
 * @brief Whether or not this window should be destroyed with its parent.
 * @throws GTKDestroyedWidgetException
 */
@property bool destroyWithParent;
/*!
 * @brief Whether or not the window is maximized.
 * @throws GTKDestroyedWidgetException
 */
@property (readonly) bool maximized;
/*!
 * @brief Whether or not the window should be decorated.
 * @throws GTKDestroyedWidgetException
 */
@property bool decorated;
/*!
 * @brief Whether or not the window should be closable.
 * @throws GTKDestroyedWidgetException
 */
@property bool deletable;
/*!
 * @brief Whether or not the window is active.
 * @throws GTKDestroyedWidgetException
 */
@property (readonly) bool active;
/*!
 * @brief Whether or not the window should hide its titlebar when maximized.
 * @throws GTKDestroyedWidgetException
 */
@property bool hideTitlebarWhenMaximized;
/*!
 * @brief The custom widget to use for a titlebar. If this is set, GTK+ will
 * make its best efforts to disable the system's window toolbar as well.
 *
 * This is primarily intended for use with the @ref GTKHeaderBar widget.
 * @throws GTKDestroyedWidgetException
 */
@property GTKWidget *titlebar;
@end

OF_ASSUME_NONNULL_END
