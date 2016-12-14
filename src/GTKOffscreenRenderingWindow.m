/*! @file GTKOffscreenRenderingWindow.m
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

#import "GTKOffscreenRenderingWindow.h"
#import "GTKApplication.h"

@implementation GTKOffscreenRenderingWindow
- init
{
	self = [super init];
	self.contentView = [GTKView new];
	[GTKApp.dispatch.gtk sync: ^{
		_offscreenWindow = gtk_offscreen_window_new();
		g_object_ref_sink(G_OBJECT(_offscreenWindow));
		g_object_set_data(
		    G_OBJECT(_offscreenWindow),
		    "_GTKKIT_OWNING_VIEW_CONTROLLER_",
		    (__bridge gpointer) self);
		gtk_widget_set_size_request(
		    _offscreenWindow,
		    1,
		    1);
		gtk_container_add(
		    GTK_CONTAINER(_offscreenWindow),
		    self.contentView.overlayWidget);
	}];
	return self;
}

- (void)dealloc
{
	g_object_unref(_offscreenWindow);
}

- (GTKImage *)image
{
	GdkPixbuf *pixbuf = gtk_offscreen_window_get_pixbuf(
	    GTK_OFFSCREEN_WINDOW(_offscreenWindow));
	return [GTKImage imageWithPixbuf: pixbuf];
}

- (void)addView: (nonnull GTKView *)subview
{
	[self.contentView addSubview: subview];
}

- (GTKRect)frame
{
	__block GTKRect frame;
	frame.x = 0;
	frame.y = 0;
	[GTKApp.dispatch.gtk sync: ^{
		gtk_widget_get_size_request(
		    _offscreenWindow,
		    &frame.width,
		    &frame.height);
	}];
	return frame;
}

- (void)setFrame: (GTKRect)frame
{
	[GTKApp.dispatch.gtk sync: ^{
		gtk_widget_set_size_request(
		    _offscreenWindow,
		    frame.width,
		    frame.height);
	}];
}
@end
