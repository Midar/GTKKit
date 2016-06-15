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

#import "GTKRange.h"

OF_ASSUME_NONNULL_BEGIN

/*!
 * @brief A slider that controls the value of a range.
 */
@interface GTKScale: GTKRange
{
  gulong _valueChangedHandlerID;
  gulong _formatHandlerID;
}

/*!
 * @brief The number of digits of the value used when it is displayed.
 * @throws GTKDestroyedWidgetException
 */
@property int digits;

/*!
 * @brief The selector sent to the scale's target when the value changes.
 */
@property (nullable) SEL action;

/*!
 * @brief The object which is sent a message whe the value of the scale
 * changes.
 */
@property (nullable, weak) id target;

/*!
 * @brief The printf-style string used in formatting the displayed value of
 * the scale.
 */
@property OFConstantString *formatString;
@end

OF_ASSUME_NONNULL_END
