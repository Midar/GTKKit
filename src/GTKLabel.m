#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKLabel.h"

@implementation GTKLabel
- init
{
  self = [super init];
  self.widget = gtk_label_new(NULL);
  g_object_ref(G_OBJECT(self.widget));
  g_object_set_data(G_OBJECT(self.widget), "_GTKKIT_WRAPPER_WIDGET_", (__bridge void*) self);
  return self;
}
@end
