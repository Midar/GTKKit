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
{
  GTKTextBuffer *_buffer;
}
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
 * @brief The number of pixels above paragraphs in the text view.
 *
 * @throws GTKDestroyedWidgetException
 */
@property int pixelsAboveParagraphs;
/*!
 * @brief The number of pixels below paragraphs in the text view.
 *
 * @throws GTKDestroyedWidgetException
 */
@property int pixelsBelowParagraphs;
/*!
 * @brief The number of pixels between wrapped lines in the text view.
 *
 * @throws GTKDestroyedWidgetException
 */
@property int pixelsBetweenWrappedLines;
/*!
 * @brief The justification of the text in the text view.
 *
 * One of the following possible values:
 *
 * - GTK_JUSTIFY_LEFT
 * - GTK_JUSTIFY_RIGHT
 * - GTK_JUSTIFY_CENTER
 * - GTK_JUSTIFY_FILL
 *
 * @throws GTKDestroyedWidgetException
 */
@property GtkJustification justification;
/*!
 * @brief The padding on the left side of the text in the text view.
 *
 * @throws GTKDestroyedWidgetException
 */
@property int paddingLeft;
/*!
 * @brief The padding on the right side of the text in the text view.
 *
 * @throws GTKDestroyedWidgetException
 */
@property int paddingRight;
/*!
 * @brief The padding on the top side of the text in the text view.
 *
 * @throws GTKDestroyedWidgetException
 */
@property int paddingTop;
/*!
 * @brief The padding on the bottom side of the text in the text view.
 *
 * @throws GTKDestroyedWidgetException
 */
@property int paddingBottom;
/*!
 * @brief The indentation (in pixels) for paragraphs in the text view.
 *
 * @throws GTKDestroyedWidgetException
 */
@property int indent;
/*!
 * @brief Whether or not to accept tabs as characters when the tab key is
 * pressed. If this is false, the tab key will cause focus to move to the
 * next widget.
 *
 * @throws GTKDestroyedWidgetException
 */
@property bool acceptTab;
/*!
 * @brief The purpose of the text view. This is used by input methods and
 * on-screen keyboards to alter their behaviour.
 *
 * One of the following possible values:
 *
 * - GTK_INPUT_PURPOSE_FREE_FORM
 * - GTK_INPUT_PURPOSE_ALPHA
 * - GTK_INPUT_PURPOSE_DIGITS
 * - GTK_INPUT_PURPOSE_NUMBER
 * - GTK_INPUT_PURPOSE_PHONE
 * - GTK_INPUT_PURPOSE_URL
 * - GTK_INPUT_PURPOSE_EMAIL
 * - GTK_INPUT_PURPOSE_NAME
 * - GTK_INPUT_PURPOSE_PASSWORD
 * - GTK_INPUT_PURPOSE_PIN
 *
 * @throws GTKDestroyedWidgetException
 */
@property GtkInputPurpose purpose;
/*!
 * @brief Whether or not to use a monospaced font to render the text in the text
 * view.
 *
 * @throws GTKDestroyedWidgetException
 */
@property bool monospace;
/*!
 * @brief Moves the cursor so it is within the visible portion of the buffer,
 * if it is not there already.
 *
 * @throws GTKDestroyedWidgetException
 */
- (void)moveCursorToVisibleArea;
@end

OF_ASSUME_NONNULL_END
