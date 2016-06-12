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

#import "GTKListBox+Actions.h"

@implementation GTKListBox (Properties)
- (void)prependWidget:(GTKWidget*)childWidget
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_list_box_prepend(GTK_LIST_BOX(self.widget),
      GTK_WIDGET(childWidget.widget));
}

- (void)appendWidget:(GTKWidget*)childWidget
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_list_box_insert(GTK_LIST_BOX(self.widget),
      GTK_WIDGET(childWidget.widget), -1);
}

- (void)insertWidget:(GTKWidget*)childWidget atPosition:(int)position
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_list_box_insert(GTK_LIST_BOX(self.widget),
      GTK_WIDGET(childWidget.widget), position);
}

- (void)selectRowAtIndex:(int)index
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  if (index >= self.rowCount) {
      @throw([GTKRowOutOfBoundsException new]);
  }
  GtkListBoxRow *row = \
      gtk_list_box_get_row_at_index(GTK_LIST_BOX(self.widget), index);
  gtk_list_box_select_row(GTK_LIST_BOX(self.widget),
      (GTK_LIST_BOX_ROW(row)));
}

- (void)unselectRowAtIndex:(int)index
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  if (index >= self.rowCount) {
      @throw([GTKRowOutOfBoundsException new]);
  }
  GtkListBoxRow *row = \
      gtk_list_box_get_row_at_index(GTK_LIST_BOX(self.widget), index);
  gtk_list_box_unselect_row(GTK_LIST_BOX(self.widget),
      (GTK_LIST_BOX_ROW(row)));
}

- (void)selectAll
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_list_box_select_all(GTK_LIST_BOX(self.widget));
}

- (void)unselectAll
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_list_box_unselect_all(GTK_LIST_BOX(self.widget));
}

- (void)destroyRowAtIndex:(int)index
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  if (index >= self.rowCount) {
      @throw([GTKRowOutOfBoundsException new]);
  }
  GtkListBoxRow *row = gtk_list_box_get_row_at_index(GTK_LIST_BOX(self.widget),
      index);
  gtk_widget_destroy(GTK_WIDGET(row));
}

// This gets the wrapper object for the widget in the selected row. It will
// return it as a GTKWidget*, so you'll have to cast it to the appropriate
// class. It doesn't need to be retained or released.
- (GTKWidget*)widgetForSelectedRow
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  GtkListBoxRow *row = gtk_list_box_get_selected_row(GTK_LIST_BOX(self.widget));
  GtkWidget *child = gtk_bin_get_child(GTK_BIN(row));
  return [GTKWidget widgetFromGtkWidget: child];
}

// This gets the wrapper object for the widget in the given row. It will
// return it as a GTKWidget*, so you'll have to cast it to the appropriate
// class. It doesn't need to be retained or released.
- (GTKWidget*)widgetForRowAtIndex:(int)index
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  if (index >= self.rowCount) {
      @throw([GTKRowOutOfBoundsException new]);
  }
  GtkListBoxRow *row = gtk_list_box_get_row_at_index(GTK_LIST_BOX(self.widget),
      index);
  GtkWidget *child = gtk_bin_get_child(GTK_BIN(row));
  return [GTKWidget widgetFromGtkWidget: child];
}

// Because the only way to count a GList is to iterate through it, this takes
// longer the longer the list is.
- (int)rowCount
{
  GList *rowList = gtk_container_get_children(GTK_CONTAINER(self.widget));
  return g_list_length(rowList);
}
@end
