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

#import "GTKScale.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKScale (Properties)
/*!
 * Whether or not to display the value of the scale as text.
 *
 * @throws GTKDestroyedWidgetException
 */
@property bool showValue;

/*!
 * Whether or not the area between the lowest value of the scale and the
 * current value of the scale will be highlighted.
 *
 * @throws GTKDestroyedWidgetException
 */
@property bool hasOrigin;

/*!
 * The position of the displayed value of the scale.
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
@property GtkPositionType valuePosition;

/*!
 * The current value of the scale, formatted using the scale's format string.
 *
 * @throws GTKDestroyedWidgetException
 */
@property (readonly) OFString *formattedValue;

/*!
 * @brief Adds a mark on the scale at the specified value and position, with
 *	  the specified text.
 *
 * @param value The value at which to place the mark.
 * @param position The position of the mark. (see @ref valuePosition)
 * @param text The text to show at the mark.
 * @throws GTKDestroyedWidgetException
 */
- (void)addMarkAtValue: (double)value
	  withPosition: (GtkPositionType)position
	      withText: (OFString*)text;

/*!
 * @brief Adds a mark on the scale at the specified value, using the default
 *	  position.
 *
 * @param value The value at which to place the mark.
 * @throws GTKDestroyedWidgetException
 */
- (void)addMarkAtValue: (double)value;

/*!
 * @brief Adds a mark on the scale at the specified value and position.
 *
 * @param value The value at which to place the mark.
 * @param position The position of the mark. (see @ref valuePosition)
 * @throws GTKDestroyedWidgetException
 */
- (void)addMarkAtValue: (double)value
	  withPosition: (GtkPositionType)position;

/*!
 * @brief Adds a mark on the scale at the specified value in the default
 *	  position, with the specified text.
 *
 * @param value The value at which to place the mark.
 * @param text The text to show at the mark.
 * @throws GTKDestroyedWidgetException
 */
- (void)addMarkAtValue: (double)value
	      withText: (OFString*)text;

/*!
 * @brief Remove all marks from the scale.
 *
 * @throws GTKDestroyedWidgetException
 */
- (void)clearMarks;
@end

OF_ASSUME_NONNULL_END
