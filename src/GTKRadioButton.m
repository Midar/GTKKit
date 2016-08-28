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

#import "GTKRadioButton.h"
#import "GTKButton+Properties.h"

static void
buttonToggled(GtkWidget *button, GTKRadioButton *sender)
{
	if (sender.target != nil && sender.action != NULL && sender.active) {
		void (*imp)(id, SEL, id) = (void(*)(id, SEL, id))
		    [sender.target methodForSelector: sender.action];
		imp(sender.target, sender.action, sender);
	}
}

@implementation GTKRadioButton
- init
{
	self = [super init];

	gtk_widget_destroy(GTK_WIDGET(self.widget));
	self.widget = gtk_radio_button_new(NULL);
	g_object_ref_sink(G_OBJECT(self.widget));
	g_object_set_data(G_OBJECT(self.widget), "_GTKKIT_WRAPPER_WIDGET_",
	    (__bridge void*)self);

	_toggledHandlerID = g_signal_connect(GTK_WIDGET(self.widget), "toggled",
	    G_CALLBACK(buttonToggled), (__bridge void*)self);
	_widgetDestroyedHandlerID = g_signal_connect(G_OBJECT(self.widget),
	    "destroy", G_CALLBACK(widget_destroyed_handler),
	    (__bridge void*)self);

	return self;
}

- (void)dealloc
{
	if (self.widget != NULL)
		g_signal_handler_disconnect(G_OBJECT(self.widget),
		    _toggledHandlerID);
}

+ (instancetype)radioButtonWithLabelText: (OFString*)labelText;
{
	return [[self alloc] initWithLabelText: labelText];
}

- initWithLabelText: (OFString*)labelText;
{
	self = [self init];

	self.label = labelText;

	return self;
}

+ (instancetype)radioButtonWithLabelText: (OFString*)labelText
             joiningGroupWithRadioButton: (GTKRadioButton*)radioButton
{
	return [[self alloc] initWithLabelText: labelText
		   joiningGroupWithRadioButton: radioButton];
}

-	    initWithLabelText: (OFString*)labelText
  joiningGroupWithRadioButton: (GTKRadioButton*)radioButton
{
	self = [self init];

	self.label = labelText;
	[self joinGroupWithRadioButton: radioButton];

	return self;
}

- (void)joinGroupWithRadioButton: (GTKRadioButton*)radioButton
{
	if (self.widget == NULL)
		@throw [GTKDestroyedWidgetException new];

	if (radioButton.widget == NULL)
		@throw [GTKDestroyedWidgetException new];

	gtk_radio_button_join_group(GTK_RADIO_BUTTON(self.widget),
	    GTK_RADIO_BUTTON(radioButton.widget));
}

- (void)leaveGroup
{
	if (self.widget == NULL)
		@throw [GTKDestroyedWidgetException new];

	gtk_radio_button_join_group(GTK_RADIO_BUTTON(self.widget), NULL);
}
@end
