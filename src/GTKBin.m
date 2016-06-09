#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKBin.h"

@implementation GTKBin

- (GTKWidget *)childWidget
{
  GtkWidget *child = (GTK_WIDGET(gtk_bin_get_child(GTK_BIN(self.widget))));
  return (__bridge GTKWidget*)g_object_get_data(G_OBJECT(child),
      "_GTKKIT_WRAPPER_WIDGET_");
}

@end
