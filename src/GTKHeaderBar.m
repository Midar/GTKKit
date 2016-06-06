#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKHeaderBar.h"

@implementation GTKHeaderBar
- init
{
  self = [super init];
  self.widget = gtk_header_bar_new();
  return self;
}
@end
