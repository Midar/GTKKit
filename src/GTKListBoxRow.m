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

#import "GTKListBoxRow.h"

@implementation GTKListBoxRow
- init
{
  self = [super init];
  self.widget = gtk_list_box_row_new();
  g_object_ref(G_OBJECT(self.widget));
  g_object_set_data(G_OBJECT(self.widget), "_GTKKIT_WRAPPER_WIDGET_",
      (__bridge void*) self);
  return self;
}

- (void)rowChanged
{
  gtk_list_box_row_changed(GTK_LIST_BOX_ROW(self.widget));
}

- (bool)selected
{
  return gtk_list_box_row_is_selected(GTK_LIST_BOX_ROW(self.widget));
}

- (GTKWidget*)rowHeader
{
  return _rowHeader;
}

- (void)setRowHeader:(GTKWidget*)rowHeader
{
  _rowHeader = rowHeader;
  gtk_list_box_row_set_header(GTK_LIST_BOX_ROW(self.widget),
      GTK_WIDGET(rowHeader.widget));
}

- (int)rowIndex
{
  return gtk_list_box_row_get_index(GTK_LIST_BOX_ROW(self.widget));
}

- (bool)activatable
{
  return gtk_list_box_row_get_activatable(GTK_LIST_BOX_ROW(self.widget));
}

- (void)setActivatable:(bool)activatable
{
  gtk_list_box_row_set_activatable(GTK_LIST_BOX_ROW(self.widget), activatable);
}

- (bool)selectable
{
  return gtk_list_box_row_get_selectable(GTK_LIST_BOX_ROW(self.widget));
}

- (void)setSelectable:(bool)selectable
{
  gtk_list_box_row_set_activatable(GTK_LIST_BOX_ROW(self.widget), selectable);
}
@end
