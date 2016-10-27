/*! @file GTKViewController.h
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

@class GTKView;

/*!
 * @brief A parent class for classes which implement
 * "view controllers", controller objects which manage the content and behavior
 * of a set of views.
 */
@interface GTKViewController: GTKResponder

/*!
 * @brief The GTKView that holds all this view controller's subviews.
 */
@property (nullable) GTKView *contentView;

/*!
 * @brief The GTKResponder which gets event messages first for this view controller.
 */
@property (nullable) GTKResponder *firstResponder;

/*!
 * @brief Adds the specified view to this view controller's content view as a
 * subview.
 *
 * @pram subview The view to add
 */
- (void)addView:(nonnull GTKView *)subview;

/*!
 * @brief Adds the contentView of the specified view controller to the contentView
 * of this view controller as a subview, maintaining the responder chain as needed.
 *
 * @pram viewController The viewContoller to add
 */
- (void)addViewController:(nonnull GTKViewController *)viewController;
@end
