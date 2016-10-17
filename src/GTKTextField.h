/*! @file GTKTextField.h
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

typedef enum GTKJustification {
    GTKJustificationLeft = GTK_JUSTIFY_LEFT,
    GTKJustificationCenter = GTK_JUSTIFY_CENTER,
    GTKJustificationRight = GTK_JUSTIFY_RIGHT,
    GTKJustificationFill = GTK_JUSTIFY_FILL
} GTKJustification;

@interface GTKTextField: GTKControl
{
    __block bool _editable;
    __block bool _selectable;
    __block gulong _entryActivatedHandlerID;
    __block gulong _insertAtCursorHandlerID;
    __block gulong _textViewFocusOutHandlerID;
    __block GTKJustification _justify;
    __block bool _multiline;
}
@property (getter=isEditable) bool editable;
@property (getter=isContinuous) bool continuous;
@property (getter=isSelectable) bool selectable;
@property GTKJustification justify;
@property (getter=isMultiline) bool multiline;
@end
