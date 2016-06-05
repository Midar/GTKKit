#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKHeaderBar.h"

@implementation GTKHeaderBar

- (id)createWidget {
	self.widget = gtk_header_bar_new();
	return self;
}

@end
