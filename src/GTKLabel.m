#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKLabel.h"

@implementation GTKLabel
- init
{
  self = [super init];
  self.widget = gtk_label_new(NULL);
  return self;
}
@end
