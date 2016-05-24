#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKOverlay.h"

@implementation GTKOverlay

- (id)createWidget {
	self.widget = gtk_overlay_new();
	return self;
}

- (id)init {
	self = [super init];
	return self;
}

@end
