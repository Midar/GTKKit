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

#import "GTKWidget.h"

void
widget_destroyed_handler(GtkWidget *widget, GTKWidget *wrapper)
{
	g_object_unref(G_OBJECT(wrapper.widget));
	wrapper.widget = NULL;
}

@implementation GTKWidget
+ (instancetype)wrapperForGtkWidget: (GtkWidget*)widget
{
	GTKWidget *wrapper = (__bridge GTKWidget*)g_object_get_data(
	    G_OBJECT(widget), "_GTKKIT_WRAPPER_WIDGET_");

	if (wrapper == NULL)
		@throw [GTKNoWrapperForGtkWidgetException new];

	return wrapper;
}

- (void)dealloc
{
	if (self.widget != NULL)
		g_signal_handler_disconnect(G_OBJECT(self.widget),
		    _widgetDestroyedHandlerID);
	gtk_widget_destroy(GTK_WIDGET(self.widget));
}
@end
