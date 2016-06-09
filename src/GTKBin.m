#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKBin.h"

@implementation GTKBin

// This returns the wrapper object for the child widget, as a GTKWidget. It
// can and should be immediately cast to the appropriate class by the sender.
- (GTKWidget *)childWidget
{
  GtkWidget *child = (GTK_WIDGET(gtk_bin_get_child(GTK_BIN(self.widget))));
  return (__bridge GTKWidget*)g_object_get_data(G_OBJECT(child),
      "_GTKKIT_WRAPPER_WIDGET_");
}

@end
