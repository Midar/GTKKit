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

#import "GTKStack.h"

@implementation GTKStack
- init
{
	self = [super init];

	self.widget = gtk_stack_new();
	g_object_ref_sink(G_OBJECT(self.widget));
	g_object_set_data(G_OBJECT(self.widget), "_GTKKIT_WRAPPER_WIDGET_",
	    (__bridge void*)self);

	_widgetDestroyedHandlerID = g_signal_connect(G_OBJECT(self.widget),
	    "destroy", G_CALLBACK(gtkkit_widget_destroyed_handler),
	    (__bridge void*)self);

	return self;
}

- (bool)homogeneous
{
	return gtk_stack_get_homogeneous(GTK_STACK(self.widget));
}

- (void)setHomogeneous: (bool)homogeneous
{
	gtk_stack_set_homogeneous(GTK_STACK(self.widget), homogeneous);
}

- (unsigned int)transitionDuration
{
	return gtk_stack_get_transition_duration(GTK_STACK(self.widget));
}

- (void)setTransitionDuration: (unsigned int)duration
{
	gtk_stack_set_transition_duration(GTK_STACK(self.widget), duration);
}

- (GtkStackTransitionType)transitionType
{
	return gtk_stack_get_transition_type(GTK_STACK(self.widget));
}

- (void)setTransitionType: (GtkStackTransitionType)type
{
	gtk_stack_set_transition_type(GTK_STACK(self.widget), type);
}

- (bool)inTransition
{
	return gtk_stack_get_transition_running(GTK_STACK(self.widget));
}

- (bool)interpolateSize
{
	return gtk_stack_get_interpolate_size(GTK_STACK(self.widget));
}

- (void)setInterpolateSize: (bool)interpolate
{
	gtk_stack_set_interpolate_size(GTK_STACK(self.widget), interpolate);
}

- (void)addWidget: (GTKWidget*)childWidget
	 withName: (OFString*)name
{
	childWidget.parent = self;
	gtk_stack_add_named(GTK_STACK(self.widget),
	    GTK_WIDGET(childWidget.widget), [name UTF8String]);
}

- (void)addWidget: (GTKWidget*)childWidget
	 withName: (OFString*)name
	withTitle: (OFString*)title
{
	childWidget.parent = self;
	gtk_stack_add_titled(GTK_STACK(self.widget),
	    GTK_WIDGET(childWidget.widget),
	    [name UTF8String], [title UTF8String]);
}

- (GTKWidget*)childWithName: (OFString*)name
{
	GtkWidget *widget = gtk_stack_get_child_by_name(GTK_STACK(self.widget),
	    [name UTF8String]);
	return [GTKWidget wrapperForGtkWidget: widget];
}

- (void)showChildWithName: (OFString*)name
{
	gtk_stack_set_visible_child_name(GTK_STACK(self.widget),
	    [name UTF8String]);
}

- (void)showChildWithName: (OFString*)name
      usingTransitionType: (GtkStackTransitionType)transition
{
	gtk_stack_set_visible_child_full(GTK_STACK(self.widget),
	    [name UTF8String], transition);
}

- (OFString*)visibleChildName
{
	return @(gtk_stack_get_visible_child_name(GTK_STACK(self.widget)));
}
@end
