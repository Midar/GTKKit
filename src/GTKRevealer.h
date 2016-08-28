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
 * @brief A container that can show and hide its child using animation.
 *
 * You would wrap your widget in a GTKRevealer when you want to be able to add
 * the ability to animate the revealing and concealing of that widget.
 */
@interface GTKRevealer: GTKBin
/*!
 * Whether or not the child widget is fully revealed.
 *
 * @throws GTKDestroyedWidgetException
 */
@property (readonly) bool revealed;

/*!
 * The duration of the transition animation, in milliseconds.
 *
 * @throws GTKDestroyedWidgetException
 */
@property unsigned int transitionDuration;

/*!
 * The transition animation type used by the revealer.
 *
 * One of the following possible values:
 *
 * - GTK_REVEALER_TRANSITION_TYPE_NONE
 * - GTK_REVEALER_TRANSITION_TYPE_CROSSFADE
 * - GTK_REVEALER_TRANSITION_TYPE_SLIDE_RIGHT
 * - GTK_REVEALER_TRANSITION_TYPE_SLIDE_LEFT
 * - GTK_REVEALER_TRANSITION_TYPE_SLIDE_UP
 * - GTK_REVEALER_TRANSITION_TYPE_SLIDE_DOWN
 *
 * @throws GTKDestroyedWidgetException
 */
@property GtkRevealerTransitionType transitionType;

/*!
 * @brief Tells the revealer to reveal its child.
 *
 * @throws GTKDestroyedWidgetException
 */
- (void)revealChild;

/*!
 * @brief Tells the revealer to conceal its child.
 *
 * @throws GTKDestroyedWidgetException
 */
- (void)concealChild;
@end

OF_ASSUME_NONNULL_END
