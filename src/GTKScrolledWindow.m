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

#import "GTKScrolledWindow.h"

@implementation GTKScrolledWindow
- init
{
  self = [super init];
  self.widget = gtk_scrolled_window_new(NULL, NULL);
  g_object_ref_sink(G_OBJECT(self.widget));
  g_object_set_data(G_OBJECT(self.widget), "_GTKKIT_WRAPPER_WIDGET_",
      (__bridge void*) self);
  return self;
}

- (GtkAdjustment*)horizontalAdjustment
{
  return gtk_scrolled_window_get_hadjustment(GTK_SCROLLED_WINDOW(self.widget));
}

- (void)setHorizontalAdjustment:(GtkAdjustment*)adjustment
{
  gtk_scrolled_window_set_hadjustment(GTK_SCROLLED_WINDOW(self.widget),
      adjustment);
}

- (GtkAdjustment*)verticalAdjustment
{
  return gtk_scrolled_window_get_vadjustment(GTK_SCROLLED_WINDOW(self.widget));
}

- (void)setVerticalAdjustment:(GtkAdjustment*)adjustment
{
  gtk_scrolled_window_set_vadjustment(GTK_SCROLLED_WINDOW(self.widget),
      adjustment);
}

- (GtkPolicyType)horizontalScrollingPolicy
{
  GtkPolicyType policy;
  gtk_scrolled_window_get_policy (GTK_SCROLLED_WINDOW(self.widget), &policy,
      NULL);
  return policy;
}

- (void)setHorizontalScrollingPolicy:(GtkPolicyType)policy
{
  gtk_scrolled_window_set_policy (GTK_SCROLLED_WINDOW(self.widget), policy,
      self.verticalScrollingPolicy);
}

- (GtkPolicyType)verticalScrollingPolicy
{
  GtkPolicyType policy;
  gtk_scrolled_window_get_policy (GTK_SCROLLED_WINDOW(self.widget), NULL,
      &policy);
  return policy;
}

- (void)setVerticalScrollingPolicy:(GtkPolicyType)policy
{
  gtk_scrolled_window_set_policy (GTK_SCROLLED_WINDOW(self.widget),
      self.horizontalScrollingPolicy, policy);
}

- (GtkCornerType)placement
{
  return gtk_scrolled_window_get_placement(GTK_SCROLLED_WINDOW(self.widget));
}

- (void)setPlacement:(GtkCornerType)placement
{
  return gtk_scrolled_window_set_placement(GTK_SCROLLED_WINDOW(self.widget),
      placement);
}

- (GtkShadowType)shadowType
{
  return gtk_scrolled_window_get_shadow_type(GTK_SCROLLED_WINDOW(self.widget));
}

- (void)setShadowType:(GtkShadowType)shadowType
{
  return gtk_scrolled_window_set_shadow_type(GTK_SCROLLED_WINDOW(self.widget),
      shadowType);
}

- (int)minContentWidth
{
  return gtk_scrolled_window_get_min_content_width(
      GTK_SCROLLED_WINDOW(self.widget));
}

- (void)setMinContentWidth:(int)width
{
  return gtk_scrolled_window_set_min_content_width(
      GTK_SCROLLED_WINDOW(self.widget), width);
}

- (int)minContentHeight
{
  return gtk_scrolled_window_get_min_content_height(
      GTK_SCROLLED_WINDOW(self.widget));
}

- (void)setMinContentHeight:(int)height
{
  return gtk_scrolled_window_set_min_content_height(
      GTK_SCROLLED_WINDOW(self.widget), height);
}

- (bool)kineticScrollingEnabled
{
  return gtk_scrolled_window_get_kinetic_scrolling(
      GTK_SCROLLED_WINDOW(self.widget));
}

- (void)setKineticScrollingEnabled:(bool)kineticScrolling
{
  return gtk_scrolled_window_set_kinetic_scrolling(
      GTK_SCROLLED_WINDOW(self.widget), kineticScrolling);
}

- (bool)overlayScrollingEnabled
{
  return gtk_scrolled_window_get_overlay_scrolling(
      GTK_SCROLLED_WINDOW(self.widget));
}

- (void)setOverlayScrollingEnabled:(bool)overlayScrolling
{
  return gtk_scrolled_window_set_overlay_scrolling(
      GTK_SCROLLED_WINDOW(self.widget), overlayScrolling);
}

- (bool)captureButtonPress
{
  return gtk_scrolled_window_get_capture_button_press(
      GTK_SCROLLED_WINDOW(self.widget));
}

- (void)setCaptureButtonPress:(bool)captureButtonPress
{
  return gtk_scrolled_window_set_capture_button_press(
      GTK_SCROLLED_WINDOW(self.widget), captureButtonPress);
}
@end
