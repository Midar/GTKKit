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
  return self;
}

- init
{
  GTK_INVALID_INIT_METHOD
}
@end
