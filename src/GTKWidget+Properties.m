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

#import "GTKWidget+Properties.h"
#import "GTKWidget.h"

@implementation GTKWidget (Properties)
- (void)setName: (OFString*)name
{
	gtk_widget_set_name(GTK_WIDGET(self.widget), [name UTF8String]);
}

- (OFString*)name
{
	return @(gtk_widget_get_name(GTK_WIDGET(self.widget)));
}

- (bool)isFocus
{
	return gtk_widget_is_focus(GTK_WIDGET(self.widget));
}

- (void)setSensitive: (bool)sensitive
{
	gtk_widget_set_sensitive(GTK_WIDGET(self.widget), sensitive);
}

- (bool)sensitive
{
	return gtk_widget_get_sensitive(GTK_WIDGET(self.widget));
}

- (bool)effectiveSensitivity
{
	return gtk_widget_is_sensitive(GTK_WIDGET(self.widget));
}

- (double)opacity
{
	return gtk_widget_get_opacity(GTK_WIDGET(self.widget));
}

- (void)setOpacity: (double)opacity
{
	gtk_widget_set_opacity (GTK_WIDGET (self.widget), opacity);
}

- (GtkAlign)horizontalAlign
{
	return gtk_widget_get_halign(GTK_WIDGET(self.widget));
}

- (void)setHorizontalAlign: (GtkAlign)align
{
	gtk_widget_set_halign(GTK_WIDGET(self.widget), align);
}

- (GtkAlign)verticalAlign
{
	return gtk_widget_get_valign(GTK_WIDGET(self.widget));
}

- (void)setVerticalAlign: (GtkAlign)align
{
	gtk_widget_set_valign(GTK_WIDGET(self.widget), align);
}

- (int)marginStart
{
	return gtk_widget_get_margin_start(GTK_WIDGET(self.widget));
}

- (void)setMarginStart: (int)margin
{
	gtk_widget_set_margin_start(GTK_WIDGET(self.widget), margin);
}

- (int)marginEnd
{
	return gtk_widget_get_margin_end(GTK_WIDGET(self.widget));
}

- (void)setMarginEnd: (int)margin
{
	gtk_widget_set_margin_end(GTK_WIDGET(self.widget), margin);
}

- (int)marginTop
{
	return gtk_widget_get_margin_top(GTK_WIDGET(self.widget));
}

- (void)setMarginTop: (int)margin
{
	gtk_widget_set_margin_top(GTK_WIDGET(self.widget), margin);
}

- (int)marginBottom
{
	return gtk_widget_get_margin_bottom(GTK_WIDGET(self.widget));
}

- (void)setMarginBottom: (int)margin
{
	gtk_widget_set_margin_bottom(GTK_WIDGET(self.widget), margin);
}

- (bool)expandHorizontal
{
	return gtk_widget_get_hexpand(GTK_WIDGET(self.widget));
}

- (void)setExpandHorizontal:(bool)expand
{
	gtk_widget_set_hexpand(GTK_WIDGET(self.widget), expand);
}

- (bool)expandVertical
{
	return gtk_widget_get_vexpand(GTK_WIDGET(self.widget));
}

- (void)setExpandVertical: (bool)expand
{
	gtk_widget_set_vexpand(GTK_WIDGET(self.widget), expand);
}

- (int)heightRequest
{
	int height;
	g_object_get(G_OBJECT(self.widget), "height-request", &height, NULL);
	return height;
}

- (void)setHeightRequest: (int)height
{
	g_object_set(G_OBJECT(self.widget), "height-request", height, NULL);
}

- (int)widthRequest
{
	int width;
	g_object_get(G_OBJECT(self.widget), "width-request", &width, NULL);
	return width;
}

- (void)setWidthRequest:(int)width
{
	g_object_set(G_OBJECT(self.widget), "width-request", width, NULL);
}
@end
