/*! @file GTKView.h
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

/*!
 * @brief An enumeration of the layers in which a view can render its subviews.
 */
typedef enum GTKViewLayer {
  GTKViewLayerDrawingArea = -2,
  /*!
   * @brief The background layer.
   */
  GTKViewLayerBackground = -1,
  /*!
   * @brief The default layer.
   */
  GTKViewLayerDefault = 0,
  /*!
   * @brief The foreground layer.
   */
  GTKViewLayerForeground = 1,
  /*!
   * @brief The notification layer.
   */
  GTKViewLayerNotification = 2
} GTKViewLayer;

typedef void (^GTKViewDrawingBlock) (cairo_t * _Nullable cr);

/*!
 * @brief A structure representing a rectangle, with x, y, width and height integer
 * values.
 */
typedef GdkRectangle GTKRect;

@class GTKViewController;

@class GTKView;

GTKView * _Nullable
gtk_widget_get_owning_view(GtkWidget * _Nonnull widget);

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
    bool _hidden;
    __weak __block GTKViewController *_viewController;
}

/*!
 * @brief The internal cairo context for the widget, used for the default draw
 * method. This is not guaranteed to be valid except while the draw method is
 * run by the GTK+ draw signal handler. This is primarily useful for doing
 * custom drawing in your own GTKView subclasses.
 */
@property (nullable) cairo_t *cairoContext;

/*!
 * @brief The internal GtkOverlay used by the view.
 */
@property (nullable) GtkWidget *overlayWidget;

/*!
 * @brief The GtkWidget sub-instance used as the "main" widget in the overlay.
 * In the default GTKView implementation, this is a GtkDrawingArea, but virtually
 * every GTKView subclass overrides this with its own widget type.
 */
@property (nullable) GtkWidget *mainWidget;

/*!
 * @brief The layer in which the superview will render this view.
 */
@property GTKViewLayer layer;

/*!
 * @brief The superview of this view, if one exists.
 */
@property (nullable, weak) GTKView* superview;

/*!
 * @brief A mutable array of the background layer subviews of this view.
 */
@property (nonnull) OFMutableArray<__kindof GTKView *> *backgroundLayerSubviews;

/*!
 * @brief A mutable array of the default layer subviews of this view.
 */
@property (nonnull) OFMutableArray<__kindof GTKView *> *defaultLayerSubviews;

/*!
 * @brief A mutable array of the foreground layer subviews of this view.
 */
@property (nonnull) OFMutableArray<__kindof GTKView *> *foregroundLayerSubviews;

/*!
 * @brief A mutable array of the notification layer subviews of this view.
 */
@property (nonnull) OFMutableArray<__kindof GTKView *> *notificationLayerSubviews;

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
 * @brief The frame of the view - its position and size, in the coordinate space
 * of its superview.
 */
@property (readonly) GTKRect frame;

/*!
 * @brief A block, taking a single cairo_t argument, which can handle custom
 * drawing for a GTKView instance.
 */
@property _Nullable GTKViewDrawingBlock drawingBlock;

/*!
 * @brief Render each of this view's subviews within this view's area.
 */
- (void)layoutSubviews;

/*!
 * @brief This method handles any custom drawing the view requires.
 *
 * The default implementation of this method does nothing; subclasses can override
 * it as needed. Cairo drawing is permissible in this method, with the cairo
 * context available as self.cairoContext.
 */
- (void)draw;

/*!
 * @brief Adds the given view to this view as a subview.
 */
- (void)addSubview:(nonnull GTKView *)view;

/*!
 * @brief Removes this view from its superview.
 */
- (void)removeFromSuperview;

- (void)reconnectSignals;
@end
