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

#import "GTKBin.h"

OF_ASSUME_NONNULL_BEGIN

/*!
 * @brief A class representing a clickable button with a customizable label.
 *
 * This class makes use of the target-action design pattern.
 */
@interface GTKButton: GTKBin
{
  gulong _clickedHandlerID;
}
/*!
 * @brief The selector of the method to be used as the action.
 */
@property (nullable) SEL action;
/*!
 * @brief The object that will act as the target for this button.
 */
@property (weak, nullable) id target;
/*!
 * @brief Creates a button with the specified label.
 *
 * @param text The string to use as a label in the new button.
 */
+ (instancetype)buttonWithLabel:(OFString*)text;
/*!
 * @brief Initializes the button with the specified label.
 *
 * @param text The string to use as a label in the new button.
 */
- initWithLabel:(OFString*)text;
@end

OF_ASSUME_NONNULL_END
