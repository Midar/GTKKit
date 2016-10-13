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

#import "defines.h"
#import "GTKControl.h"

typedef OF_ENUM(int, GTKButtonType) {
    GTKPushButton = 0,
    GTKToggleButton = 1,
    GTKCheckButton = 2,
    GTKRadioButton = 3,
    GTKSwitchButton = 4
};

@interface GTKButton: GTKControl
{
    __block GTKButtonType _buttonType;
    __block gulong buttonClickedHandlerID;
}
@property GTKButtonType buttonType;
@end
