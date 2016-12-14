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

#import "GTKControl.h"

/*!
 * @brief The available justifications in GTKKit
 */
typedef enum GTKJustification {

	/*!
	 * @brief Left justification.
	 */
	GTKJustificationLeft = GTK_JUSTIFY_LEFT,

	/*!
	 * @brief Center justification.
	 */
	GTKJustificationCenter = GTK_JUSTIFY_CENTER,

	/*!
	 * @brief Right justification.
	 */
	GTKJustificationRight = GTK_JUSTIFY_RIGHT,

	/*!
	 * @brief Fill justification.
	 */
	GTKJustificationFill = GTK_JUSTIFY_FILL
} GTKJustification;


/*!
 * @brief A class representing a control that acts as a single- or multi-line
 * label or text-entry field.
 */
@interface GTKTextField: GTKControl
{
	__block bool             _editable;
	__block bool             _selectable;
	__block GTKJustification _justify;
	__block bool             _multiline;
	__block GtkWidget       *_scrollWindow;
	__block GtkWidget       *_labelWidget;
	__block GtkWidget       *_entryWidget;
	__block GtkWidget       *_textViewWidget;
}

/*!
 * @brief Whether or not the text field is editable.
 */
@property (getter=isEditable) bool editable;

/*!
 * @brief Whether or not the text field sends its target-action message and runs
 * its action block whenever the content changes, or if it does so only when
 * enter is pressed.
 */
@property (getter=isContinuous) bool continuous;

/*!
 * @brief Whether or not the text field is selectable.
 */
@property (getter=isSelectable) bool selectable;

/*!
 * @brief The justification of the text field.
 */
@property GTKJustification justify;

/*!
 * @brief Whether or not the text field has mutliple lines.
 */
@property (getter=isMultiline) bool multiline;
@end
