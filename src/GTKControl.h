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

#import "defines.h"
#import "GTKEvent.h"
#import "GTKView.h"

typedef void (^GTKControlActionBlock) (_Nonnull id sender);

/*!
 * @brief A class represnting GUI controls
 *
 * GTKControl is the parent class of all the "control" views: views which
 * implement buttons, sliders, etc. Controls are distinguished from other
 * views by their implementation of the target-action pattern - when a control
 * is activated, it sends a message to another object with itself as an argument,
 * which decouples behaviour from the class itself.
 */
@interface GTKControl: GTKView

/*!
 * @brief The target of the action for the control. If this is nil, the action
 * message will be sent to the first responder.
 */
@property (nullable, weak) id target;

/*!
 * @brief The selector of the message which is sent to the target or first
 * responder. If this is NULL, no action is attempted.
 */
@property (nullable) SEL action;

/*!
 * @brief A block which, if it exists, will be executed after attempting to
 * send the target its action message. This block takes a single argument,
 * which will be the instance running the block.
 */
@property (nullable, copy) GTKControlActionBlock actionBlock;

/*!
 * @brief The string value of the control.
 */
@property (nullable, copy) OFString *stringValue;

/*!
 * @brief The int value of the control.
 */
@property int intValue;

/*!
 * @brief The double value of the control.
 */
@property double doubleValue;

/*!
 * @brief The float value of the control.
 */
@property float floatValue;

/*!
 * @brief The object value of the control.
 */
@property (nullable) id objectValue;

/*!
 * @brief Attempt to have the target perform the action.
 *
 * This method is used by event methods in subclasses; for example, GTKButton's
 * -mouseUp: method override sends this on a single click.
 */
- (void)sendActionToTarget;

/*!
 * @brief Set the string value of this control from that of another object. The
 * target object must implement the -stringValue: method.
 */
- (void)takeStringValueFrom:(nonnull id)target;

/*!
 * @brief Set the int value of this control from that of another object. The
 * target object must implement the -intValue: method.
 */
- (void)takeIntValueFrom:(nonnull id)target;

/*!
 * @brief Set the double value of this control from that of another object. The
 * target object must implement the -doubleValue: method.
 */
- (void)takeDoubleValueFrom:(nonnull id)target;

/*!
 * @brief Set the float value of this control from that of another object. The
 * target object must implement the -floatValue: method.
 */
- (void)takeFloatValueFrom:(nonnull id)target;

/*!
 * @brief Set the object value of this control from that of another object. The
 * target object must implement the -objectValue: method.
 */
- (void)takeObjectValueFrom:(nonnull id)target;
@end
