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

#import "GTKComboBox.h"

@implementation GTKComboBox
- init
{
  self = [super init];
  self.widget = gtk_combo_box_text_new ();
  g_object_ref(G_OBJECT(self.widget));
  g_object_set_data(G_OBJECT(self.widget), "_GTKKIT_WRAPPER_WIDGET_",
      (__bridge void*) self);
  return self;
}

- (void)    appendString: (OFString*)string
    withIdentifierString: (OFString*)ID
{
  gtk_combo_box_text_append(GTK_COMBO_BOX_TEXT(self.widget),
      [string UTF8String], [ID UTF8String]);
}

- (void)   prependString: (OFString*)string
    withIdentifierString: (OFString *)ID
{
  gtk_combo_box_text_prepend(GTK_COMBO_BOX_TEXT(self.widget),
      [string UTF8String], [ID UTF8String]);
}

- (void)  insertString: (OFString*)string
  withIdentifierString: (OFString*)ID
            atPosition:(int)position
{
  gtk_combo_box_text_insert(GTK_COMBO_BOX_TEXT(self.widget), position,
      [string UTF8String], [ID UTF8String]);
}
@end
