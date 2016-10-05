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

#import "defines.h"
#import "GTKViewController.h"
#import "GTKView.h"
#import "GTKCallback.h"

/*!
 * @brief A class representing a view controller that manages a toplevel
 * window and its view hierarchy.
 */
@interface GTKWindowViewController: GTKViewController

/*!
 * @brief The GtkWindow widget this view controller manages.
 */
@property (nullable) GtkWidget *window;

/*!
 * @brief The GTKView that holds all this view controller's subviews.
 */
@property (nullable) GTKView *contentView;

/*!
 * @brief The position and size of this view controller's window.
 */
@property GTKRect frame;

/*!
 * @brief A boolean indicating whether this view controller's window should be
 * visible to the user.
 */
@property (getter=isHidden) bool hidden;

/*!
 * @brief A bool value indicating whether or not the window
 * this view manages should have a visible titlebar.
 */
@property bool titleVisibile;

/*!
 * @brief A bool value indicating whether or not the window should be
 * resizable.
 */
@property (getter=isResizable) bool resizable;

/*!
 * @brief Adds the specified view to this view controller's content view as a
 * subview.
 *
 * @pram subview The view to add
 */
- (void)addSubview:(nonnull GTKView *)subview;

/*!
 * @brief Hide the window from the user. This does not destroy the window.
 */
- (void)close;
@end
