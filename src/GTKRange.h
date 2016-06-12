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
 * @brief An abstract parent class for classes which display an adjustent in
 * a value.
 */
@interface GTKRange: GTKWidget <GTKOrientable>
{
  double _min;
  double _max;
}
/*
 * @brief The current fill level of the range.
 * @throws GTKDestroyedWidgetException
 */
@property double fillLevel;
/*
 * @brief Whether or not the range is restricted to the fill level.
 * @throws GTKDestroyedWidgetException
 */
@property bool restrictToFillLevel;
/*
 * @brief Whether or not the range displays the fill level.
 * @throws GTKDestroyedWidgetException
 */
@property bool showFillLevel;
/*
 * @brief Whether the range runs from low to high, or from high to low.
 * @throws GTKDestroyedWidgetException
 */
@property bool inverted;
/*
 * @brief The current value of the range.
 * @throws GTKDestroyedWidgetException
 */
@property double value;
/*
 * @brief The amount by which the value is modified by the arrow keys.
 * @throws GTKDestroyedWidgetException
 */
@property (nonatomic) double stepSize;
/*
 * @brief The number of digits to which to round the value to when it changes.
 * @throws GTKDestroyedWidgetException
 */
@property int roundDigts;
/*
 * @brief The minimum value of the range.
 * @throws GTKDestroyedWidgetException
 */
@property (nonatomic) double minValue;
/*
 * @brief The maximum value of the range.
 * @throws GTKDestroyedWidgetException
 */
@property (nonatomic) double maxValue;
/*
 * @brief Set both the minimum and maximum values of the range in a single
 * message.
 *
 * @param minValue The new minimum value for the range.
 * @param maxValue The new maximum value for the range.
 * @throws GTKDestroyedWidgetException
 */
- (void)minValue:(double)minValue maxValue:(double)maxValue;
@end

OF_ASSUME_NONNULL_END
