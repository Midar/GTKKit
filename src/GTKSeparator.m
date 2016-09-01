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

#import "GTKSeparator.h"

@implementation GTKSeparator
+ (instancetype)separatorWithOrientation: (GtkOrientation)orientation
{
	return [[self alloc] initWithOrientation: orientation];
}

- initWithOrientation: (GtkOrientation)orientation
{
	self = [super init];

	self.widget = gtk_separator_new(orientation);
	g_object_ref_sink(G_OBJECT(self.widget));
	g_object_set_data(G_OBJECT(self.widget), "_GTKKIT_WRAPPER_WIDGET_",
	    (__bridge void*)self);

	_widgetDestroyedHandlerID = g_signal_connect(G_OBJECT(self.widget),
	    "destroy", G_CALLBACK(widget_destroyed_handler),
	    (__bridge void*)self);

	return self;
}

- init
{
	OF_INVALID_INIT_METHOD
}

- (GtkOrientation)orientation
{
	if (self.widget == NULL)
		@throw [GTKDestroyedWidgetException new];

	return gtk_orientable_get_orientation (GTK_ORIENTABLE (self.widget));
}

- (void)setOrientation:(GtkOrientation)orientation
{
	if (self.widget == NULL)
		@throw [GTKDestroyedWidgetException new];

	gtk_orientable_set_orientation(GTK_ORIENTABLE(self.widget),
	    orientation);
}
@end
