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

OF_ASSUME_NONNULL_BEGIN
/*!
 * @brief A buffer for holding text in @ref GTKTextView widgets.
 */
@interface GTKTextBuffer: OFObject
/*!
 * @brief The wrapped pointer to the internal GTK+ object representing the
 * buffer.
 */
 @property GtkTextBuffer *bufferHandle;
 /*!
  * @brief The number of lines in the buffer.
  */
@property (readonly) int lineCount;
/*!
 * @brief The number of characters in the buffer. This is not the same as the
 * number of bytes, as the buffer stores text in UTF-8.
 */
@property (readonly) int characterCount;
/*!
 * @brief The contents of the buffer. Reading this property results in a new
 * OFString being allocated with a copy of the string value of the buffer.
 */
 @property OFString *stringValue;
/*!
 * @brief Insert the specified string at the specified position in the buffer.
 *
 * @param string The string to insert.
 * @param position The position at which to insert the string.
 */
- (void)insertString:(OFString*)string
          atPosition:(int)position;
/*!
 * @brief Insert the specified string at the cursor location.
 *
 * @param string The string to insert.
 */
- (void)insertStringAtCursorPosition:(OFString*)string;
@end

OF_ASSUME_NONNULL_END
