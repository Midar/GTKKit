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

#import "GTKScale.h"

static gboolean
gtk_scale_value_changed(GtkScale *scale, GtkScrollType scroll, gdouble value,
    GTKScale *sender)
{
	if (sender.target != nil && sender.action != NULL) {
		void (*imp)(id, SEL, id) = (void(*)(id, SEL, id))
		    [sender.target methodForSelector: sender.action];
		imp(sender.target, sender.action, sender);
	}

	return FALSE;
}

static gchar*
format_gtk_scale_value(GtkScale *scale, gdouble value, GTKScale *sender)
{
	return g_strdup_printf([sender.formatString UTF8String],
	    gtk_scale_get_digits(scale), value);
}

@implementation GTKScale
- init
{
	self = [super init];

	GtkAdjustment *adj = gtk_adjustment_new(0, 0, 0, 1.0, 1.0, 0);
	self.widget = gtk_scale_new(GTK_ORIENTATION_HORIZONTAL, adj);
	g_object_ref_sink(G_OBJECT(self.widget));
	g_object_set_data(G_OBJECT(self.widget), "_GTKKIT_WRAPPER_WIDGET_",
	    (__bridge void*)self);

	_valueChangedHandlerID = g_signal_connect(GTK_WIDGET(self.widget),
	    "change-value", G_CALLBACK(gtk_scale_value_changed),
	    (__bridge void*)self);
	_formatHandlerID = g_signal_connect(GTK_WIDGET(self.widget),
	    "format-value", G_CALLBACK (format_gtk_scale_value),
	    (__bridge void*)self);
	_widgetDestroyedHandlerID = g_signal_connect(G_OBJECT(self.widget),
	    "destroy", G_CALLBACK(widget_destroyed_handler),
	    (__bridge void*)self);

	gtk_scale_set_digits(GTK_SCALE(self.widget), 2);
	gtk_scale_set_value_pos (GTK_SCALE(self.widget), GTK_POS_TOP);

	self.formatString = @"%f";

	return self;
}

- (void)dealloc
{
	if (self.widget != NULL) {
		g_signal_handler_disconnect(G_OBJECT(self.widget),
		    _valueChangedHandlerID);
		g_signal_handler_disconnect(G_OBJECT(self.widget),
		    _formatHandlerID);
	}
}

- (int)digits
{
	if (self.widget == NULL)
		@throw [GTKDestroyedWidgetException new];

	return gtk_scale_get_digits(GTK_SCALE(self.widget));
}

- (void)setDigits: (int)newValue
{
	if (self.widget == NULL)
		@throw [GTKDestroyedWidgetException new];

	gtk_scale_set_digits(GTK_SCALE(self.widget), newValue);
}
@end
