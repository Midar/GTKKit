#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKButton.h"

static void buttonClicked(GtkWidget *button, GTKButton *sender) {
  #pragma clang diagnostic push
  #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
  if (sender.target && sender.action)
    [sender.target performSelector: sender.action withObject: sender];
  #pragma clang diagnostic pop
}

@implementation GTKButton

@synthesize target;
@synthesize action;

- (id)createWidget {
  self.widget = gtk_button_new ();
  g_signal_connect(GTK_WIDGET (self.widget), "clicked", G_CALLBACK (buttonClicked), (__bridge void*) self);
	return self;
}

- (id)init {
	self = [super init];
	return self;
}

@end
