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

/*! @file GTKMenuItem.h */

#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>

#import "GTKCoding.h"

OF_ASSUME_NONNULL_BEGIN

/*!
 * @brief A class representing an item in a menu.
 */
@interface GTKMenuItem: OFObject <GTKCoding>
{
	GtkWidget *_menuItem;
	GtkWidget *_grid;
	GtkWidget *_labelWidget;
	GtkWidget *_acceleratorWidget;
	OFString *_label;
	OFString *_accelerator;
	bool _isSeparator;
}

@property (readonly) bool isSeparator;

/*!
 * @brief The target of the action for the menu item. If this is nil, the action
 * message will be sent to the first responder.
 */
@property (nullable, weak) id target;

/*!
 * @brief The selector of the message which is sent to the target or first
 * responder. If this is NULL, no action is attempted.
 */
@property (nullable) SEL action;

/*!
 * @brief The label of the menu item.
 */
@property (nullable, copy) OFString *label;

/*!
 * @brief The text shown as the accelerator for the menu item.
 */
@property (nullable, copy) OFString *accelerator;

/*!
 * @brief An integer tag which can be associated to a menu item.
 */
@property int tag;

+ (instancetype)separator;

- (GtkWidget*)menuItem;
- (void)sendActionToTarget;
@end

OF_ASSUME_NONNULL_END
