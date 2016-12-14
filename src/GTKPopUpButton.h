/*! @file GTKPopUpButton.h
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
 * @brief A button with an associated menu of items, any of which can be
 * selected.
 */
@interface GTKPopUpButton: GTKControl
{
	__block OFMutableArray *_items;
}

/*!
 * @brief The index of the selected item.
 */
- (int)indexOfSelectedItem;

/*!
 * @brief Select the item at the specified index.
 */
- (void)selectItemAt: (int)index;

/*!
 * @brief The title of the selected item.
 */
- (OFString *)titleOfSelectedItem;

/*!
 * @brief Add an item to the button's menu, with the specified label, at the
 * specified index.
 */
- (void)insertItemWithTitle: (OFString *)string
			 at: (int)index;

/*!
 * @brief Removes the item at the specified index.
 */
- (void)removeItemAt: (int)index;

/*!
 * @brief Remove all the items in the menu.
 */
- (void)removeAllItems;
@end
