#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKCheckButton.h"

static void buttonToggled(GtkWidget *button, GTKButton *sender) {
  #pragma clang diagnostic push
  #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
  if (sender.target && sender.action)
    [sender.target performSelector: sender.action withObject: sender];
  #pragma clang diagnostic pop
}

@implementation GTKCheckButton

- (id)createWidget {
  self.widget = gtk_check_button_new ();
  g_signal_connect(GTK_WIDGET (self.widget), "toggled", G_CALLBACK (buttonToggled), (__bridge void*) self);
	return self;
}

- (id)init {
  self = [super init];
  return self;
}

@end
