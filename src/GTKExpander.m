#import "GTKExpander.h"

@implementation GTKExpander
- init
{
  self = [super init];
  self.widget = gtk_expander_new ("");
  g_object_ref(G_OBJECT(self.widget));
  g_object_set_data(G_OBJECT(self.widget), "_GTKKIT_WRAPPER_WIDGET_", (__bridge void*) self);
  return self;
}
@end
