#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKFrame.h"

@implementation GTKFrame
- init
{
  self = [super init];
  self.widget = gtk_frame_new(NULL);
  return self;
}
@end
