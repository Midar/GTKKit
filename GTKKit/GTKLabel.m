#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import <GTKKit/GTKLabel.h>

@implementation GTKLabel

- (id)createWidget {
	self.widget = gtk_label_new(NULL);
	return self;
}

@end
