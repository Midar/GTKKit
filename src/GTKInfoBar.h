/*! @file GTKInfoBar.h
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

#import "enums.h"
#import "GTKControl.h"

typedef enum GTKMessageType {
    GTKMessageTypeInfo = GTK_MESSAGE_INFO, // DEFAULT
    GTKMessageTypeWarning = GTK_MESSAGE_WARNING,
    GTKMessageTypeQuestion = GTK_MESSAGE_QUESTION,
    GTKMessageTypeError = GTK_MESSAGE_ERROR,
    GTKMessageTypeOther = GTK_MESSAGE_OTHER
} GTKMessageType;


/*!
 * @brief A class representing a view that implements a horizontal bar used to
 * show messages to the user without showing a full dialog. It is usually
 * shown at the top or bottom of a window.
 */
@interface GTKInfoBar: GTKControl
{
    __block GTKMessageType _messageType;
    __block OFString *_label;
    __block GtkWidget *_labelWidget;
}
@property GTKMessageType messageType;
@property GTKResponseType response;
- (void)addButtonWithLabel:(OFString *)label response:(GTKResponseType)response;
@end
