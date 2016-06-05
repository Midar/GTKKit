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
    g_object_set(G_OBJECT(self.widget), "width-request", 200, NULL);
  }
	return self;
}

- (void)popup {
  gtk_menu_popup (GTK_MENU(self.widget),
                  NULL, NULL, NULL, NULL,
                  1,
                  gtk_get_current_event_time());
}

@end
