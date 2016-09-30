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

#import "GTKResponder.h"
#import "GTKLayoutConstraints.h"
#import "GTKViewController.h"

@class GTKView;

typedef GdkRectangle GTKRect;

gboolean
gtkkit_get_child_position_handler(GtkOverlay     * _Nonnull overlay,
                                  GtkWidget      * _Nonnull widget,
                                  GdkRectangle   * _Nonnull allocation,
                                  GTKView        * _Nonnull view);

void
gtkkit_overlay_widget_destroyed_handler(GtkWidget * _Nonnull overlay,
                                        GTKView   * _Nonnull view);

/*!
 * @brief A class representing "views" in the model-view-controller (MVC)
 * paradigm. It is the parent class for all such views, and one of the most
 * important classes in GTKKit.
 *
 * GTKView instances hold strong references to all of their subviews,
 * storing them in an internal array; the order of the children in that array
 * is used to determine the z-index order of the child widgets, back to front.
 * Each view also holds a weak reference to its parent view.
 *
 * Each GTKView also carries with it a set of constraints used by the layout
 * engine to determine its position and size within its parent view. These are
 * set to default states during default initialization, but subclasses override
 * those settings as needed.
 */
@interface GTKView: GTKResponder
{
    gulong _get_child_position_handler_id;
    gulong _widget_destroyed_handler_id;
    GtkWidget *_overlayWidget;
}

/*!
 * @brief The internal GtkOverlay used by the view.
 */
@property (nullable) GtkWidget *overlayWidget;

/*!
 * @brief The GtkWidget sub-instance used as the "main" widget in the overlay.
 *
 * In the default implementation of GTKView, this is a GtkInvisible.
 */
@property (nullable) GtkWidget *mainWidget;

/*!
 * @brief The superview of this view, if one exists.
 */
@property (nullable, weak) GTKView* superview;

/*!
 * @brief A mutable array of the subviews of this view.
 */
@property (nonnull) OFMutableArray<__kindof GTKView *> *subviews;

/*!
 * @brief The constraints used in laying out this view.
 */
@property (nonnull) GTKLayoutConstraints *constraints;

/*!
 * @brief Whether or not to draw this view at all.
 */
@property (getter=isHidden) bool hidden;

/*!
 * @brief The opacity level of the view; if it is drawn at all, it will be
 * drawn with this opacity level. The default implementation of this property
 * only affects the view itself, not any of its subviews.
 */
@property double alpha;

/*!
 * @brief The view controller that ultimately owns this view, if one exists.
 */
@property (nullable, weak) GTKViewController *viewController;

/*!
 * @brief The frame of the view - its position and size, in the coordinate space
 * of its superview.
 */
@property (readonly) GTKRect frame;

/*!
 * @brief Given a subview, return a rectangle in this view's coordinate space which
 * represents the subview's position and size.
 *
 * This is used by the GtkOverlay "get-child-position" signal callback of this
 * view's overlay. Subclasses can override this method to implement custom
 * layout as needed.
 *
 * The default implementation of this method uses the view's width and height,
 * combined with the subview's constraints, to generate the layout rectangle.
 */
- (GTKRect)layoutSubview:(nonnull GTKView*)subview;

/*!
 * @brief Render each of this view's subviews within this view's area.
 */
- (void)layoutSubviews;

/*!
 * @brief This method handles any custom drawing the view requires.
 *
 * The default implementation of this method does nothing; subclasses can override
 * it as needed.
 */
- (void)draw;

@end