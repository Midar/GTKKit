/*! @file GTKTabbedViewController.h
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

#import "GTKViewController.h"

/*!
 * @brief A class representing a view controller that displays any number of
 * view hierarchies one at a time, switching between them using a selector control.
 */
@interface GTKTabbedViewController: GTKViewController
{
    __block GtkWidget *_stack;
    __block GtkWidget *_switcher;
}

@property (nonnull) OFMutableDictionary *views;

/*!
 * @brief Adds a tab to the view controller witht the specified title.
 *
 * @param title The title of the tab which should be added to the view controller.
 */
- (void)addTabTitled:(nonnull OFString *)title;

/*!
 * @brief Removes the tab with the specified title.
 *
 * @param title The title of the tab which should be removed from the view controller.
 */
- (void)removeTabTitled:(nonnull OFString *)title;

/*!
 * @brief Gets the view which is the root of the view hierarchy shown in the
 * tab with the specified title.
 *
 * @param title The title of the tab which should be added to the view controller.
 *
 * @returns The view at the root of the specified tab's view hierarchy.
 */
- (nullable GTKView *)tabViewTitled:(nonnull OFString *)title;

/*!
 * @brief Adds a given view to the view hierarchy of the tab with the speicfied
 * title.
 *
 * @param view The GTKView that should be added to the specified tab's view hierarchy.
 * @param title The title of the tab to which the speicifed view should be added.
 */
- (void)addView:(nonnull GTKView *)view toTabTitled:(nonnull OFString *)title;
@end
