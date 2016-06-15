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

OF_ASSUME_NONNULL_BEGIN

@interface GTKWidget (Properties)
/*!
 * @brief The name of the widget.
 * @throws GTKDestroyedWidgetException
 */
@property OFString *name;

/*!
 * @brief Whether the widget can be interacted with.
 * @throws GTKDestroyedWidgetException
 */
@property bool sensitive;

/*!
 * @brief If the widget is sensitive but the parent is not, this will be false,
 * and the widget will be treated as if it were not sensitive.
 * @throws GTKDestroyedWidgetException
 */
@property (readonly) bool effectiveSensitivity;

/*!
 * @brief The requested opacity of the widget.
 *
 * In the case of a toplevel window, this relies on the windowing system.
 * @throws GTKDestroyedWidgetException
 */
@property double opacity;

/*!
 * @brief Whether or not the widget is the focus widget for its window.
 * @throws GTKDestroyedWidgetException
 */
@property (readonly) bool isFocus;

/*!
 * @brief The horizontal alignment of the widget.
 *
 * If there is extra horizontal space in the widget's container, this property
 * determines whether the widget will be aligned to the left, the centre, or to
 * the right, using the following possible values:
 *
 * - GTK_ALIGN_FILL (Make the widget take up all available space)
 * - GTK_ALIGN_START (Align the widget to the left)
 * - GTK_ALIGN_END (Align the widget to the right)
 * - GTK_ALIGN_CENTER (Align the widget to the center)
 * - GTK_ALIGN_BASELINE (Align the widget to the baseline)
 * @throws GTKDestroyedWidgetException
 */
@property GtkAlign horizontalAlign;

/*!
 * @brief The vertical alignment of the widget.
 *
 * If there is extra horizontal space in the widget's container, this property
 * determines whether the widget will be aligned to the top, the middle, or to
 * the bottom, using the following possible values:
 *
 * - GTK_ALIGN_FILL (Make the widget take up all available space)
 * - GTK_ALIGN_START (Align the widget to the top)
 * - GTK_ALIGN_END (Align the widget to the bottom)
 * - GTK_ALIGN_CENTER (Align the widget to the middle)
 * - GTK_ALIGN_BASELINE (Align the widget to the baseline)
 * @throws GTKDestroyedWidgetException
 */
@property GtkAlign verticalAlign;

/*!
 * @brief The margin of the widget on the starting side (left in left-to-right
 * text directions, right in right-to-left).
 * @throws GTKDestroyedWidgetException
 */
@property int marginStart;

/*!
 * @brief The margin of the widget on the ending side (right in left-to-right
 * text directions, left in right-to-left).
 * @throws GTKDestroyedWidgetException
 */
@property int marginEnd;

/*!
 * @brief The margin of the widget on the top side.
 * @throws GTKDestroyedWidgetException
 */
@property int marginTop;

/*!
 * @brief The margin of the widget on the bottom side.
 * @throws GTKDestroyedWidgetException
 */
@property int marginBottom;

/*!
 * @brief Whether or not the widget expands to consume all avlailable space in
 * its container in the horizontal axis.
 * @throws GTKDestroyedWidgetException
 */
@property bool expandHorizontal;

/*!
 * @brief Whether or not the widget expands to consume all avlailable space in
 * its container in the vertical axis.
 * @throws GTKDestroyedWidgetException
 */
@property bool expandVertical;

/*!
 * @brief The width the widget requests.
 *
 * If the value of this propery is -1, the "natural" width will be used.
 * @throws GTKDestroyedWidgetException
 */
@property int widthRequest;

/*!
 * @brief The height the widget requests.
 *
 * If the value of this propery is -1, the "natural" height will be used.
 * @throws GTKDestroyedWidgetException
 */
@property int heightRequest;
@end

OF_ASSUME_NONNULL_END
