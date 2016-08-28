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

#import "GTKMenuItem+Properties.h"

static void
menuItemActivated(GtkMenuItem *widget, GTKMenuItem *sender)
{
	if (sender.target != nil && sender.action != NULL) {
		void (*imp)(id, SEL, id) = (void(*)(id, SEL, id))
		    [sender.target methodForSelector: sender.action];

		imp(sender.target, sender.action, sender);
	}
}

@implementation GTKMenuItem (Properties)
- (OFString*)label
{
	return @(gtk_menu_item_get_label(GTK_MENU_ITEM(self.widget)));
}

- (void)setLabel: (OFString*)label
{
	gtk_menu_item_set_label(GTK_MENU_ITEM(self.widget), [label UTF8String]);
}

- (GTKMenu*)submenu
{
	GtkWidget *menu = gtk_menu_item_get_submenu(GTK_MENU_ITEM(self.widget));
	return [GTKMenu wrapperForGtkWidget: menu];
}

- (void)setSubmenu: (GTKMenu*)submenu
{
	gtk_menu_item_set_submenu(GTK_MENU_ITEM(self.widget),
	    GTK_WIDGET(submenu.widget));
}

- initWithLabel: (OFString*)label
{
	self = [self init];

	gtk_widget_destroy(GTK_WIDGET(self.widget));
	self.widget = gtk_menu_item_new_with_label("");

	_menuItemActivatedHandlerID = g_signal_connect(GTK_WIDGET(self.widget),
	    "activate", G_CALLBACK(menuItemActivated), (__bridge void*)self);

	self.label = label;
	gtk_widget_show_all(GTK_WIDGET(self.widget));

	return self;
}

+ (instancetype)menuItemWithLabel: (OFString*)label
{
	return [[self alloc] initWithLabel: label];
}
@end
