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

#import "GTKWidget.h"

/*!
 * @brief A protocol for widgets that can scroll their contents.
 */
@protocol GTKScrollable
/*!
 * @brief The horizontal adjustment of the scrollable widget.
 * @throws GTKDestroyedWidgetException
 */
@property GtkAdjustment *horizontalAdjustment;
/*!
 * @brief The vertical adjustment of the scrollable widget.
 * @throws GTKDestroyedWidgetException
 */
@property GtkAdjustment *verticalAdjustment;
/*!
 * @brief The horizontal scrolling policy of the scrollable widget.
 *
 * One of the following possible values:
 *
 * - GTK_SCROLL_MINIMUM (Scrollable adjustments are based on the minimum size)
 * - GTK_SCROLL_NATURAL (Scrollable adjustments are based on the natural size)
 * @throws GTKDestroyedWidgetException
 */
@property GtkScrollablePolicy horizontalScrollingPolicy;
/*!
 * @brief The vertical scrolling policy of the scrollable widget.
 *
 * One of the following possible values:
 *
 * - GTK_SCROLL_MINIMUM (Scrollable adjustments are based on the minimum size)
 * - GTK_SCROLL_NATURAL (Scrollable adjustments are based on the natural size)
 * @throws GTKDestroyedWidgetException
 */
@property GtkScrollablePolicy verticalScrollingPolicy;
@end

/*!
 * @brief A default implementation of the @ref <GTKScrollable> protocol for
 * classes to inherit.
 */
@interface GTKScrollable: GTKWidget <GTKScrollable>
@end
