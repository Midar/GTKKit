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
#import "GTKOrientable.h"

OF_ASSUME_NONNULL_BEGIN
/*!
 * @brief A class for widgets which display a value as a bar that fills from
 * one side to the other.
 */
@interface GTKLevelBar: GTKWidget <GTKOrientable>
/*!
 * @brief The mode of the level bar.
 *
 * One of the following possible values:
 *
 * - GTK_LEVEL_BAR_MODE_CONTINUOUS
 * - GTK_LEVEL_BAR_MODE_DISCRETE
 * @throws GTKDestroyedWidgetException
 */
@property GtkLevelBarMode mode;
/*!
 * @brief The current value displayed by the level bar.
 * @throws GTKDestroyedWidgetException
 */
@property double value;
/*!
 * @brief The minimum value the level bar can display.
 * @throws GTKDestroyedWidgetException
 */
@property double minValue;
/*!
 * @brief The maximum value the level bar can display.
 * @throws GTKDestroyedWidgetException
 */
@property double maxValue;
/*!
 * @brief Whether or not the level bar's fill grows from the opposite side.
 * @throws GTKDestroyedWidgetException
 */
@property bool inverted;
@end

OF_ASSUME_NONNULL_END
