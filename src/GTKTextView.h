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

#import "GTKContainer.h"
#import "GTKTextBuffer.h"
#import "GTKScrollable.h"

OF_ASSUME_NONNULL_BEGIN
/*!
 * @brief A widget that displays editable text.
 */
@interface GTKTextView: GTKContainer <GTKScrollable>
/*!
 * @brief The buffer to use with the text view widget. Multiple such widgets can
 * share a single buffer if desired.
 * @throws GTKDestroyedWidgetException
 */
@property GTKTextBuffer *buffer;
/*!
 * @brief The wrap mode of the text view.
 *
 * One of the following possible values:
 *
 * - GTK_WRAP_NONE
 * - GTK_WRAP_CHAR
 * - GTK_WRAP_WORD
 * - GTK_WRAP_WORD_CHAR
 *
 * @throws GTKDestroyedWidgetException
 */
@property GtkWrapMode wrapMode;
/*!
 * @brief Whether or not the text view is editable.
 *
 * @throws GTKDestroyedWidgetException
 */
@property bool editable;
/*!
 * @brief Whether or not the cursor is visible.
 *
 * @throws GTKDestroyedWidgetException
 */
@property bool cursorVisible;
/*!
 * @brief Whether the text view is in insert or overwrite mode. Setting this to
 * true turns on overwrite mode, false sets it to insert mode.
 *
 * @throws GTKDestroyedWidgetException
 */
@property bool overwriteMode;
/*!
 * @brief Moves the cursor so it is within the visible portion of the buffer,
 * if it is not there already.
 *
 * @throws GTKDestroyedWidgetException
 */
- (void)moveCursorToVisibleArea;
@end

OF_ASSUME_NONNULL_END