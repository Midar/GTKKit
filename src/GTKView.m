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

#import "GTKView.h"
#import "GTKCallback.h"
#import "GTKLayoutConstraints.h"
#import "Exceptions.h"

static gboolean
draw_handler(GtkWidget *widget,
      		 void      *cr,
      		 GTKView   *view)
{
	[view draw];
	[view layoutSubviews];
	return false;
}

static gboolean
get_child_position_handler(GtkOverlay   *overlay,
				   		   GtkWidget    *widget,
				   		   GdkRectangle *allocation,
				   		   GTKView      *view)
{
	GTKView *subview = (__bridge GTKView *)g_object_get_data(
		G_OBJECT(widget), "_GTKKIT_OWNING_VIEW_");
	if (nil == subview) {
		printf("Error: Subview is nil!\n");
		return false;
	}

	GTKRect frame = [view layoutSubview: subview];

	allocation->x = frame.x;
	allocation->y = frame.y;
	allocation->width = frame.width;
	allocation->height = frame.height;

	return true;
}

static void
overlay_widget_destroyed_handler(GtkWidget *overlay,
                                 GTKView   *view)
{
	g_object_unref(G_OBJECT(overlay));
    view.overlayWidget = NULL;
}

@interface GTKView ()
- (void)createMainWidget;
@end

@implementation GTKView
- init
{
	self = [super init];
	self.subviews = [OFMutableArray new];
	self.constraints = [GTKLayoutConstraints new];

	[GTKCallback sync: ^{
		self.overlayWidget = gtk_overlay_new();
		g_object_ref_sink(G_OBJECT(self.overlayWidget));

		g_object_set_data(
			G_OBJECT(self.overlayWidget),
			"_GTKKIT_OWNING_VIEW_",
		    (__bridge gpointer)self);

		self.childPositionHandlerID = g_signal_connect(
			G_OBJECT(self.overlayWidget),
			"get-child-position",
			G_CALLBACK(get_child_position_handler),
			(__bridge gpointer)(self));

	    self.drawHandlerID = g_signal_connect(
			G_OBJECT(self.overlayWidget),
	        "draw",
			G_CALLBACK(draw_handler),
	        (__bridge gpointer)(self));

	    self.widgetDestroyedHandlerID = g_signal_connect(
			G_OBJECT(self.overlayWidget),
	        "destroy",
			G_CALLBACK(overlay_widget_destroyed_handler),
	        (__bridge gpointer)(self));

		[self createMainWidget];
        g_object_ref_sink(G_OBJECT(self.mainWidget));
		gtk_container_add(GTK_CONTAINER(self.overlayWidget), self.mainWidget);
		gtk_widget_show(self.mainWidget);
		gtk_widget_show(self.overlayWidget);
	}];

	self.hidden = false;

	self.alpha = 1.0;

	return self;
}

- (void)createMainWidget
{
    [GTKCallback sync: ^{
        self.mainWidget = gtk_frame_new(NULL);
    }];
}

- (void)dealloc
{
	if (self.overlayWidget != NULL) {
		[GTKCallback sync: ^{
			g_signal_handler_disconnect(
				G_OBJECT(self.overlayWidget),
				self.childPositionHandlerID);

			g_signal_handler_disconnect(
				G_OBJECT(self.overlayWidget),
				self.widgetDestroyedHandlerID);

		    gtk_widget_destroy(self.mainWidget);
            gtk_widget_destroy(self.overlayWidget);
	        self.overlayWidget = NULL;
	        self.mainWidget = NULL;
		}];
    }
}

- (bool)isHidden
{
    __block bool hidden;
    [GTKCallback sync: ^{
        hidden = !gtk_widget_get_visible(self.overlayWidget);
    }];
    return hidden;
}

- (void)setHidden:(bool)hidden
{
    [GTKCallback sync: ^{
        gtk_widget_set_visible(self.overlayWidget, !hidden);
    }];
}

- (GTKRect)frame
{
	__block GtkAllocation alloc;
	[GTKCallback sync: ^{
		gtk_widget_get_allocation(self.overlayWidget, &alloc);
	}];
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
	[GTKCallback sync: ^{
		for (GTKView *view in self.subviews) {
			size_t index = [self.subviews indexOfObject: view];
			gtk_overlay_reorder_overlay(
				GTK_OVERLAY(self.overlayWidget),
				view.overlayWidget,
				(int)(index));
		}
	}];
	for (GTKView *view in self.subviews) {
		[view layoutSubviews];
	}
}

- (void)draw
{
	// The default implementation of this method does nothing.
}

- (void)addSubview:(GTKView *)view
{
	if (![self.subviews containsObject: view]) {
		[self.subviews addObject: view];
		[view removeFromSuperview];
		view.superview = self;
		view.nextResponder = self;
		[GTKCallback sync: ^{
			gtk_overlay_add_overlay(
				GTK_OVERLAY(self.overlayWidget),
				view.overlayWidget);
		}];
		[self layoutSubviews];
	}
}

- (void)removeFromSuperview
{
	[GTKCallback sync: ^{
		gtk_widget_unparent(self.overlayWidget);
	}];
	[self.superview.subviews removeObject: self];
	[self.superview layoutSubviews];
	self.superview = nil;
	self.nextResponder = nil;
}

- (double)alpha
{
    __block double alpha;
    [GTKCallback sync: ^{
        alpha = gtk_widget_get_opacity(self.mainWidget);
    }];
    return alpha;
}

- (void)setAlpha:(double)alpha
{
    [GTKCallback sync: ^{
        gtk_widget_set_opacity(self.mainWidget, alpha);
    }];
}
@end
