#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKMenu.h"

@implementation GTKMenu

- (id)createWidget {
  self.widget = gtk_menu_new ();
  return self;
}

- (id)init {
	self = [super init];
  if (self) {
    
  }
	return self;
}

@end
