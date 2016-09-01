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

#import "GTKEntry.h"

@implementation GTKEntry
- init
{
	self = [super init];

	self.widget = gtk_entry_new();
	g_object_ref_sink(G_OBJECT(self.widget));
	g_object_set_data(G_OBJECT(self.widget), "_GTKKIT_WRAPPER_WIDGET_",
	    (__bridge void*)self);

	self.buffer = gtk_entry_buffer_new(NULL, -1);
	gtk_entry_set_buffer(GTK_ENTRY(self.widget), _buffer);
	_widgetDestroyedHandlerID = g_signal_connect(G_OBJECT(self.widget),
	    "destroy", G_CALLBACK(widget_destroyed_handler),
	    (__bridge void*)self);

	return self;
}

- (OFString*)stringValue
{
	if (self.widget == NULL)
		@throw [GTKDestroyedWidgetException new];

	return @(gtk_entry_get_text(GTK_ENTRY(self.widget)));
}

- (void)setStringValue: (id)text
{
	if (self.widget == NULL)
		@throw [GTKDestroyedWidgetException new];

	gtk_entry_set_text(GTK_ENTRY(self.widget), [text UTF8String]);
}

- (void)setTextVisible: (bool)visible
{
	if (self.widget == NULL)
		@throw [GTKDestroyedWidgetException new];

	gtk_entry_set_visibility(GTK_ENTRY(self.widget), visible);
}

- (bool)textVisible
{
	if (self.widget == NULL)
		@throw [GTKDestroyedWidgetException new];

	return gtk_entry_get_visibility(GTK_ENTRY(self.widget));
}

- (void)setMaximumLength: (int)max
{
	if (self.widget == NULL)
		@throw [GTKDestroyedWidgetException new];

	gtk_entry_set_max_length(GTK_ENTRY(self.widget), max);
}

- (int)maximumLength
{
	if (self.widget == NULL)
		@throw [GTKDestroyedWidgetException new];

	return gtk_entry_get_max_length(GTK_ENTRY(self.widget));
}

- (bool)hasFrame
{
	if (self.widget == NULL)
		@throw [GTKDestroyedWidgetException new];

	return gtk_entry_get_has_frame(GTK_ENTRY(self.widget));
}

- (void)setHasFrame: (bool)setting
{
	if (self.widget == NULL)
		@throw [GTKDestroyedWidgetException new];

	gtk_entry_set_has_frame(GTK_ENTRY(self.widget), setting);
}
@end
