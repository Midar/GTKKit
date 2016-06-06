#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKOverlay.h"

@implementation GTKOverlay
- init
{
  self = [super init];
  self.widget = gtk_overlay_new();
  return self;
}
@end
