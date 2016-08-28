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

#import "GTKToggleButton.h"

static void
buttonToggled(GtkWidget *button, GTKButton *sender)
{
	if (sender.target != nil && sender.action != NULL) {
		void (*imp)(id, SEL, id) = (void(*)(id, SEL, id))
		    [sender.target methodForSelector: sender.action];

		imp(sender.target, sender.action, sender);
	}
}

@implementation GTKToggleButton
- init
{
	self = [super init];

	gtk_widget_destroy(GTK_WIDGET(self.widget));
	self.widget = gtk_toggle_button_new();
	g_object_ref_sink(G_OBJECT(self.widget));
	g_object_set_data(G_OBJECT(self.widget), "_GTKKIT_WRAPPER_WIDGET_",
	    (__bridge void*)self);

	_buttonToggledHandlerID = g_signal_connect(GTK_WIDGET(self.widget),
	    "toggled", G_CALLBACK(buttonToggled), (__bridge void*)self);
	_widgetDestroyedHandlerID = g_signal_connect(G_OBJECT(self.widget),
	    "destroy", G_CALLBACK(widget_destroyed_handler),
	    (__bridge void*)self);

	return self;
}

- (void)dealloc
{
	if (self.widget != NULL)
		g_signal_handler_disconnect(G_OBJECT(self.widget),
		    _buttonToggledHandlerID);
}

- (void)setDrawIndicator: (bool)newValue
{
	if (self.widget == NULL)
		@throw [GTKDestroyedWidgetException new];

	gtk_toggle_button_set_mode(GTK_TOGGLE_BUTTON(self.widget), newValue);
}

- (bool)drawIndicator
{
	if (self.widget == NULL)
		@throw [GTKDestroyedWidgetException new];

	return gtk_toggle_button_get_mode(GTK_TOGGLE_BUTTON(self.widget));
}

- (void)setActive: (bool)newValue
{
	if (self.widget == NULL)
		@throw [GTKDestroyedWidgetException new];

	gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(self.widget), newValue);
}

- (bool)active
{
	if (self.widget == NULL)
		@throw [GTKDestroyedWidgetException new];

	return gtk_toggle_button_get_active(GTK_TOGGLE_BUTTON(self.widget));
}

- (void)setInconsistent: (bool)newValue
{
	if (self.widget == NULL)
		@throw [GTKDestroyedWidgetException new];

	gtk_toggle_button_set_inconsistent(
	    GTK_TOGGLE_BUTTON(self.widget), newValue);
}

- (bool)inconsistent
{
	if (self.widget == NULL)
		@throw [GTKDestroyedWidgetException new];

	return gtk_toggle_button_get_inconsistent(
	    GTK_TOGGLE_BUTTON(self.widget));
}
@end
