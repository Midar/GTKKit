#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKGrid+Actions.h"

@implementation GTKGrid (Actions)
- (void)attachWidget: (GTKWidget*)childWidget
    left: (int)left
     top: (int)top
         width: (int)width
        height: (int)height
{
  gtk_grid_attach(GTK_GRID(self.widget), GTK_WIDGET(childWidget.widget),
      left, top, width, height);
}

- (void)attachWidget: (GTKWidget*)childWidget
      toWidget: (GTKWidget*)siblingWidget
        onSide: (GtkPositionType)side
         width: (int)width
        height: (int)height
{
  gtk_grid_attach_next_to(GTK_GRID(self.widget),
      GTK_WIDGET(childWidget.widget), GTK_WIDGET(siblingWidget.widget),
      side, width, height);
}

- (void)insertRowAtPosition: (int)position
{
  gtk_grid_insert_row(GTK_GRID(self.widget), position);
}

- (void)insertColumnAtPosition: (int)position
{
  gtk_grid_insert_column(GTK_GRID(self.widget), position);
}

- (void)removeRow: (int)position
{
  gtk_grid_remove_row(GTK_GRID(self.widget), position);
}

- (void)removeColumn: (int)position
{
  gtk_grid_remove_column(GTK_GRID(self.widget), position);
}
@end
