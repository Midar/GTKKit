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

/*! @file GTKTabView.h */

#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>

#import "GTKView.h"
#import "GTKTab.h"
#import "GTKApplication.h"
#import "GTKCoding.h"

OF_ASSUME_NONNULL_BEGIN

/*!
 * @brief A class representing a view that manages a set of tabs, each of which
 *	  has its own view hierarchy.
 */
@interface GTKTabView: GTKView <GTKCoding>
{
	OFMutableArray <__kindof GTKTab*> *_tabs;
	GtkWidget *_stack;
	GtkWidget *_switcher;
	bool _tabsHidden;
	bool _frameHidden;
}

@property (readonly, copy) OFArray <__kindof GTKTab*> *tabs;

/*!
 * @brief Whether or not to hide the built-in tab switcher.
 */
@property bool tabsHidden;

/*!
 * @brief Whether or not to hide the frame around the subviews.
 */
@property bool frameHidden;

/*!
 * @brief The GtkStack widget used by this view. This is only useful for view
 *	  implementations.
 */
- (GtkWidget*)stack;

/*!
 * @brief Adds the specified tab to the end of the tab view's tabs.
 */
- (void)addTab: (GTKTab*)tab;

/*!
 * @brief Removes the specified tab from the tab view's tabs.
 */
- (void)removeTab: (GTKTab*)tab;

/*!
 * @brief Inserts the specified tab at the specified position in the tab view's
 *	  tabs.
 */
- (void)insertTab: (GTKTab*)tab
	  atIndex: (int)index;

- (void)renameTab: (GTKTab*)tab
	 toString: (OFString*)string;

/*!
 * @brief Returns the index of the specified tab in the tab view's tabs.
 */
- (int)indexOfTab: (GTKTab*)tab;

/*!
 * @brief The number of tabs in this tab view.
 */
- (int)numberOfTabs;

/*!
 * @brief The GTKTab at the specified position in the tab view's tabs.
 */
- (nullable GTKTab*)tabAtIndex: (int)index;
@end

OF_ASSUME_NONNULL_END
