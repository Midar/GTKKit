/*! @file GTKButton.h
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
#import "GTKImage.h"


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
 * @brief The state of an active button. Equal to true.
 */
const bool GTKOnState = true;

/*!
 * @brief The state of an inactive button. Equal to false.
 */
const bool GTKOffState = false;


/*!
 * @brief A class implementing various types of GUI button.
 */
@interface GTKButton: GTKControl
{
    __block GTKButtonType _buttonType;
    __block gulong _buttonClickedHandlerID;
    __block gulong _buttonToggledHandlerID;
    __block GtkWidget *_hiddenRadioButton;
    __block GtkWidget *_imageWidget;
    __block GTKImage *_image;
}

/*!
 * @brief The type of the button.
 */
@property GTKButtonType buttonType;

/*!
 * @brief The state of this button. If the mode is GTKPushButton (the default
 * for new buttons), this will always be GTKOffState.
 */
@property bool state;

/*!
 * @brief An image owned by this button, to be displayed if there is no text set.
 */
@property (nullable) GTKImage *image;
@end
