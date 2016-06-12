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

#import "GTKContainer.h"
#import "GTKMenuItem.h"

OF_ASSUME_NONNULL_BEGIN

/*!
 * @brief An abstract parent class for menu-related subclasses.
 */
@interface GTKMenuShell: GTKContainer
/*!
 * @brief Adds a menu item to the end of the menu.
 *
 * @param menuItem The menu item to add.
 * @throws GTKDestroyedWidgetException
 */
- (void)appendMenuItem:(GTKMenuItem *)menuItem;
/*!
 * @brief Adds a menu item to the beginning of the menu.
 *
 * @param menuItem The menu item to add.
 * @throws GTKDestroyedWidgetException
 */
- (void)prependMenuItem:(GTKMenuItem *)menuItem;
/*!
 * @brief Adds a menu item to the specified position in the menu.
 *
 * @param menuItem The menu item to add.
 * @param position The position at which to place the menu item.
 * @throws GTKDestroyedWidgetException
 */
- (void)insertMenuItem:(GTKMenuItem *)menuItem
            atPosition:(int)position;
/*!
 * @brief Deactivate the menu.
 * @throws GTKDestroyedWidgetException
 */
- (void)deactivate;
@end

OF_ASSUME_NONNULL_END
