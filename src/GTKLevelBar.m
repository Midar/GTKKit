#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKLevelBar.h"

@implementation GTKLevelBar
- init
{
  self = [super init];
  self.widget = gtk_level_bar_new();
  return self;
}
@end
