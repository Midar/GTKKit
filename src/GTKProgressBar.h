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
 * @brief A class for displaying the progress of a task as a filling bar.
 */
@interface GTKProgressBar: GTKWidget <GTKOrientable>
/*!
 * @brief The current value being displayed.
 * @throws GTKDestroyedWidgetException
 */
@property double value;

/*!
 * @brief Whether or not to fill in the progress bar from the opposite side.
 * @throws GTKDestroyedWidgetException
 */
@property bool inverted;

/*!
 * @brief Whether or not to show the text value next to the progress bar.
 * @throws GTKDestroyedWidgetException
 */
@property bool showText;

/*!
 * @brief The text to show next to the progress bar. If this is NULL, the
 * current value as a percentage will be shown instead.
 * @throws GTKDestroyedWidgetException
 */
@property OFString *text;

/*!
 * @brief Whether or not to ellipsize the text.
 * @throws GTKDestroyedWidgetException
 */
@property bool ellipsize;

/*!
 * @brief The amount by which to increase the value each time the -pulse method
 * runs.
 * @throws GTKDestroyedWidgetException
 */
@property double pulseStep;

/*!
 * @brief Tell the progress bar to increment its value.
 * @throws GTKDestroyedWidgetException
 */
- (void)pulse;
@end

OF_ASSUME_NONNULL_END
