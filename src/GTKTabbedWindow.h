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

/*! @file GTKTabbedWindow.h */

#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>

#import "GTKWindow.h"
#import "GTKTabView.h"

OF_ASSUME_NONNULL_BEGIN

/*!
 * @brief A class representing a window whose contentView is a GTKTabView whose
 *	  tab switcher is located in the window's header bar, in place of a
 *	  title.
 */
@interface GTKTabbedWindow: GTKWindow
{
	GtkWidget *_switcher;
}

/*!
 * @brief The GTKTabView that holds all this view controller's subviews.
 */
- (nullable GTKTabView*)contentView;

/*!
 * @brief The GTKTabView that holds all this view controller's subviews.
 */
- (void)setContentView: (nullable GTKTabView*)view;
@end

OF_ASSUME_NONNULL_END
