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
 * @brief A context-dependent bubble pop-up. This class implements the
 * target-action pattern in response to the pop-up being closed/dismissed.
 */
@interface GTKPopover: GTKBin
{
  gulong _closedHandlerID;
}
/*!
 * @brief The selector of the method to be used as the action when the popover
 * is closed.
 */
@property (nullable) SEL action;
/*!
 * @brief The object that will act as the target when this popover is closed.
 */
@property (weak, nullable) id target;
/*!
 * @brief The widget to which this popover is attached.
 *
 * @throws GTKDestroyedWidgetException
 */
@property GTKWidget *attachedWidget;
/*!
 * @brief The widget to make the default widget while this popover is visible;
 * when the popover is dismissed, the previous default will be restored.
 *
 * @throws GTKDestroyedWidgetException
 */
@property GTKWidget *defaultWidget;
/*!
 * @brief The position, relative to the attached widget, that the popover
 * should use.
 *
 * One of the following possible values:
 *
 * - GTK_POS_LEFT
 * - GTK_POS_RIGHT
 * - GTK_POS_TOP
 * - GTK_POS_BOTTOM
 *
 * @throws GTKDestroyedWidgetException
 */
@property GtkPositionType position;
/*!
 * @brief Whether or not the popover should be modal, i.e. if it should grab
 * all the input for the window, including keyboard focus.
 *
 * @throws GTKDestroyedWidgetException
 */
@property bool modal;
/*!
 * @brief Whether or not the popover should use transition animations on
 * show/hide.
 *
 * @throws GTKDestroyedWidgetException
 */
@property bool enableTransitions;
/*!
 * @brief Create a popover attached to the specified widget.
 *
 * @param widget The widget to which the popover should be attached.
 */
+ (instancetype)popoverAttachedToWidget:(GTKWidget*)widget;
/*!
 * @brief Initialize this popover attached to the specified widget.
 *
 * @param widget The widget to which this popover should be attached.
 */
- initAttachedToWidget:(GTKWidget*)widget;
@end

OF_ASSUME_NONNULL_END
