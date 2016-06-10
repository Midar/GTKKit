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

#import "GTKImage.h"

@implementation GTKImage
- init
{
  self = [super init];
  self.iconSize = GTK_ICON_SIZE_DIALOG;
  self.widget = gtk_image_new_from_icon_name("dialog-question", self.iconSize);
  g_object_ref_sink(G_OBJECT(self.widget));
  g_object_set_data(G_OBJECT(self.widget), "_GTKKIT_WRAPPER_WIDGET_",
      (__bridge void*) self);
  _widgetDestroyedHandlerID = g_signal_connect(G_OBJECT (self.widget), "destroy",
      G_CALLBACK (widget_destroyed_handler), (__bridge void*) self);
  return self;
}

- (void)setImageFile:(OFString *)filename
{
  _imageFile = filename;
  gtk_image_set_from_file(GTK_IMAGE(self.widget), [filename UTF8String]);
}

- (OFString *)imageFile
{
  return _imageFile;
}

- (void)setIconName:(OFString *)name
{
  _iconName = name;
  gtk_image_set_from_icon_name(GTK_IMAGE(self.widget), [name UTF8String],
      self.iconSize);
}

- (OFString *)iconName
{
  return _iconName;
}
@end
