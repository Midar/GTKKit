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

#import "defines.h"
#import "GTKControl.h"

typedef enum GTKSliderOrientation {
    GTKSliderOrientationHorizontal,
    GTKSliderOrientationVertical
} GTKSliderOrientation;

typedef enum GTKPositionType {
    GTKPositionTypeTop = GTK_POS_TOP,
    GTKPositionTypeBottom = GTK_POS_BOTTOM,
    GTKPositionTypeLeft = GTK_POS_LEFT,
    GTKPositionTypeRight = GTK_POS_RIGHT
} GTKPositionType;

@interface GTKSlider: GTKControl
{
    __block GTKSliderOrientation _orientation;
    __block double _min;
    __block double _max;
    __block gulong _valueChangedHandlerID;
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
@property GTKSliderOrientation orientation;
@property double minValue;
@property double maxValue;
@property bool restrictToFillLevel;
@property double fillLevel;
@property bool showFillLevel;
@property (getter=isInverted) bool inverted;
@property double increment;
@property int roundDigits;
@property bool showValue;
@property GTKPositionType valuePosition;
@property bool highlightOrigin;
@property unsigned int numberOfTickMarks;
@end
