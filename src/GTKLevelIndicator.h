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

/*! @file GTKLevelIndicator.h */

#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>

#import "GTKView.h"
#import "GTKOrientable.h"

OF_ASSUME_NONNULL_BEGIN

/*!
 * @brief The modes available to a GTKLevelIndicator.
 */
typedef enum GTKLevelMode {
	/*!
	 * @brief A continuous level indicator, with the level shown as a
	 *	  single bar.
	 */
	GTKLevelModeContinuous = GTK_LEVEL_BAR_MODE_CONTINUOUS,

	/*!
	 * @brief A descrete level indicator, with the level shown in segments.
	 */
	GTKLevelModeDiscrete = GTK_LEVEL_BAR_MODE_DISCRETE
} GTKLevelMode;


/*!
 * @brief A class representing a view that displays a value as a graphical
 *	  level, such as you might see in a volume meter.
 */
@interface GTKLevelIndicator: GTKView <GTKOrientable>
{
	double _minValue;
	double _maxValue;
	GTKLevelMode _mode;
	bool _inverted;
	GTKOrientation _orientation;
}

/*!
 * @brief The mode of the level indicator.
 */
@property GTKLevelMode mode;

/*!
 * @brief The minimum value of the level indicator.
 */
@property double minValue;

/*!
 * @brief The maximum value of the level indicator.
 */
@property double maxValue;

/*!
 * @brief Whether or not the level indicator is inverted.
 */
@property (getter=isInverted) bool inverted;

/*!
 * @brief The value represented by the level indicator.
 */
@property double doubleValue;

/*!
 * @brief The value represented by the level indicator.
 */
@property int intValue;

/*!
 * @brief The value represented by the level indicator.
 */
@property float floatValue;
@end

OF_ASSUME_NONNULL_END
