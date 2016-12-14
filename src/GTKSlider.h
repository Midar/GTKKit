/*! @file GTKSlider.h
 *
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

#import "GTKControl.h"
#import "GTKOrientable.h"
#import "GTKPositionType.h"

/*!
 * @brief A class representing a control that sets a numeric value in a given
 * range.
 */
@interface GTKSlider: GTKControl <GTKOrientable>
{
	__block GTKOrientation _orientation;
	__block double _min;
	__block double _max;
	__block bool _restrict;
	__block double _fillLevel;
	__block bool _showFillLevel;
	__block bool _inverted;
	__block double _increment;
	__block int _roundDigits;
	__block bool _showValue;
	__block GTKPositionType _valuePosition;
	__block bool _highlightOrigin;
	__block unsigned int _numberOfTickMarks;
}

/*!
 * @brief The minimum value the slider can represent.
 */
@property double minValue;

/*!
 * @brief The maximum value the slider can represent.
 */
@property double maxValue;

/*!
 * @brief Whether or not the index of the slider is restricted to its fill level.
 */
@property bool restrictToFillLevel;

/*!
 * @brief The fill level of the slider.
 */
@property double fillLevel;

/*!
 * @brief Whether or not the fill level is shown graphically in the slider.
 */
@property bool showFillLevel;

/*!
 * @brief Whether or not the slider is inverted.
 */
@property (getter=isInverted) bool inverted;

/*!
 * @brief The increment moving the slider with the arrow keys moves the slider.
 */
@property double increment;

/*!
 * @brief The number of significant digits to display of the value.
 */
@property int roundDigits;

/*!
 * @brief Whether or not to display the current value of the slider.
 */
@property bool showValue;

/*!
 * @brief The position of the value when it is displayed.
 */
@property GTKPositionType valuePosition;

/*!
 * @brief Whether or not to highlight the origin of the slider.
 */
@property bool highlightOrigin;

/*!
 * @brief The number of tick marks on the slider, distributed evenly across its
 * width.
 */
@property unsigned int numberOfTickMarks;
@end
