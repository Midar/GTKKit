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

#import "defines.h"

typedef OF_ENUM(int, GTKEventType) {
    GTKEventTypeKeyDown,
    GTKEventTypeKeyUp,
    GTKEventTypeMouseDown,
    GTKEventTypeMouseUp,
    GTKEventTypeMouseClicked
};

typedef struct GTKEventKeyboardModifiers {
    bool control;
    bool alt;
    bool shift;
} GTKEventKeyboardModifiers;

@interface GTKEvent: OFObject

/*!
 * @brief A class implementing objects which represent an event in the system.
 * It is a general data object, used to represent various kinds of event. As such,
 * it is not likely that all of this object's properties will ever be used at once.
 */
@property GTKEventType type;

@property unsigned int mouseButton;
@property unsigned int mouseX;
@property unsigned int mouseY;

@property double deltaX;
@property double deltaY;
@property double deltaZ;

@property char character;
@property GTKEventKeyboardModifiers modifierKeys;

@end
