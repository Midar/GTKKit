#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKGrid.h"

@implementation GTKGrid
- init
{
  self = [super init];
  self.widget = gtk_grid_new();
  return self;
}
@end
