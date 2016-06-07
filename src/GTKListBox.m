#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKListBox.h"

@implementation GTKListBox
- init
{
  self = [super init];
  self.widget = gtk_list_box_new();
  return self;
}
@end
