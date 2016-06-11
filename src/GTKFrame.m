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

#import "GTKFrame.h"

@implementation GTKFrame
- init
{
  self = [super init];
  self.widget = gtk_frame_new(NULL);
  g_object_ref_sink(G_OBJECT(self.widget));
  g_object_set_data(G_OBJECT(self.widget), "_GTKKIT_WRAPPER_WIDGET_",
      (__bridge void*) self);
  _widgetDestroyedHandlerID = g_signal_connect(G_OBJECT (self.widget), "destroy",
      G_CALLBACK (widget_destroyed_handler), (__bridge void*) self);
  return self;
}

- (OFString *)label
{
  return @(gtk_frame_get_label (GTK_FRAME (self.widget)));
}

- (void)setLabel:(OFString *)label
{
  gtk_frame_set_label (GTK_FRAME (self.widget), [label UTF8String]);
}

- (GTKWidget *)labelWidget
{
  return [GTKWidget widgetFromGtkWidget:
      gtk_frame_get_label_widget (GTK_FRAME (self.widget))];
}

- (void)setLabelWidget:(GTKWidget *)labelWidget
{
  gtk_frame_set_label_widget (GTK_FRAME (self.widget), [labelWidget widget]);
}

- (void)setLabelHorizontalAlign:(float)xAlign
{
  g_object_set (G_OBJECT (self.widget), "label-xalign", xAlign, NULL);
}

- (float)labelHorizontalAlign
{
  float x;
  g_object_get (G_OBJECT (self.widget), "label-xalign", &x, NULL);
  return x;
}

- (void)setLabelVerticalAlign:(float)yAlign
{
  g_object_set (G_OBJECT (self.widget), "label-yalign", yAlign, NULL);
}

- (float)labelVerticalAlign
{
  float y;
  g_object_get (G_OBJECT (self.widget), "label-yalign", &y, NULL);
  return y;
}
@end
