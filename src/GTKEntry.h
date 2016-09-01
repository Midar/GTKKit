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

OF_ASSUME_NONNULL_BEGIN

/*!
 * @brief A simple text entry widget.
 */
@interface GTKEntry: GTKWidget
/*!
 * The text buffer to use for the text entry widget.
 *
 * @throws GTKDestroyedWidgetException
 */
@property GtkEntryBuffer *buffer;

/*!
 * The text contained in the buffer.
 *
 * @throws GTKDestroyedWidgetException
 */
@property OFString *stringValue;

/*!
 * Whether or not the text in the entry should be obscured.
 *
 * @throws GTKDestroyedWidgetException
 */
@property bool textVisible;

/*!
 * The maximum number of characters to allow in the entry.
 *
 * @throws GTKDestroyedWidgetException
 */
@property int maximumLength;

/*!
 * Whether or not to draw a frame around the entry.
 *
 * @throws GTKDestroyedWidgetException
 */
@property bool hasFrame;
@end

OF_ASSUME_NONNULL_END
