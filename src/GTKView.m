/*! @file GTKView.m
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

#import "GTKView.h"
#import "GTKApplication.h"
#import "GTKLayoutConstraints.h"

static gboolean
draw_handler(GtkWidget *widget,
      		 cairo_t   *cr,
      		 GTKView   *view)
{
    view.cairoContext = cr;
    [view draw];
    if (NULL != view.drawingBlock) {
        view.drawingBlock(cr);
    }
	return false;
}

static gboolean
press_event_handler(GtkWidget *widget,
                    GdkEvent  *event,
                    GTKView   *view)
{
    [GTKApp.dispatch.main async: ^ {
        GTKEvent *evt = [GTKEvent new];
        evt.type = GTKEventTypeMouseDown;
        evt.mouseButton = event->button.button;
        evt.mouseX = event->button.x;
        evt.mouseY = event->button.y;

        if (event->type == GDK_BUTTON_PRESS) {
            evt.clicks = 1;
        } else if (event->type == GDK_2BUTTON_PRESS) {
            evt.clicks = 2;
        } else if (event->type == GDK_3BUTTON_PRESS) {
            evt.clicks = 3;
        }

        [view mouseDown: evt];

    }];
    return false;
}

static gboolean
release_event_handler(GtkWidget *widget,
                      GdkEvent  *event,
                      GTKView   *view)
{
    [GTKApp.dispatch.main async: ^ {
        GTKEvent *evt = [GTKEvent new];
        evt.type = GTKEventTypeMouseUp;
        evt.mouseButton = event->button.button;
        evt.mouseX = event->button.x;
        evt.mouseY = event->button.y;

        [view mouseUp: evt];
    }];
    return false;
}

GTKView *
gtk_widget_get_owning_view(GtkWidget *widget)
{
    return (__bridge GTKView *)g_object_get_data(
        G_OBJECT(widget),
        "_GTKKIT_OWNING_VIEW_");
}

static gboolean
get_child_position_handler(GtkOverlay   *overlay,
				   		   GtkWidget    *widget,
				   		   GdkRectangle *allocation,
				   		   GTKView      *view)
{
	GTKView *subview = gtk_widget_get_owning_view(widget);

    GtkRequisition min, req;
    gtk_widget_get_preferred_size (widget, &min, &req);

	GTKRect frame = [view layoutSubview: subview];

	allocation->x = frame.x;
	allocation->y = frame.y;
	allocation->width = MAX(frame.width, min.width);
	allocation->height = MAX(frame.height, min.height);

	return true;
}

static void
overlay_widget_destroyed_handler(GtkWidget *overlay,
                                 GTKView   *view)
{

}

static void
map_handler(GtkWidget *overlay,
            GTKView   *view)
{
    [GTKApp.dispatch.main async: ^{
        [view willBecomeMapped];
    }];
}

static void
map_event_handler(GtkWidget *overlay,
                  GTKView   *view)
{
    [GTKApp.dispatch.main async: ^{
        [view didBecomeMapped];
    }];
}

static void
unmap_handler(GtkWidget *overlay,
              GTKView   *view)
{
    [GTKApp.dispatch.main async: ^{
        [view willBecomeUnmapped];
    }];
}

static void
unmap_event_handler(GtkWidget *overlay,
                    GTKView   *view)
{
    [GTKApp.dispatch.main async: ^{
        [view didBecomeUnmapped];
    }];
}

static void
gesture_drag_begin_handler(GtkGestureDrag *gesture,
                           gdouble start_x,
                           gdouble start_y,
                           GTKView *view)
{

}

static void
gesture_drag_update_handler(GtkGestureDrag *gesture,
                            gdouble offset_x,
                            gdouble offset_y,
                            GTKView *view)
{
    [GTKApp.dispatch.main async: ^{
        GTKEvent *event = [GTKEvent new];

        event.type = GTKEventTypeMouseDragged;

        double x, y;

        gtk_gesture_drag_get_start_point(gesture, &x, &y);
        event.originX = x;
        event.originY = y;

        gtk_gesture_drag_get_offset(gesture, &x, &y);
        event.deltaX = x;
        event.deltaY = y;

        event.mouseX = event.originX + event.deltaX;
        event.mouseY = event.originY + event.deltaY;

        [view mouseDragged: event];
    }];
}

static void
gesture_drag_end_handler(GtkGestureDrag *gesture,
                         gdouble offset_x,
                         gdouble offset_y,
                         GTKView *view)
{

}

@interface GTKView ()
- (void)createMainWidget;
@end

@implementation GTKView
- init
{
	self = [super init];

	self.backgroundLayerSubviews = [OFMutableArray new];
	self.defaultLayerSubviews = [OFMutableArray new];
	self.foregroundLayerSubviews = [OFMutableArray new];
	self.notificationLayerSubviews = [OFMutableArray new];

    self.layer = GTKViewLayerDefault;

	self.constraints = [GTKLayoutConstraints new];

	[GTKApp.dispatch.gtk sync: ^{
		self.overlayWidget = gtk_overlay_new();
		g_object_ref_sink(G_OBJECT(self.overlayWidget));
        gtk_container_set_border_width(GTK_CONTAINER(self.overlayWidget), 0);

		g_object_set_data(
			G_OBJECT(self.overlayWidget),
			"_GTKKIT_OWNING_VIEW_",
		    (__bridge gpointer)(self));

		g_signal_connect(
			G_OBJECT(self.overlayWidget),
			"get-child-position",
			G_CALLBACK(get_child_position_handler),
			(__bridge gpointer)(self));

	    g_signal_connect(
			G_OBJECT(self.overlayWidget),
	        "destroy",
			G_CALLBACK(overlay_widget_destroyed_handler),
	        (__bridge gpointer)(self));

		g_signal_connect(
			G_OBJECT(self.overlayWidget),
			"map",
			G_CALLBACK(map_handler),
			(__bridge gpointer)(self));

		g_signal_connect(
			G_OBJECT(self.overlayWidget),
			"map-event",
			G_CALLBACK(map_event_handler),
			(__bridge gpointer)(self));

		g_signal_connect(
			G_OBJECT(self.overlayWidget),
			"unmap",
			G_CALLBACK(unmap_handler),
			(__bridge gpointer)(self));

		g_signal_connect(
			G_OBJECT(self.overlayWidget),
			"unmap-event",
			G_CALLBACK(unmap_event_handler),
			(__bridge gpointer)(self));

		[self createMainWidget];
        g_object_ref_sink(G_OBJECT(self.mainWidget));
		gtk_container_add(GTK_CONTAINER(self.overlayWidget), self.mainWidget);
		gtk_widget_show(self.mainWidget);
		gtk_widget_show(self.overlayWidget);

        gtk_widget_add_events(
            self.mainWidget,
            GDK_BUTTON_PRESS_MASK |
            GDK_BUTTON_RELEASE_MASK);

        g_signal_connect(
            G_OBJECT(self.mainWidget),
            "button-press-event",
            G_CALLBACK(press_event_handler),
            (__bridge gpointer)(self));

        g_signal_connect(
            G_OBJECT(self.mainWidget),
            "button-release-event",
            G_CALLBACK(release_event_handler),
            (__bridge gpointer)(self));

        GtkGesture *gesture = gtk_gesture_drag_new(self.overlayWidget);

        g_signal_connect(
            gesture,
            "drag-begin",
            G_CALLBACK(gesture_drag_begin_handler),
            (__bridge gpointer)(self));

        g_signal_connect(
            gesture,
            "drag-update",
            G_CALLBACK(gesture_drag_update_handler),
            (__bridge gpointer)(self));

        g_signal_connect(
            gesture,
            "drag-end",
            G_CALLBACK(gesture_drag_end_handler),
            (__bridge gpointer)(self));

        gesture = gtk_gesture_drag_new(self.mainWidget);

        g_signal_connect(
            gesture,
            "drag-begin",
            G_CALLBACK(gesture_drag_begin_handler),
            (__bridge gpointer)(self));

        g_signal_connect(
            gesture,
            "drag-update",
            G_CALLBACK(gesture_drag_update_handler),
            (__bridge gpointer)(self));

        g_signal_connect(
            gesture,
            "drag-end",
            G_CALLBACK(gesture_drag_end_handler),
            (__bridge gpointer)(self));

	    g_signal_connect(
			G_OBJECT(self.mainWidget),
	        "draw",
			G_CALLBACK(draw_handler),
	        (__bridge gpointer)(self));

	}];

	self.hidden = false;

	self.alpha = 1.0;

	return self;
}

- (void)dealloc
{
    [GTKApp.dispatch.gtk sync: ^{
        g_object_unref(G_OBJECT(self.mainWidget));
        g_object_unref(G_OBJECT(self.overlayWidget));
    }];
}

- (void)reconnectSignals
{
    GtkGesture *gesture = gtk_gesture_drag_new(self.mainWidget);

    [GTKApp.dispatch.gtk sync: ^{
        g_signal_connect(
            gesture,
            "drag-begin",
            G_CALLBACK(gesture_drag_begin_handler),
            (__bridge gpointer)(self));

        g_signal_connect(
            gesture,
            "drag-update",
            G_CALLBACK(gesture_drag_update_handler),
            (__bridge gpointer)(self));

        g_signal_connect(
            gesture,
            "drag-end",
            G_CALLBACK(gesture_drag_end_handler),
            (__bridge gpointer)(self));

	    g_signal_connect(
			G_OBJECT(self.mainWidget),
	        "draw",
			G_CALLBACK(draw_handler),
	        (__bridge gpointer)(self));
    }];
}

- (void)createMainWidget
{
    [GTKApp.dispatch.gtk sync: ^{
        self.mainWidget = gtk_drawing_area_new();
    }];
}

- (bool)isHidden
{
    __block bool hidden;
    [GTKApp.dispatch.gtk sync: ^{
        hidden = !gtk_widget_get_visible(self.overlayWidget);
    }];
    return hidden;
}

- (void)setHidden:(bool)hidden
{
    [GTKApp.dispatch.gtk sync: ^{
        gtk_widget_set_visible(self.overlayWidget, !hidden);
    }];
}

- (GTKRect)frame
{
	__block GtkAllocation alloc;
    __block GtkRequisition min, req;
	[GTKApp.dispatch.gtk sync: ^{
		gtk_widget_get_allocation(self.overlayWidget, &alloc);
        gtk_widget_get_preferred_size (self.mainWidget, &min, &req);
	}];
    alloc.width = MAX(alloc.width, req.width);
    alloc.height = MAX(alloc.height, req.height);
	return (GTKRect)alloc;
}

- (GTKRect)layoutSubview:(nonnull GTKView*)subview
{
	GTKRect frame = self.frame;
	GTKLayoutConstraints *constraints = subview.constraints;
	GTKRect subframe;

	// Pixel values:
	int top;
	int bottom;
	int left;
	int right;
	int width;
	int height;

	// FIXME: Validate the constraint values and types, throwing a
	// GTKInvalidLayoutConstraints exception if they aren't.

	if ((constraints.top.type == GTKLayoutConstraintTypeFlexible) &&
		 constraints.top.value != 0) {
		top = ceil((double)(frame.height) / 100 * constraints.top.value);
	} else {
		top = constraints.top.value;
	}

	if ((constraints.bottom.type == GTKLayoutConstraintTypeFlexible) &&
	 	constraints.bottom.value != 0) {
		bottom = ceil((double)(frame.height) / 100 * constraints.bottom.value);
	} else {
		bottom = constraints.bottom.value;
	}

	if ((constraints.left.type == GTKLayoutConstraintTypeFlexible) &&
	 	constraints.left.value != 0) {
		left = ceil((double)(frame.width) / 100 * constraints.left.value);
	} else {
		left = constraints.left.value;
	}

	if ((constraints.right.type == GTKLayoutConstraintTypeFlexible) &&
		 constraints.right.value != 0) {
		right = ceil((double)(frame.width) / 100 * constraints.right.value);
	} else {
		right = constraints.right.value;
	}

	if ((constraints.width.type == GTKLayoutConstraintTypeFlexible) &&
	 	constraints.width.value != 0) {
		width = ceil((double)(frame.width) / 100 * constraints.width.value);
	} else {
		width = constraints.width.value;
	}

	if ((constraints.height.type == GTKLayoutConstraintTypeFlexible) &&
		 constraints.height.value != 0) {
		height = ceil((double)(frame.height) / 100 * constraints.height.value);
	} else {
		height = constraints.height.value;
	}

	if ((constraints.top.type == GTKLayoutConstraintTypeFlexible) &&
		(constraints.top.value == 0)) {
		top = frame.height - height - bottom;
	}

	if ((constraints.height.type == GTKLayoutConstraintTypeFlexible) &&
		(constraints.height.value == 0)) {
		height = frame.height - top - bottom;
	}

	if ((constraints.bottom.type == GTKLayoutConstraintTypeFlexible) &&
		(constraints.bottom.value == 0)) {
		bottom = frame.height - top - height;
	}

	if ((constraints.left.type == GTKLayoutConstraintTypeFlexible) &&
		(constraints.left.value == 0)) {
		left = frame.width - width - right;
	}

	if ((constraints.width.type == GTKLayoutConstraintTypeFlexible) &&
		(constraints.width.value == 0)) {
		width = frame.width - left - right;
	}

	if ((constraints.right.type == GTKLayoutConstraintTypeFlexible) &&
		(constraints.right.value == 0)) {
		right = frame.width - left - width;
	}

	subframe.x = left;
	subframe.y = top;
	subframe.width = frame.width - left - right;
	subframe.height = frame.height - top - bottom;

	if (constraints.centerVertical) {
		subframe.y = ((double)frame.height - subframe.height) / 2;
	}

	if (constraints.centerHorizontal) {
		subframe.x = ((double)frame.width - subframe.width) / 2;
	}

	if (subframe.width < 0) {
		subframe.width = 0;
	}

	if (subframe.height < 0) {
		subframe.height = 0;
	}

	return subframe;
}

- (void)layoutSubviews
{
	[GTKApp.dispatch.gtk sync: ^{
        OFMutableArray *subviews = [OFMutableArray new];

        [subviews addObjectsFromArray: self.backgroundLayerSubviews];
        [subviews addObjectsFromArray: self.defaultLayerSubviews];
        [subviews addObjectsFromArray: self.foregroundLayerSubviews];
        [subviews addObjectsFromArray: self.notificationLayerSubviews];

        [self.backgroundLayerSubviews removeAllObjects];
        [self.defaultLayerSubviews removeAllObjects];
        [self.foregroundLayerSubviews removeAllObjects];
        [self.notificationLayerSubviews removeAllObjects];

        for (GTKView *view in subviews) {
            switch (view.layer) {
            case GTKViewLayerBackground:
                [self.backgroundLayerSubviews addObject: view];
                break;
            case GTKViewLayerDefault:
                [self.defaultLayerSubviews addObject: view];
                break;
            case GTKViewLayerForeground:
                [self.foregroundLayerSubviews addObject: view];
                break;
            case GTKViewLayerNotification:
                [self.notificationLayerSubviews addObject: view];
                break;
            }
        }

        for (GTKView *view in self.backgroundLayerSubviews) {
            gtk_overlay_reorder_overlay(
                GTK_OVERLAY(self.overlayWidget),
                view.overlayWidget,
                -1);
        }

        for (GTKView *view in self.defaultLayerSubviews) {
            gtk_overlay_reorder_overlay(
                GTK_OVERLAY(self.overlayWidget),
                view.overlayWidget,
                -1);
        }

        for (GTKView *view in self.foregroundLayerSubviews) {
            gtk_overlay_reorder_overlay(
                GTK_OVERLAY(self.overlayWidget),
                view.overlayWidget,
                -1);
        }

        for (GTKView *view in self.notificationLayerSubviews) {
            gtk_overlay_reorder_overlay(
                GTK_OVERLAY(self.overlayWidget),
                view.overlayWidget,
                -1);
        }
	}];
	for (GTKView *view in self.backgroundLayerSubviews) {
		[view layoutSubviews];
	}
	for (GTKView *view in self.defaultLayerSubviews) {
		[view layoutSubviews];
	}
	for (GTKView *view in self.foregroundLayerSubviews) {
		[view layoutSubviews];
	}
	for (GTKView *view in self.notificationLayerSubviews) {
		[view layoutSubviews];
	}
}

- (void)draw
{
	// The default implementation of this method does nothing.
}

- (void)addSubview:(GTKView *)view
{
    switch (view.layer) {
    case GTKViewLayerBackground:
    	if (![self.backgroundLayerSubviews containsObject: view]) {
    		[self.backgroundLayerSubviews addObject: view];
    	}
        break;
    case GTKViewLayerDefault:
    	if (![self.defaultLayerSubviews containsObject: view]) {
    		[self.defaultLayerSubviews addObject: view];
    	}
        break;
    case GTKViewLayerForeground:
    	if (![self.foregroundLayerSubviews containsObject: view]) {
    		[self.foregroundLayerSubviews addObject: view];
    	}
        break;
    case GTKViewLayerNotification:
    	if (![self.notificationLayerSubviews containsObject: view]) {
    		[self.notificationLayerSubviews addObject: view];
    	}
        break;
    }

    [view removeFromSuperview];
    view.superview = self;
    view.nextResponder = self;
    view.viewController = self.viewController;

    [GTKApp.dispatch.gtk sync: ^{
        gtk_overlay_add_overlay(
            GTK_OVERLAY(self.overlayWidget),
            view.overlayWidget);
    }];

    [self layoutSubviews];
}

- (void)removeFromSuperview
{
	[GTKApp.dispatch.gtk sync: ^{
		gtk_widget_unparent(self.overlayWidget);
	}];
	[self.superview.backgroundLayerSubviews removeObject: self];
	[self.superview.defaultLayerSubviews removeObject: self];
	[self.superview.foregroundLayerSubviews removeObject: self];
	[self.superview.notificationLayerSubviews removeObject: self];
	[self.superview layoutSubviews];
	self.superview = nil;
	self.nextResponder = nil;
}

- (double)alpha
{
    __block double alpha;
    [GTKApp.dispatch.gtk sync: ^{
        alpha = gtk_widget_get_opacity(self.mainWidget);
    }];
    return alpha;
}

- (void)setAlpha:(double)alpha
{
    [GTKApp.dispatch.gtk sync: ^{
        gtk_widget_set_opacity(self.mainWidget, alpha);
    }];
}

- (GTKViewController *)viewController
{
    if (nil == _viewController) {
        return self.superview.viewController;
    } else {
        return _viewController;
    }
}

- (void)setViewController:(GTKViewController *)viewController
{
    _viewController = viewController;
}

- (void)becomeFirstResponder
{
    if (self.canBecomeFirstResponder &&
        self.shouldBecomeFirstResponder &&
        nil != self.viewController) {
        [self willBecomeFirstResponder];
        self.viewController.firstResponder = self;
        [self didBecomeFirstResponder];
    }
}

/*
- (void)mouseDragged:(nonnull GTKEvent*)event
{
    printf("Origin: %d,%d\n", event.originX, event.originY);
    printf("Delta: %f,%f\n", event.deltaX, event.deltaY);
    printf("Result: %d,%d\n", event.mouseX, event.mouseY);
}
*/
@end
