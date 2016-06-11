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

#import "GTKLabel.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKLabel (Properties)
/*!
 * @brief The string to use as the label's text.
 */
@property OFString *text;
/*!
 * @brief The horizontal alignment of the text inside the label's area.
 */
@property float xAlign;
/*!
 * @brief The vertical alignment of the text inside the label's area.
 */
@property float yAlign;
/*!
 * @brief The justification of the text in the label.
 *
 * One of the following possible values:
 *
 * - GTK_JUSTIFY_LEFT
 * - GTK_JUSTIFY_RIGHT
 * - GTK_JUSTIFY_CENTER
 * - GTK_JUSTIFY_FILL
 */
@property GtkJustification justify;
/*!
 * @brief Whether and how to ellipsize the text of the label if it would
 * otherwise overflow its alloted space.
 *
 * One of the following possible values:
 *
 * - PANGO_ELLIPSIZE_NONE
 * - PANGO_ELLIPSIZE_START
 * - PANGO_ELLIPSIZE_MIDDLE
 * - PANGO_ELLIPSIZE_END
 */
@property PangoEllipsizeMode ellipsizeMode;
/*!
 * @brief The maximum number of characters the label should display.
 */
@property int desiredWidthInCharacters;
/*!
 * @brief Whether or not the lable should wrap lines the would otherwise
 * overflow their space.
 */
@property bool wrap;
/*!
 * @brief The method used to wrap lines.
 *
 * One of the following possible values:
 *
 * - PANGO_WRAP_WORD
 * - PANGO_WRAP_CHAR
 * - PANGO_WRAP_WORD_CHAR
 */
@property PangoWrapMode lineWrapMode;
/*!
 * @brief Whether or not text in the label should be selectable.
 */
@property bool selectable;
/*!
 * @brief Whether or not the label is in single-line mode.
 */
@property bool singleLineMode;
/*!
 * @brief The angle of rotation of the label. This value is ignored if the label is
 * selectable, wrapped, or ellipsized.
 */
@property double angle;
@end

OF_ASSUME_NONNULL_END
