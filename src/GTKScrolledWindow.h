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

#import "GTKBin.h"

OF_ASSUME_NONNULL_BEGIN

/*!
 * @brief A container that can scroll in either axis.
 *
 * Counterintuitively, this is not a window in the conventional sense, just a
 * container which holds a single widget and can scroll. This container is
 * appropriate when it is desired to add scrolling capability to another
 * widget.
 */
@interface GTKScrolledWindow: GTKBin
/*!
 * @brief The horizonal adjustment of the scrolled window.
 * @throws GTKDestroyedWidgetException
 */
@property GtkAdjustment *horizontalAdjustment;

/*!
 * @brief The vertical adjustment of the scrolled window.
 * @throws GTKDestroyedWidgetException
 */
@property GtkAdjustment *verticalAdjustment;

/*!
 * @brief The horizontal scrolling policy.
 *
 * One of the following possible values:
 *
 * - GTK_POLICY_ALWAYS
 * - GTK_POLICY_AUTOMATIC
 * - GTK_POLICY_NEVER
 * - GTK_POLICY_EXTERNAL
 * @throws GTKDestroyedWidgetException
 */
@property GtkPolicyType horizontalScrollingPolicy;

/*!
 * @brief The vertical scrolling policy. (see @ref horizontalScrollingPolicy)
 * @throws GTKDestroyedWidgetException
 */
@property GtkPolicyType verticalScrollingPolicy;

/*!
 * @brief The placement of the content with respect to the scrollbars.
 *
 * One of the following possible values:
 *
 * - GTK_CORNER_TOP_LEFT
 * - GTK_CORNER_BOTTOM_LEFT
 * - GTK_CORNER_TOP_RIGHT
 * - GTK_CORNER_BOTTOM_RIGHT
 * @throws GTKDestroyedWidgetException
 */
@property GtkCornerType placement;

/*!
 * @brief The shadow type of the scrolled window.
 *
 * One of the following possible values:
 * - GTK_SHADOW_NONE
 * - GTK_SHADOW_IN
 * - GTK_SHADOW_OUT
 * - GTK_SHADOW_ETCHED_IN
 * - GTK_SHADOW_ETCHED_OUT
 * @throws GTKDestroyedWidgetException
 */
@property GtkShadowType shadowType;

/*!
 * @brief The minimum content width of the scrolled window, or -1 if it is not
 * set.
 * @throws GTKDestroyedWidgetException
 */
@property int minContentWidth;

/*!
 * @brief The minimum content height of the scrolled window, or -1 if it is not
 * set.
 * @throws GTKDestroyedWidgetException
 */
@property int minContentHeight;

/*!
 * @brief Whether or not kinetic scrolling is enabled. This applies only to
 * touchscreen devices.
 * @throws GTKDestroyedWidgetException
 */
@property bool kineticScrollingEnabled;

/*!
 * @brief Whether or not overlay scrolling is enabled.
 * @throws GTKDestroyedWidgetException
 */
@property bool overlayScrollingEnabled;

/*!
 * @brief Whether or not the behaviour of kinetic scrolling shoud be modified to
 * capture the initial event that triggered the scrolling, to play it back if
 * it is meant to go to the child widget.
 * @throws GTKDestroyedWidgetException
 */
@property bool captureButtonPress;
@end

OF_ASSUME_NONNULL_END
