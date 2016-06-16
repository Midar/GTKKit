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

#import "GTKCheckButton.h"

OF_ASSUME_NONNULL_BEGIN

/*!
 * @brief A button which incorporates a check-box to show its state.
 *
 * Radio buttons are managed in groups; the default behaviour when creating a
 * radio button is to put it into a new group; use of the methods below that
 * includes joiningGroupWithRadioButton in the signature to create a button
 * inside an existing group.
 */
@interface GTKRadioButton: GTKCheckButton
/*!
 * @brief Create a new radio button, with the specified text as its label.
 */
+ (instancetype)radioButtonWithLabelText:(OFString*)labelText;

/*!
 * @brief Initialize this radio button with the specified text as its label.
 */
- initWithLabelText:(OFString*)labelText;

/*!
 * @brief Create a new radio button, with the specified text as its label, in
 * the same group as the specified button.
 */
+ (instancetype)radioButtonWithLabelText:(OFString*)labelText
             joiningGroupWithRadioButton:(GTKRadioButton*)radioButton;

/*!
* @brief Initialize this radio button with the specified text as its label, in
* the same group as the specified button.
*/
-           initWithLabelText:(OFString*)labelText
  joiningGroupWithRadioButton:(GTKRadioButton*)radioButton;

/*!
 * @brief Initialize this radio button with the specified text as its label.
 */
- initWithLabelText:(OFString*)labelText;

/*!
 * @brief Make this button join the group of the specified button.
 */
- (void)joinGroupWithRadioButton:(GTKRadioButton*)radioButton;

/*!
 * @brief Make this button leave its current group.
 */
- (void)leaveGroup;
@end

OF_ASSUME_NONNULL_END
