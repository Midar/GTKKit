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

#import "GTKMenuItem.h"
#import "GTKMenu.h"

@class GTKMenu;

OF_ASSUME_NONNULL_BEGIN

@interface GTKMenuItem (Properties)
/*!
 * @brief The string to use as a label in the menu item.
 * @throws GTKDestroyedWidgetException
 */
@property OFString *label;
/*!
 * @brief The menu to use as a submenu for the menu item.
 * @throws GTKDestroyedWidgetException
 */
@property GTKMenu *submenu;
/*!
 * @brief Constructor to make a menu item with the specified label.
 *
 * @param label The string to use as a label for the menu item.
 * @throws GTKDestroyedWidgetException
 */
+ (id)menuItemWithLabel:(OFString *)label;
/*!
 * @brief Initialie the menu item with the specified label.
 *
 * @param label The string to use as a label for the menu item.
 * @throws GTKDestroyedWidgetException
 */
- (id)initWithLabel:(OFString *)label;
@end

OF_ASSUME_NONNULL_END
