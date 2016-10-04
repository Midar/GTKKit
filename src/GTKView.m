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
gtkkit_get_child_position(GtkOverlay   *overlay,
						  GtkWidget    *widget,
						  GdkRectangle *allocation,
						  GTKView      *view)
{
	printf("Layout callback called!\n");
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
gtkkit_overlay_widget_destroyed_handler(GtkWidget *overlay,
                                        GTKView   *view)
{
	g_object_unref(G_OBJECT(overlay));
    view.overlayWidget = NULL;
}

@implementation GTKView
- init
{
	self = [super init];
	self.subviews = [OFMutableArray new];
	self.constraints = [GTKLayoutConstraints new];

	self.hidden = false;
	self.alpha = 1.0;

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
			G_CALLBACK(gtkkit_get_child_position),
			(__bridge gpointer)(self));

	    self.widgetDestroyedHandlerID = g_signal_connect(
			G_OBJECT(self.overlayWidget),
	        "destroy",
			G_CALLBACK(gtkkit_overlay_widget_destroyed_handler),
	        (__bridge gpointer)(self));

		self.mainWidget = gtk_frame_new(NULL);
		gtk_container_add(GTK_CONTAINER(self.overlayWidget), self.mainWidget);
		gtk_widget_show(self.mainWidget);

		gtk_widget_show(self.overlayWidget);
	}];

	return self;
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

		    gtk_widget_destroy(GTK_WIDGET(self.overlayWidget));
	        self.overlayWidget = NULL;
		}];
    }
}

- (bool)isHidden
{
	return _hidden;
}

- (void)setHidden:(bool)hidden
{
	_hidden = hidden;
	[self.superview layoutSubviews];
}

- (GTKRect)layoutSubview:(nonnull GTKView*)subview
{
	int width = gtk_widget_get_allocated_width(self.overlayWidget);
	int height = gtk_widget_get_allocated_height(self.overlayWidget);

	printf("Layout 1.5\n");
	GTKRect subframe;
	subframe.x = 0;
	subframe.y = 0;
	subframe.width = 0;
	subframe.height = 0;

	printf("Layout 2\n");
	// Pixel values:
	int top = 0;
	int bottom = 0;
	int left = 0;
	int right = 0;
	int horizontal = 0;
	int vertical = 0;

	printf("Layout 3\n");
	int horizontalDontCareCount = 0;
	int verticalDontCareCount = 0;

	printf("Layout 4\n");
	if (subview.constraints.left.type == GTKLayoutConstraintTypeFixed &&
		subview.constraints.left.value == 0) {
		horizontalDontCareCount++;
	}

	if (subview.constraints.horizontal.type == GTKLayoutConstraintTypeFixed &&
		subview.constraints.horizontal.value == 0) {
		horizontalDontCareCount++;
	}

	if (subview.constraints.right.type == GTKLayoutConstraintTypeFixed &&
		subview.constraints.right.value == 0) {
		horizontalDontCareCount++;
	}

	if (subview.constraints.top.type == GTKLayoutConstraintTypeFixed &&
		subview.constraints.top.value == 0) {
		verticalDontCareCount++;
	}

	if (subview.constraints.vertical.type == GTKLayoutConstraintTypeFixed &&
		subview.constraints.vertical.value == 0) {
		verticalDontCareCount++;
	}

	if (subview.constraints.bottom.type == GTKLayoutConstraintTypeFixed &&
		subview.constraints.bottom.value == 0) {
		verticalDontCareCount++;
	}

	printf("Layout 6\n");
	// If we make it this far, we know the pixel values will be valid.
	if ((subview.constraints.top.type == GTKLayoutConstraintTypeFlexible) &&
		 subview.constraints.top.value != 0) {
		top = ceil(height / 100 * subview.constraints.top.value);
	} else {
		top = subview.constraints.top.value;
	}

	if ((subview.constraints.bottom.type == GTKLayoutConstraintTypeFlexible) &&
	 	subview.constraints.bottom.value != 0) {
		bottom = ceil(height / 100 * subview.constraints.bottom.value);
	} else {
		bottom = subview.constraints.bottom.value;
	}

	if ((subview.constraints.left.type == GTKLayoutConstraintTypeFlexible) &&
	 	subview.constraints.left.value != 0) {
		left = ceil(width / 100 * subview.constraints.left.value);
	} else {
		left = subview.constraints.left.value;
	}

	if ((subview.constraints.right.type == GTKLayoutConstraintTypeFlexible) &&
		 subview.constraints.right.value != 0) {
		right = ceil(width / 100 * subview.constraints.right.value);
	} else {
		right = subview.constraints.right.value;
	}

	if ((subview.constraints.horizontal.type == GTKLayoutConstraintTypeFlexible) &&
	 	subview.constraints.horizontal.value != 0) {
		horizontal = ceil(width / 100 * subview.constraints.horizontal.value);
	} else {
		top = subview.constraints.horizontal.value;
	}

	if ((subview.constraints.vertical.type == GTKLayoutConstraintTypeFlexible) &&
		 subview.constraints.vertical.value != 0) {
		vertical = ceil(width / 100 * subview.constraints.vertical.value);
	} else {
		vertical = subview.constraints.vertical.value;
	}

	printf("Layout 7\n");
	if ((subview.constraints.top.type == GTKLayoutConstraintTypeFlexible) &&
		(subview.constraints.top.value == 0)) {
		top = height - vertical - bottom;
	}

	if ((subview.constraints.vertical.type == GTKLayoutConstraintTypeFlexible) &&
		(subview.constraints.vertical.value == 0)) {
		top = height - top - bottom;
	}

	if ((subview.constraints.bottom.type == GTKLayoutConstraintTypeFlexible) &&
		(subview.constraints.bottom.value == 0)) {
		top = height - top - vertical;
	}

	if ((subview.constraints.left.type == GTKLayoutConstraintTypeFlexible) &&
		(subview.constraints.left.value == 0)) {
		top = width - horizontal - right;
	}

	if ((subview.constraints.horizontal.type == GTKLayoutConstraintTypeFlexible) &&
		(subview.constraints.horizontal.value == 0)) {
		top = width - left - right;
	}

	if ((subview.constraints.right.type == GTKLayoutConstraintTypeFlexible) &&
		(subview.constraints.right.value == 0)) {
		top = width - left - horizontal;
	}

	printf("Layout 8\n");
	subframe.x = left;
	subframe.y = top;
	subframe.width = width - right;
	subframe.height = height - bottom;

	printf("Layout 9\n");
	printf("x: %d\ny: %d\nwidth: %d\nheight: %d\n", subframe.x, subframe.y, subframe.width, subframe.height);

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
			if (view.isHidden) {
				gtk_widget_hide(view.overlayWidget);
			} else {
				gtk_widget_show(view.overlayWidget);
			}
		}
	}];
	for (GTKView *view in self.subviews) {
		[view layoutSubviews];
	}
}

- (void)draw
{
	// The default implementation here does nothing.
	return;
}

- (void)addSubview:(GTKView *)view
{
	[GTKCallback sync: ^{
		gtk_overlay_add_overlay(
			GTK_OVERLAY(self.overlayWidget),
			view.overlayWidget);
	}];
}

- (void)removeFromSuperview
{

}
@end
