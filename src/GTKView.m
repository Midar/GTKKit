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

@interface GTKView ()
- (GtkWidget *)createMainWidget;
@end

@implementation GTKView
- init
{
	self = [super init];
	self.subviews = [OFMutableArray new];
	self.constraints = [GTKLayoutConstraints new];

	self.hidden = false;
	self.alpha = 1.0;

	GTKCallback(^{
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

		self.mainWidget = [self createMainWidget];
		gtk_container_add(GTK_CONTAINER(self.overlayWidget), self.mainWidget);
		gtk_widget_show(self.mainWidget);
		gtk_widget_show(self.overlayWidget);
	});

	return self;
}

- (GtkWidget *)createMainWidget
{
	return gtk_frame_new(NULL);
}

- (void)dealloc
{
	if (self.overlayWidget != NULL) {
		GTKCallback(^{
			g_signal_handler_disconnect(
				G_OBJECT(self.overlayWidget),
				self.childPositionHandlerID);

			g_signal_handler_disconnect(
				G_OBJECT(self.overlayWidget),
				self.widgetDestroyedHandlerID);

		    gtk_widget_destroy(GTK_WIDGET(self.overlayWidget));
	        self.overlayWidget = NULL;
		});
    }
}

- (bool)isHidden
{
    __block bool hidden;
    GTKCallback(^{
        hidden = !gtk_widget_get_visible(self.overlayWidget);
    });
    return hidden;
}

- (void)setHidden:(bool)hidden
{
    GTKCallback(^{
        gtk_widget_set_visible(self.overlayWidget, !hidden);
    });
}

- (GTKRect)frame
{
	__block GtkAllocation alloc;
	GTKCallback(^{
		gtk_widget_get_allocation(self.overlayWidget, &alloc);
	});
	return (GTKRect)alloc;
}

- (GTKRect)layoutSubview:(nonnull GTKView*)subview
{
	GTKRect frame = self.frame;

	GTKRect subframe;
	subframe.x = 0;
	subframe.y = 0;
	subframe.width = 0;
	subframe.height = 0;

	// Pixel values:
	int top = 0;
	int bottom = 0;
	int left = 0;
	int right = 0;
	int horizontal = 0;
	int vertical = 0;

	// If we make it this far, we know the pixel values will be valid.
	if ((subview.constraints.top.type == GTKLayoutConstraintTypeFlexible) &&
		 subview.constraints.top.value != 0) {
		top = ceil((double)(frame.height) / 100 * subview.constraints.top.value);
	} else {
		top = subview.constraints.top.value;
	}

	if ((subview.constraints.bottom.type == GTKLayoutConstraintTypeFlexible) &&
	 	subview.constraints.bottom.value != 0) {
		bottom = ceil((double)(frame.height) / 100 * subview.constraints.bottom.value);
	} else {
		bottom = subview.constraints.bottom.value;
	}

	if ((subview.constraints.left.type == GTKLayoutConstraintTypeFlexible) &&
	 	subview.constraints.left.value != 0) {
		left = ceil((double)(frame.width) / 100 * subview.constraints.left.value);
	} else {
		left = subview.constraints.left.value;
	}

	if ((subview.constraints.right.type == GTKLayoutConstraintTypeFlexible) &&
		 subview.constraints.right.value != 0) {
		right = ceil((double)(frame.width) / 100 * subview.constraints.right.value);
	} else {
		right = subview.constraints.right.value;
	}

	if ((subview.constraints.horizontal.type == GTKLayoutConstraintTypeFlexible) &&
	 	subview.constraints.horizontal.value != 0) {
		horizontal = ceil((double)(frame.width) / 100 * subview.constraints.horizontal.value);
	} else {
		horizontal = subview.constraints.horizontal.value;
	}

	if ((subview.constraints.vertical.type == GTKLayoutConstraintTypeFlexible) &&
		 subview.constraints.vertical.value != 0) {
		vertical = ceil((double)(frame.height) / 100 * subview.constraints.vertical.value);
	} else {
		vertical = subview.constraints.vertical.value;
	}

	if ((subview.constraints.top.type == GTKLayoutConstraintTypeFlexible) &&
		(subview.constraints.top.value == 0)) {
		top = frame.height - vertical - bottom;
	}

	if ((subview.constraints.vertical.type == GTKLayoutConstraintTypeFlexible) &&
		(subview.constraints.vertical.value == 0)) {
		vertical = frame.height - top - bottom;
	}

	if ((subview.constraints.bottom.type == GTKLayoutConstraintTypeFlexible) &&
		(subview.constraints.bottom.value == 0)) {
		bottom = frame.height - top - vertical;
	}

	if ((subview.constraints.left.type == GTKLayoutConstraintTypeFlexible) &&
		(subview.constraints.left.value == 0)) {
		left = frame.width - horizontal - right;
	}

	if ((subview.constraints.horizontal.type == GTKLayoutConstraintTypeFlexible) &&
		(subview.constraints.horizontal.value == 0)) {
		horizontal = frame.width - left - right;
	}

	if ((subview.constraints.right.type == GTKLayoutConstraintTypeFlexible) &&
		(subview.constraints.right.value == 0)) {
		right = frame.width - left - horizontal;
	}

	subframe.x = left;
	subframe.y = top;
	subframe.width = frame.width - left - right;
	subframe.height = frame.height - top - bottom;

	if (subframe.width < 0) {
		subframe.width = 0;
	}

	if (subframe.height < 0) {
		subframe.height = 0;
	}

	printf("x: %d\ny: %d\nwidth: %d\nheight: %d\n", subframe.x, subframe.y, subframe.width, subframe.height);

	return subframe;
}

- (void)layoutSubviews
{
	GTKCallback(^{
		for (GTKView *view in self.subviews) {
			size_t index = [self.subviews indexOfObject: view];
			gtk_overlay_reorder_overlay(
				GTK_OVERLAY(self.overlayWidget),
				view.overlayWidget,
				(int)(index));
		}
	});
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
	if (![self.subviews containsObject: view]) {
		[self.subviews addObject: view];
		[view removeFromSuperview];
		view.superview = self;
		GTKCallback(^{
			gtk_overlay_add_overlay(
				GTK_OVERLAY(self.overlayWidget),
				view.overlayWidget);
		});
		[self layoutSubviews];
	}
}

- (void)removeFromSuperview
{
	[self.superview.subviews removeObject: self];
	GTKCallback(^{
		gtk_widget_unparent(self.overlayWidget);
	});
	[self.superview layoutSubviews];
	self.superview = nil;
}
@end
