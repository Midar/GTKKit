/*! @file GTKTabbedWindowViewController.h
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

#import "GTKWindowViewController.h"

/*!
 * @brief A class which represents a window view controller that manages a set
 * of view hierarchies, displaying one at a time, switching between them with
 * a selector control in the header bar.
 */
@interface GTKTabbedWindowViewController: GTKWindowViewController
{
    __block GtkWidget *_stack;
    __block GtkWidget *_switcher;
}

@property (nonnull) OFMutableDictionary *views;

/*!
 * @brief The title of the selected tab.
 */
@property (nullable, readonly) OFString *titleOfSelectedTab;

/*!
 * @brief The number of tabs in this window.
 */
@property (readonly) int tabCount;

/*!
 * @brief Add a tab with the given title.
 */
- (void)addTabTitled:(nonnull OFString *)title;

/*!
 * @brief Remove a tab with the given title.
 */
- (void)removeTabTitled:(nonnull OFString *)title;

/*!
 * @brief The GTKView shown when the tab with the given title is visible.
 */
- (nullable GTKView *)tabViewTitled:(nonnull OFString *)title;

/*!
 * @brief Add a given GTKView as a subview of the view shown when the tab with
 * the given name is visible.
 */
- (void)addView:(nonnull GTKView *)view toTabTitled:(nonnull OFString *)title;
@end
