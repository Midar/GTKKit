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

#import "GTKOverlay.h"

@implementation GTKOverlay
- init
{
	self = [super init];

	self.widget = gtk_overlay_new();
	g_object_ref_sink(G_OBJECT(self.widget));
	g_object_set_data(G_OBJECT(self.widget), "_GTKKIT_WRAPPER_WIDGET_",
	    (__bridge void*)self);

	_widgetDestroyedHandlerID = g_signal_connect(G_OBJECT(self.widget),
	    "destroy", G_CALLBACK(gtkkit_widget_destroyed_handler),
	    (__bridge void*)self);

	return self;
}

- (bool)overlayChildPassthrough: (GTKWidget*)child
{
	return gtk_overlay_get_overlay_pass_through(GTK_OVERLAY(self.widget),
	    GTK_WIDGET(child.widget));
}

- (void)setOverlayChildPassthrough: (GTKWidget*)child
                                to: (bool)passthrough
{
	gtk_overlay_set_overlay_pass_through(GTK_OVERLAY(self.widget),
	    GTK_WIDGET(child.widget), passthrough);
}

- (void)addOverlayChild: (GTKWidget*)child
{
	child.parent = self;
	gtk_overlay_add_overlay(GTK_OVERLAY(self.widget),
	    GTK_WIDGET([child widget]));
}

- (void)reorderOverlayChild: (GTKWidget*)child
                    toIndex: (int)index
{
	gtk_overlay_reorder_overlay(GTK_OVERLAY(self.widget),
	    GTK_WIDGET([child widget]), index);
}
@end
