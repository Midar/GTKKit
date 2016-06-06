#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKBin.h"

@implementation GTKBin

- (GTKWidget *)childWidget
{
  GtkWidget *w = gtk_bin_get_child (GTK_BIN (self.widget));
  return [GTKWidget widgetFromGtkWidget: w];
}

@end
