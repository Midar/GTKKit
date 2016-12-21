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

/*! @file GTKMenu.h */

#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>

#import "GTKCoding.h"
#import "GTKMenuItem.h"

OF_ASSUME_NONNULL_BEGIN

@class GTKView;

/*!
 * @brief A class representing a menu, which is a list of menu items.
 */
@interface GTKMenu: OFObject <GTKCoding>
{
	GtkWidget *_menu;
	OFMutableArray <__kindof GTKMenuItem*> *_menuItems;
}

@property (readonly) int numberOfItems;

- (void)addItem: (GTKMenuItem *)item;

- (void)insertItem: (GTKMenuItem *)item
	   atIndex: (int)index;

- (void)removeItem: (GTKMenuItem *)item;

- (nullable GTKMenuItem*)itemAtIndex: (int)index;

- (nullable GTKMenuItem*)itemWithTag: (int)tag;

- (OFArray*)itemArray;

- (void)popUpAtView: (GTKView*)view;
@end

OF_ASSUME_NONNULL_END
