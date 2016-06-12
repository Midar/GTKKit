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

#import "GTKProgressBar.h"

@implementation GTKProgressBar
- init
{
  self = [super init];
  self.widget = gtk_progress_bar_new();
  g_object_ref_sink(G_OBJECT(self.widget));
  g_object_set_data(G_OBJECT(self.widget), "_GTKKIT_WRAPPER_WIDGET_",
      (__bridge void*) self);
  _widgetDestroyedHandlerID = g_signal_connect(G_OBJECT (self.widget), "destroy",
      G_CALLBACK (widget_destroyed_handler), (__bridge void*) self);
  return self;
}

- (double)value
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_progress_bar_get_fraction(GTK_PROGRESS_BAR(self.widget));
}

- (void)setValue:(double) newValue
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_progress_bar_set_fraction(GTK_PROGRESS_BAR(self.widget), newValue);
}

- (bool)inverted
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_progress_bar_get_inverted(GTK_PROGRESS_BAR(self.widget));
}

- (void)setInverted:(bool) newValue
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_progress_bar_set_inverted(GTK_PROGRESS_BAR(self.widget), newValue);
}

- (bool)showText
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_progress_bar_get_show_text(GTK_PROGRESS_BAR(self.widget));
}

- (void)setShowText:(bool) newValue
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_progress_bar_set_show_text(GTK_PROGRESS_BAR(self.widget), newValue);
}

- (OFString *)text
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return @(gtk_progress_bar_get_text(GTK_PROGRESS_BAR(self.widget)));
}

- (void)setText:(OFString *) newValue
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_progress_bar_set_text(GTK_PROGRESS_BAR(self.widget),
      [newValue UTF8String]);
}

- (bool)ellipsize
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  PangoEllipsizeMode ellip = \
      gtk_progress_bar_get_ellipsize(GTK_PROGRESS_BAR(self.widget));
  if (ellip == PANGO_ELLIPSIZE_NONE) {
    return false;
  } else {
    return true;
  }
}

- (void)setEllipsize:(bool) newValue
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  if (newValue) {
    gtk_progress_bar_set_ellipsize(GTK_PROGRESS_BAR(self.widget),
        PANGO_ELLIPSIZE_END);
  } else {
    gtk_progress_bar_set_ellipsize(GTK_PROGRESS_BAR(self.widget),
        PANGO_ELLIPSIZE_NONE);
  }
}

- (double)pulseStep
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_progress_bar_get_pulse_step(GTK_PROGRESS_BAR(self.widget));
}

- (void)setPulseStep:(double) newValue
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_progress_bar_set_pulse_step(GTK_PROGRESS_BAR(self.widget), newValue);
}

- (GtkOrientation)orientation
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_orientable_get_orientation (GTK_ORIENTABLE (self.widget));
}

- (void)setOrientation:(GtkOrientation)orientation
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_orientable_set_orientation (GTK_ORIENTABLE (self.widget), orientation);
}

- (void)pulse
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_progress_bar_pulse(GTK_PROGRESS_BAR(self.widget));
}
@end
