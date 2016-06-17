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

OF_ASSUME_NONNULL_BEGIN
/*!
 * @brief A container which holds its children in a stack, with only one of
 * them visible at a time. It is designed to be controlled using a
 * GTKStackSwitcher, but also exposes an API to control it programmatically.
 */
@interface GTKStack: GTKContainer
/*!
 * @brief Whether or not the stack should request the same size for all its
 * children. If this is false, the stack may change size when the visible
 * child changes.
 *
 * @throws GTKDestroyedWidgetException
 */
@property bool homogeneous;

/*!
 * @brief The duration, in milliseconds, of the transition animation used when
 * the stack changes its visible child.
 *
 * @throws GTKDestroyedWidgetException
 */
@property unsigned int transitionDuration;

/*!
 * @brief The type of transition to use when this stack changes the visible
 * child.
 *
 * One of the following possible values:
 *
 * - GTK_STACK_TRANSITION_TYPE_NONE
 * - GTK_STACK_TRANSITION_TYPE_CROSSFADE
 * - GTK_STACK_TRANSITION_TYPE_SLIDE_RIGHT
 * - GTK_STACK_TRANSITION_TYPE_SLIDE_LEFT
 * - GTK_STACK_TRANSITION_TYPE_SLIDE_UP
 * - GTK_STACK_TRANSITION_TYPE_SLIDE_DOWN
 * - GTK_STACK_TRANSITION_TYPE_SLIDE_LEFT_RIGHT
 * - GTK_STACK_TRANSITION_TYPE_SLIDE_UP_DOWN
 * - GTK_STACK_TRANSITION_TYPE_OVER_UP
 * - GTK_STACK_TRANSITION_TYPE_OVER_DOWN
 * - GTK_STACK_TRANSITION_TYPE_OVER_LEFT
 * - GTK_STACK_TRANSITION_TYPE_OVER_RIGHT
 * - GTK_STACK_TRANSITION_TYPE_UNDER_UP
 * - GTK_STACK_TRANSITION_TYPE_UNDER_DOWN
 * - GTK_STACK_TRANSITION_TYPE_UNDER_LEFT
 * - GTK_STACK_TRANSITION_TYPE_UNDER_RIGHT
 * - GTK_STACK_TRANSITION_TYPE_OVER_UP_DOWN
 * - GTK_STACK_TRANSITION_TYPE_OVER_DOWN_UP
 * - GTK_STACK_TRANSITION_TYPE_OVER_LEFT_RIGHT
 * - GTK_STACK_TRANSITION_TYPE_OVER_RIGHT_LEFT
 *
 * @throws GTKDestroyedWidgetException
 */
@property GtkStackTransitionType transitionType;

/*!
 * @brief Whether or not the stack is currently in the middle of a transition
 * animation.
 *
 * @throws GTKDestroyedWidgetException
 */
@property (readonly) bool inTransition;

/*!
 * @brief Whether or not the stack should smoothly change size during the
 * transition animation.
 *
 * @throws GTKDestroyedWidgetException
 */
@property bool interpolateSize;

/*!
 * @brief Adds the specified widget to the stack, identified by the specified
 * name.
 *
 * @throws GTKDestroyedWidgetException
 */
- (void)addWidget:(GTKWidget*)childWidget
         withName:(OFString*)name;

/*!
* @brief Adds the specified widget to the stack, identified by the specified
* name. Also sets the title, to be used in the GTKStackSwitcher that controls
* the stack.
*
* @throws GTKDestroyedWidgetException
*/
- (void)addWidget:(GTKWidget*)childWidget
        withName:(OFString*)name
       withTitle:(OFString*)title;

/*!
 * @brief Gets the child widget with the specified name. You will likely have
 * to cast the result to the appropriate class.
 *
 * @throws GTKDestroyedWidgetException
 */
- (GTKWidget*)childWithName:(OFString*)name;

/*!
 * @brief Make the child with the given name the visible one.
 *
 * @throws GTKDestroyedWidgetException
 */
- (void)showChildWithName:(OFString*)name;

/*!
 * @brief Make the child with the given name the visible one, using the
 * specified transition type.
 *
 * @throws GTKDestroyedWidgetException
 */
- (void)showChildWithName:(OFString*)name
      usingTransitionType:(GtkStackTransitionType)transition;

/*!
 * @brief Gets the name of the currently visible child.
 *
 * @throws GTKDestroyedWidgetException
 */
 - (OFString*)visibleChildName;
@end

OF_ASSUME_NONNULL_END
