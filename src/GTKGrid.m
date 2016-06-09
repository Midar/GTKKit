#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKGrid.h"

@implementation GTKGrid
- init
{
  self = [super init];
  self.widget = gtk_grid_new();
  g_object_ref(G_OBJECT(self.widget));
  g_object_set_data(G_OBJECT(self.widget), "_GTKKIT_WRAPPER_WIDGET_", (__bridge void*) self);
  return self;
}
@end
