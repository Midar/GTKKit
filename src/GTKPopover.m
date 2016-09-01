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

#import "GTKPopover.h"

static void
popoverClosed(GtkPopover *popover, GTKPopover *sender)
{
	if (sender.target != nil && sender.action != NULL) {
		void (*imp)(id, SEL, id) = (void(*)(id, SEL, id))
		    [sender.target methodForSelector: sender.action];

		imp(sender.target, sender.action, sender);
	}
}

@implementation GTKPopover
- init
{
	self = [super init];

	self.widget = gtk_popover_new(NULL);
	g_object_ref_sink(G_OBJECT(self.widget));
	g_object_set_data(G_OBJECT(self.widget), "_GTKKIT_WRAPPER_WIDGET_",
	    (__bridge void*)self);

	_widgetDestroyedHandlerID = g_signal_connect(G_OBJECT(self.widget),
	    "destroy", G_CALLBACK(widget_destroyed_handler),
	    (__bridge void*)self);
	_closedHandlerID = g_signal_connect(GTK_WIDGET(self.widget), "clicked",
	    G_CALLBACK(popoverClosed), (__bridge void*)self);

	return self;
}

- (void)dealloc
{
	if (self.widget != NULL)
		g_signal_handler_disconnect(G_OBJECT(self.widget),
		    _closedHandlerID);
}

+ (instancetype)popoverAttachedToWidget: (GTKWidget*)widget
{
	return [[self alloc] initAttachedToWidget: widget];
}

- initAttachedToWidget: (GTKWidget*)widget
{
	self = [self init];

	gtk_popover_set_relative_to(GTK_POPOVER(self.widget),
	    GTK_WIDGET(self.widget));

	return self;
}

- (GTKWidget*)attachedWidget
{
	GtkWidget *attached = gtk_popover_get_relative_to(
	    GTK_POPOVER(self.widget));
	return [GTKWidget wrapperForGtkWidget: attached];
}

- (void)setAttachedWidget: (GTKWidget*)target
{
	gtk_popover_set_relative_to(GTK_POPOVER(self.widget),
	    GTK_WIDGET(target.widget));
}

- (GtkPositionType)position
{
	return gtk_popover_get_position(GTK_POPOVER(self.widget));
}

- (void)setPosition: (GtkPositionType)position
{
	gtk_popover_set_position(GTK_POPOVER(self.widget), position);
}

- (bool)modal
{
	return gtk_popover_get_modal(GTK_POPOVER(self.widget));
}

- (void)setModal:(bool)modal
{
	gtk_popover_set_modal(GTK_POPOVER(self.widget), modal);
}

- (bool)transitionsEnabled
{
	return gtk_popover_get_transitions_enabled(GTK_POPOVER(self.widget));
}

- (void)setTransitionsEnabled: (bool)enable
{
	gtk_popover_set_transitions_enabled(GTK_POPOVER(self.widget), enable);
}

- (GTKWidget*)defaultWidget
{
	GtkWidget *attached =
	    gtk_popover_get_default_widget(GTK_POPOVER(self.widget));
	return [GTKWidget wrapperForGtkWidget: attached];
}

- (void)setDefaultWidget: (GTKWidget*)target
{
	gtk_popover_set_default_widget(GTK_POPOVER(self.widget),
	    GTK_WIDGET(target.widget));
}
@end
