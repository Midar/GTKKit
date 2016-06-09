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

#import "GTKFrame+Properties.h"

@implementation GTKFrame (Properties)
- (OFString *)label
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return @(gtk_frame_get_label (GTK_FRAME (self.widget)));
}

- (void)setLabel:(OFString *)label
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_frame_set_label (GTK_FRAME (self.widget), [label UTF8String]);
}

- (GTKWidget *)labelWidget
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return [GTKWidget widgetFromGtkWidget:
      gtk_frame_get_label_widget (GTK_FRAME (self.widget))];
}

- (void)setLabelWidget:(GTKWidget *)labelWidget
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_frame_set_label_widget (GTK_FRAME (self.widget), [labelWidget widget]);
}

- (void)setXAlign:(float)xAlign
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  g_object_set (G_OBJECT (self.widget), "label-xalign", xAlign, NULL);
}

- (float)xAlign
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  float x;
  g_object_get (G_OBJECT (self.widget), "label-xalign", &x, NULL);
  return x;
}

- (void)setYAlign:(float)yAlign
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  g_object_set (G_OBJECT (self.widget), "label-yalign", yAlign, NULL);
}

- (float)yAlign
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  float y;
  g_object_get (G_OBJECT (self.widget), "label-yalign", &y, NULL);
  return y;
}
@end
