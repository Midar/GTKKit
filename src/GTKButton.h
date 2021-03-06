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

/*! @file GTKButton.h */

#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>

#import "GTKControl.h"
#import "GTKImage.h"
#import "GTKPopover.h"
#import "GTKMenu.h"

OF_ASSUME_NONNULL_BEGIN

/*!
 * @brief The state of an active button. Equal to true.
 */
extern const bool GTKOnState;

/*!
 * @brief The state of an inactive button. Equal to false.
 */
extern const bool GTKOffState;

/*!
 * @brief The types buttons can implement.
 */
typedef enum GTKButtonType {
	/*!
	 * @brief A standard push button. This is the default type.
	 */
	GTKPushButton,

	/*!
	 * @brief A toggle button.
	 */
	GTKToggleButton,

	/*!
	 * @brief A check button.
	 */
	GTKCheckButton,

	/*!
	 * @brief A radio button.
	 */
	GTKRadioButton,

	/*!
	 * @brief A button which resembles a switch.
	 */
	GTKSwitchButton
} GTKButtonType;

/*!
 * @brief A class implementing various types of GUI button.
 */
@interface GTKButton: GTKControl
{
	GTKButtonType _buttonType;
	GtkWidget *_pushButton;
	GtkWidget *_pushButtonImage;
	GtkWidget *_toggleButton;
	GtkWidget *_toggleButtonImage;
	GtkWidget *_checkButton;
	GtkWidget *_checkButtonImage;
	GtkWidget *_radioButton;
	GtkWidget *_radioButtonImage;
	GtkWidget *_hiddenRadioButton;
	GtkWidget *_switchButton;
	GTKImage *_image;
	__weak GTKPopover *_popOver;
	OFString *_stringValue;
}

/*!
 * @brief The type of the button.
 */
@property GTKButtonType buttonType;

/*!
 * @brief The state of this button. If the mode is GTKPushButton (the default
 * for new buttons) or GTKSwitchButton, this will always be GTKOffState.
 */
@property bool state;

/*!
 * @brief An image owned by this button, to be displayed if there is no text set.
 * This has no effect for a GTKSwitchButton.
 */
@property (nullable) GTKImage *image;

/*!
 * @brief A GTKPopOverViewController associated with this button. If this is set,
 * the pop-over will be shown when the button is clicked, in addition to whatever
 * the target-action method and actionBlock might do.
 */
@property (weak, nullable) GTKPopover *popOver;

/*!
 * @brief A GTKMenu associated with the button, which will be shown when the
 * button is clicked.
 */
@property (weak, nullable) GTKMenu *menu;
@end

OF_ASSUME_NONNULL_END
