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
#import "GTKCallBack.h"

static gboolean
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

	GTKCallback *callback = [GTKCallback new];
	callback.sender = self;

	[callback waitForBlock: ^(GTKCallback *callback) {
		callback.widgetValue = gtk_overlay_new();
		g_object_ref_sink(G_OBJECT(callback.widgetValue));

		_get_child_position_handler_id = g_signal_connect(G_OBJECT(callback.widgetValue),
			"get-child-position", G_CALLBACK(gtkkit_get_child_position),
			(__bridge void*)callback.sender);

	    _widget_destroyed_handler_id = g_signal_connect(G_OBJECT(callback.widgetValue),
	        "destroy", G_CALLBACK(gtkkit_overlay_widget_destroyed_handler),
	        (__bridge void*)callback.sender);
	}];
	self.overlayWidget = callback.widgetValue;

	[callback waitForBlock: ^(GTKCallback *callback) {
		callback.widgetValue = gtk_invisible_new();
		g_object_ref_sink(G_OBJECT(callback.widgetValue));
	}];
	self.mainWidget = callback.widgetValue;

	return self;
}

- (void)dealloc
{
	if (self.overlayWidget != NULL) {
		GTKCallback *callback = [GTKCallback new];
		callback.widget = self.overlayWidget;
		[callback waitForBlock: ^(GTKCallback *callback){
			g_signal_handler_disconnect(G_OBJECT(callback.widget),
										_get_child_position_handler_id);

			g_signal_handler_disconnect(G_OBJECT(callback.widget),
										_widget_destroyed_handler_id);

		    gtk_widget_destroy(GTK_WIDGET(callback.widget));
		}];
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
