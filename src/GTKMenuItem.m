#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKMenuItem.h"

static void menuItemActivated(GtkMenuItem *widget, GTKMenuItem *sender) {
  #pragma clang diagnostic push
  #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
  if (sender.target && sender.action)
    [sender.target performSelector: sender.action withObject: sender];
  #pragma clang diagnostic pop
}

@implementation GTKMenuItem

- (id)createWidget {
  self.widget = gtk_menu_item_new();
  g_signal_connect(GTK_WIDGET (self.widget), "activate", G_CALLBACK (menuItemActivated), (__bridge void*) self);
	return self;
}

- (id)init {
	self = [super init];
  gtk_widget_show_all(GTK_WIDGET(self.widget));
	return self;
}

@end
