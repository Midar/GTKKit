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

#import "GTKLabel+Properties.h"

@implementation GTKLabel (Properties)
- (OFString *)text
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return [OFString stringWithUTF8String:
      gtk_label_get_text (GTK_LABEL (self.widget))];
}

- (void)setText:(OFString *)label
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_label_set_text (GTK_LABEL (self.widget), [label UTF8String]);
}

- (float)xAlign
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  float x;
  g_object_get (G_OBJECT (self.widget), "xalign", &x, NULL);
  return x;
}

- (float)yAlign
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  float y;
  g_object_get (G_OBJECT (self.widget), "yalign", &y, NULL);
  return y;
}

- (void)setXAlign:(float)xAlign
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  g_object_set (G_OBJECT (self.widget), "xalign", xAlign, NULL);
}

- (void)setYAlign:(float)yAlign
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  g_object_set (G_OBJECT (self.widget), "yalign", yAlign, NULL);
}

- (void)setJustify:(GtkJustification)jtype
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_label_set_justify (GTK_LABEL (self.widget), jtype);
}

- (GtkJustification)justify
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_label_get_justify (GTK_LABEL (self.widget));
}

- (PangoEllipsizeMode)ellipsizeMode
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_label_get_ellipsize (GTK_LABEL (self.widget));
}

- (void)setEllipsizeMode:(PangoEllipsizeMode)mode
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_label_set_ellipsize (GTK_LABEL (self.widget), mode);
}

- (int)desiredWidthInCharacters
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_label_get_width_chars (GTK_LABEL (self.widget));
}

- (void)setDesiredWidthInCharacters:(int)width
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_label_set_width_chars (GTK_LABEL (self.widget), width);
}

- (void)setWrap:(bool)wrap
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_label_set_line_wrap (GTK_LABEL (self.widget), wrap);
}

- (bool)wrap
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_label_get_line_wrap (GTK_LABEL (self.widget));
}

- (void)setLineWrapMode:(PangoWrapMode)mode
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_label_set_line_wrap_mode (GTK_LABEL (self.widget), mode);
}

- (PangoWrapMode)lineWrapMode
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_label_get_line_wrap_mode (GTK_LABEL (self.widget));
}

- (bool)selectable
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_label_get_selectable (GTK_LABEL (self.widget));
}

- (void)setSelectable:(bool)setting
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_label_set_selectable (GTK_LABEL (self.widget), setting);
}

- (bool)singleLineMode
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_label_get_single_line_mode (GTK_LABEL (self.widget));
}

- (void)setSingleLineMode:(bool)setting
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_label_set_single_line_mode (GTK_LABEL (self.widget), setting);
}

- (double)angle
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_label_get_angle (GTK_LABEL (self.widget));
}

- (void)setAngle:(double)angle
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_label_set_angle (GTK_LABEL (self.widget), angle);
}
@end
