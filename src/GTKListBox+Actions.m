#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKListBox+Actions.h"

@implementation GTKListBox (Properties)
- (void)prependWidget:(GTKWidget*)childWidget
{
  gtk_list_box_prepend(GTK_LIST_BOX(self.widget),
      GTK_WIDGET(childWidget.widget));
}

- (void)appendWidget:(GTKWidget*)childWidget
{
  gtk_list_box_insert(GTK_LIST_BOX(self.widget),
      GTK_WIDGET(childWidget.widget), -1);
}

- (void)insertWidget:(GTKWidget*)childWidget atPosition:(int)position
{
  gtk_list_box_insert(GTK_LIST_BOX(self.widget),
      GTK_WIDGET(childWidget.widget), position);
}

- (void)selectRow:(GTKListBoxRow*)row
{
  gtk_list_box_select_row(GTK_LIST_BOX(self.widget),
      (GTK_LIST_BOX_ROW(row.widget)));
}

- (void)unselectRow:(GTKListBoxRow*)row
{
  gtk_list_box_unselect_row(GTK_LIST_BOX(self.widget),
      (GTK_LIST_BOX_ROW(row.widget)));
}

- (void)selectAll
{
  gtk_list_box_select_all(GTK_LIST_BOX(self.widget));
}

- (void)unselectAll
{
  gtk_list_box_unselect_all(GTK_LIST_BOX(self.widget));
}

- (GTKListBoxRow*)rowAtIndex:(int)index
{
  GtkListBoxRow *row = gtk_list_box_get_row_at_index(GTK_LIST_BOX(self.widget),
      index);
  return (__bridge GTKListBoxRow*)g_object_get_data(G_OBJECT(row),
      "_GTKKIT_WRAPPER_WIDGET_");
}

// This gets the wrapper object for the widget in the selected row. It will
// return it as an id, so you'll have to cast it to the appropriate class. It
// doesn't need to be retained or released.
- (id)widgetForSelectedRow
{
  GtkListBoxRow *row = gtk_list_box_get_selected_row(GTK_LIST_BOX(self.widget));
  GtkWidget *child = gtk_bin_get_child(GTK_BIN(row));
  return (__bridge GTKListBoxRow*)g_object_get_data(G_OBJECT(child),
      "_GTKKIT_WRAPPER_WIDGET_");
}
@end
