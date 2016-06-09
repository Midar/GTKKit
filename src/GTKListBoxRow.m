#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKListBoxRow.h"

@implementation GTKListBoxRow
- init
{
  self = [super init];
  self.widget = gtk_list_box_row_new();
  g_object_ref(G_OBJECT(self.widget));
  g_object_set_data(G_OBJECT(self.widget), "_GTKKIT_WRAPPER_WIDGET_", (__bridge void*) self);
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
