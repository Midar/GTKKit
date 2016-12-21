/*! @file GTKNotebookView.h
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

#import "GTKView.h"
#import "GTKTab.h"
#import "GTKApplication.h"
#import "GTKCoding.h"
#import "GTKPositionType.h"

/*!
 * @brief A class representing a view that manages a set of tabs, each of which
 * has its own view hierarchy. This is very much like a GTKTabView (and both
 * use the GTKTab class to manage their contents), but with a distinct style;
 * notebook views are primarily used in "tabbed windows" of the type made
 * popular by web browsers, and in other places where the set of tabs may
 * change during the program's lifetime. Usually, GTKTabView will be a more
 * appropriate choice in your own interface designs.
 */
@interface GTKNotebookView: GTKView <GTKCoding>
{
	OFMutableArray<__kindof GTKTab *> *_tabs;
	GTKPositionType                    _tabPosition;
	bool                               _tabsHidden;
	bool                               _scrollable;
}

@property GTKPositionType tabPosition;
@property bool            tabsHidden;
@property bool            scrollable;

/*!
 * @brief Adds the specified tab to the end of the tab view's tabs.
 */
- (void)addTab: (nonnull GTKTab *)tab;

/*!
 * @brief Removes the specified tab from the tab view's tabs.
 */
- (void)removeTab: (nonnull GTKTab *)tab;

- (void)renameTab: (nonnull GTKTab *)tab
	 toString: (nonnull OFString *)string;

/*!
 * @brief Returns the index of the specified tab in the notebook's tabs.
 */
- (int)indexOfTab: (nonnull GTKTab *)tab;

/*!
 * @brief The number of tabs in this tab view.
 */
- (int)numberOfTabs;

/*!
 * @brief Inserts the specified tab at the specified position in the tab
 * view's tabs.
 */
- (void)insertTab: (nonnull GTKTab *)tab
	  atIndex: (int)index;

/*!
 * @brief The GTKTab at the specified position in the tab view's tabs.
 */
- (nullable GTKTab *)tabAtIndex: (int)index;
@end
