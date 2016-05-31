#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKProgressBar.h"

@implementation GTKProgressBar

- (id)createWidget {
  self.widget = gtk_progress_bar_new();
	return self;
}

@end
