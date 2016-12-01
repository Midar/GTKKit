/*! @file GTKTabView.h
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

/*!
 * @brief A class representing a view that manages a set of tabs, each of which
 * has its own view hierarchy.
 */
@interface GTKTabView: GTKView <GTKCoding>
{
    __block OFMutableArray<__kindof GTKTab *> *_tabs;
    __block GtkWidget *_stack;
    __block GtkWidget *_switcher;
}
@property (nonnull, readonly, copy) OFArray<__kindof GTKTab *> *tabs;
- (void)addTab:(nonnull GTKTab *)tab;
- (void)removeTab:(nonnull GTKTab *)tab;
- (void)insertTab:(nonnull GTKTab *)tab
          atIndex:(int)index;
- (void)renameTab:(nonnull GTKTab *)tab
         toString:(nonnull OFString *)string;
- (int)indexOfTab:(nonnull GTKTab *)tab;
- (int)numberOfTabs;
- (nullable GTKTab *)tabAtIndex:(int)index;
@end
