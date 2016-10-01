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
#import "GTKWidget.h"
#import "GTKOverlay.h"
#import "GTKInvisible.h"

gboolean
gtkkit_get_child_position(GtkOverlay   *overlay,
						  GtkWidget    *widget,
						  GdkRectangle *allocation,
						  GTKView      *view)
{
	GTKView *parentview = view.superview;
	if (NULL == parentview) {
		return false;
	}

	GTKRect positon = [parentview layoutSubview: view];
	allocation->x = positon.x;
	allocation->y = positon.y;
	allocation->width = positon.width;
	allocation->height = positon.height;

	return true;
}

void
gtkkit_overlay_widget_destroyed_handler(GtkWidget *overlay,
                                        GTKView   *view)
{
	g_object_unref(G_OBJECT(overlay));
    view.overlayWidget = NULL;
}

static gboolean
initCallback(GTKView self)
{

}

@implementation GTKView
- init
{
	self = [super init];
	if (nil == self) {
		return nil;
	}

	self.subviews = [OFMutableArray new];
    if (nil == self.subviews) {
        return nil;
    }

	self.constraints = [GTKLayoutConstraints new];
    if (nil == self.constraints) {
        return nil;
    }

	self.hidden = false;
	self.alpha = 1.0;

	self.overlayWidget = gtkkit_gtk_overlay_new();
    if (NULL == self.overlayWidget) {
        return nil;
    }

	self.mainWidget = gtkkit_gtk_invisible_new();
    if (NULL == self.mainWidget) {
        return nil;
    }

	g_object_ref_sink(G_OBJECT(self.overlayWidget));
	g_object_set_data(G_OBJECT(self.overlayWidget),
					  "_GTKKIT_WRAPPER_VIEW_",
					  (__bridge void*)self);

	_get_child_position_handler_id = g_signal_connect(G_OBJECT(self.overlayWidget),
		"get-child-position", G_CALLBACK(gtkkit_get_child_position),
		(__bridge void*)self);
    if (0 == _get_child_position_handler_id) {
        return nil;
    }

    _widget_destroyed_handler_id = g_signal_connect(G_OBJECT(self.overlayWidget),
        "destroy", G_CALLBACK(gtkkit_overlay_widget_destroyed_handler),
        (__bridge void*)self);

    if (0 == _widget_destroyed_handler_id) {
        return nil;
    }

	return self;
}

- (void)dealloc
{
	if (self.overlayWidget != NULL) {
		g_signal_handler_disconnect(G_OBJECT(self.overlayWidget),
									_get_child_position_handler_id);

		g_signal_handler_disconnect(G_OBJECT(self.overlayWidget),
									_widget_destroyed_handler_id);

	    gtkkit_gtk_widget_destroy(GTK_WIDGET(self.overlayWidget));

        self.overlayWidget = NULL;
    }
}

- (GTKRect)frame
{
	GtkAllocation alloc;
	gtk_widget_get_allocation(self.overlayWidget, &alloc);
	return (GTKRect)alloc;
}

- (GTKRect)layoutSubview:(nonnull GTKView*)subview
{
	// We copy this so it doesn't change midway throgh for whatever reason.
	// Probably excess of caution, but it doesn't hurt.
	GTKRect frame = self.frame;

	GTKRect subframe;


	//FIXME: Actually do something.
	subframe.x = 0;
	subframe.y = 0;
	subframe.width = 0;
	subframe.height = 0;
	return subframe;
}

- (void)layoutSubviews
{
	return;
}

- (void)draw
{
	return;
}
@end
