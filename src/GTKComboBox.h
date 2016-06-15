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
 * @brief A button which allows the user to select from a list of items.
 */
@interface GTKComboBox: GTKBin
/*!
 * @brief Adds a string to the end of the  list of choices.
 *
 * @param string the string to add to the list.
 * @param ID a string to use as the ID for the new list option.
 *
 * @throws GTKDestroyedWidgetException
 */
- (void)    appendString: (OFString*)string
    withIdentifierString: (OFString*)ID;

/*!
 * @brief Adds a string to the beginning of the  list of choices.
 *
 * @param string the string to add to the list.
 * @param ID a string to use as the ID for the new list option.
 *
 * @throws GTKDestroyedWidgetException
 */
- (void)   prependString: (OFString*)string
    withIdentifierString: (OFString*)ID;

/*!
 * @brief Adds a string to the specified position in the  list of choices.
 *
 * @param string the string to add to the list.
 * @param ID a string to use as the ID for the new list option.
 * @param position The index of the position into which the string should be
 * inserted.
 *
 * @throws GTKDestroyedWidgetException
 */
- (void)    insertString: (OFString*)string
    withIdentifierString: (OFString*)ID
              atPosition: (int)position;

/*!
 * @brief The index of the currently active item in the list, or -1 if there
 * is no item actve.
 *
 * @throws GTKDestroyedWidgetException
 */
@property int activeItem;
@end

OF_ASSUME_NONNULL_END
