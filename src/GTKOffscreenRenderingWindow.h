/*! @file GTKOffscreenRenderingWindow.h
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

#import "GTKResponder.h"
#import "GTKView.h"
#import "GTKImage.h"

/*!
 * @brief A class representing a view controller that renders its view hierarchy
 * off-screen, allowing GTKImage instances to be generated from a view hierarchy.
 */
@interface GTKOffscreenRenderingWindow: GTKResponder
{
	GtkWidget *_offscreenWindow;
}

/*!
 * @brief The GTKView that holds all this view controller's subviews.
 */
@property (nullable) GTKView *contentView;


/*!
 * @brief The width of this window. The x and y position will always be 0.
 */
@property GTKRect frame;

/*!
 * @brief The current state of this window, rendered as a GTKImage.
 */
@property (nonnull, readonly) GTKImage *image;

/*!
 * @brief Adds the specified view to this window's content view as a
 * subview.
 *
 * @pram subview The view to add
 */
- (void)addView: (nonnull GTKView *)subview;
@end
