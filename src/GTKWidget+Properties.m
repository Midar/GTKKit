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
- (void)setName:(OFString *)name
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_widget_set_name(GTK_WIDGET (self.widget), [name UTF8String]);
}

- (OFString *)name
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return @(gtk_widget_get_name(GTK_WIDGET (self.widget)));
}

- (bool)isFocus
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_widget_is_focus (GTK_WIDGET (self.widget));
}

- (void)setSensitive:(bool)sensitive
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_widget_set_sensitive (GTK_WIDGET (self.widget), sensitive);
}

- (bool)sensitive
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_widget_get_sensitive (GTK_WIDGET (self.widget));
}

- (bool)effectiveSensitivity
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_widget_is_sensitive (GTK_WIDGET (self.widget));
}

- (double)opacity
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_widget_get_opacity (GTK_WIDGET (self.widget));
}

- (void)setOpacity:(double)opacity
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_widget_set_opacity (GTK_WIDGET (self.widget), opacity);
}

- (GtkAlign)horizontalAlign
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_widget_get_halign(GTK_WIDGET(self.widget));
}

- (void)setHorizontalAlign:(GtkAlign)align
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_widget_set_halign(GTK_WIDGET(self.widget), align);
}

- (GtkAlign)verticalAlign
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_widget_get_valign(GTK_WIDGET(self.widget));
}

- (void)setVerticalAlign:(GtkAlign)align
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_widget_set_valign(GTK_WIDGET(self.widget), align);
}

- (int)marginStart
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_widget_get_margin_start(GTK_WIDGET(self.widget));
}

- (void)setMarginStart:(int)margin
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_widget_set_margin_start(GTK_WIDGET(self.widget), margin);
}

- (int)marginEnd
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_widget_get_margin_end(GTK_WIDGET(self.widget));
}

- (void)setMarginEnd:(int)margin
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_widget_set_margin_end(GTK_WIDGET(self.widget), margin);
}

- (int)marginTop
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_widget_get_margin_top(GTK_WIDGET(self.widget));
}

- (void)setMarginTop:(int)margin
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_widget_set_margin_top(GTK_WIDGET(self.widget), margin);
}

- (int)marginBottom
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_widget_get_margin_bottom(GTK_WIDGET(self.widget));
}

- (void)setMarginBottom:(int)margin
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_widget_set_margin_bottom(GTK_WIDGET(self.widget), margin);
}

- (bool)expandHorizontal
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_widget_get_hexpand(GTK_WIDGET(self.widget));
}

- (void)setExpandHorizontal:(bool)expand
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_widget_set_hexpand(GTK_WIDGET(self.widget), expand);
}

- (bool)expandVertical
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_widget_get_vexpand(GTK_WIDGET(self.widget));
}

- (void)setExpandVertical:(bool)expand
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_widget_set_vexpand(GTK_WIDGET(self.widget), expand);
}

- (int)heightRequest
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  int height;
  g_object_get (G_OBJECT (self.widget), "height-request", &height, NULL);
  return height;
}

- (void)setHeightRequest:(int)height
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  g_object_set (G_OBJECT (self.widget), "height-request", height, NULL);
}

- (int)widthRequest
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  int width;
  g_object_get (G_OBJECT (self.widget), "width-request", &width, NULL);
  return width;
}

- (void)setWidthRequest:(int)width
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  g_object_set (G_OBJECT (self.widget), "width-request", width, NULL);
}
@end
