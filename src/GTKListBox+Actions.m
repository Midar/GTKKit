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

- (GTKListBoxRow*)selectedRow
{
  GtkListBoxRow *row = gtk_list_box_get_selected_row(GTK_LIST_BOX(self.widget));
  return [GTKListBoxRow widgetFromGtkWidget: GTK_WIDGET(row)];
}
@end
