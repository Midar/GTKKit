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

@interface GTKWidget (Actions)
/*!
 * @brief Marks the widget as visible.
 *
 * If the widget is marked visible, but the parent container is not, the widget
 * will not be shown.
 * @throws GTKDestroyedWidgetException
 */
- (void)show;
/*!
 * @brief Marks the widget and all the widgets it contains as visible.
 *
 * If the widget is marked visible, but the parent container is not, the widget
 * will not be shown.
 * @throws GTKDestroyedWidgetException
 */
- (void)showAll;
/*!
 * @brief Destroys the widget.
 *
 * This causes GTK+ to destroy the wrapped widget. It will break any references
 * it holds to other objects, and GTKKit's built-in destruction event handler
 * will unreference the widget and set the wrapper object's internal reference
 * to the widget to NULL.
 * @throws GTKDestroyedWidgetException
 */
- (void)destroy;
/*!
 * @brief Marks the widget as hidden.
 * @throws GTKDestroyedWidgetException
 */
- (void)hide;
/*!
 * @brief Activates the widget as if it had been clicked.
 * @throws GTKDestroyedWidgetException
 */
- (bool)activate;
/*!
 * @brief Makes the widget the focused widget.
 * @throws GTKDestroyedWidgetException
 */
- (void)grabFocus;
/*!
 * @brief Makes the widget the default widget.
 * @throws GTKDestroyedWidgetException
 */
- (void)grabDefault;
@end

OF_ASSUME_NONNULL_END
