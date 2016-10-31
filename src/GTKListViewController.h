/*! @file GTKListViewController.h
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

#import "GTKViewController.h"
#import "GTKView.h"
#import "GTKListViewDelegate.h"
#import "GTKListViewDataSource.h"

/*!
 * @brief A class representing a view controller that manages a vertical list
 * of views.
 */
@interface GTKListViewController: GTKViewController
{
    GtkWidget *_scrollWindow;
    OFMutableArray *_views;
    OFMutableArray *_headers;
}
@property (nullable, weak) id<GTKListViewDelegate> delegate;
@property (nullable, weak) id<GTKListViewDataSource> dataSource;

- (void)reloadData;
@end
