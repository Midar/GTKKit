#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKSeparator.h"

@implementation GTKSeparator
+ (instancetype)separatorWithOrientation:(GtkOrientation)orientation
{
  return [[self alloc] initWithOrientation: orientation];
}

- initWithOrientation:(GtkOrientation)orientation
{
  self = [super init];
  self.widget = gtk_separator_new(orientation);
  g_object_ref(G_OBJECT(self.widget));
  g_object_set_data(G_OBJECT(self.widget), "_GTKKIT_WRAPPER_WIDGET_", (__bridge void*) self);
  return self;
}

- init
{
  OF_INVALID_INIT_METHOD
}
@end
