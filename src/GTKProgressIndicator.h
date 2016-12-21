/*! @file GTKProgressIndicator.h
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

#import "GTKView.h"
#import "GTKOrientable.h"
#import "GTKApplication.h"


/*!
 * @brief A class representing a view that displays the progress of a task as
 * a bar that fills or pulses back and forth.
 */
@interface GTKProgressIndicator: GTKView <GTKOrientable>
{
	bool           _showLabel;
	OFString      *_stringValue;
	double         _doubleValue;
	bool           _inverted;
	GTKOrientation _orientation;
}

/*!
 * @brief Whether or not to display the string value associated with the progress
 * indicator as a label on the progress indicator.
 */
@property bool showLabel;

/*!
 * @brief Whether or not the progress indicator is inverted.
 */
@property bool inverted;

/*!
 * @brief The string associated with the progress indicator, which may be used
 * as a label.
 */
@property OFString *stringValue;

/*!
 * @brief The value displayed by the progress indicator.
 */
@property double doubleValue;

/*!
 * @brief The value displayed by the progress indicator.
 */
@property int intValue;

/*!
 * @brief The value displayed by the progress indicator.
 */
@property float floatValue;
@end
