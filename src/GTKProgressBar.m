#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKProgressBar.h"

@implementation GTKProgressBar
- init
{
  self = [super init];
  self.widget = gtk_progress_bar_new();
  return self;
}
@end
