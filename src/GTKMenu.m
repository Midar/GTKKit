#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKMenu.h"

@implementation GTKMenu
- init
{
  self = [super init];
  self.widget = gtk_menu_new ();
  g_object_ref(G_OBJECT(self.widget));
  g_object_set(G_OBJECT(self.widget), "width-request", 200, NULL);
  g_object_set_data(G_OBJECT(self.widget), "_GTKKIT_WRAPPER_WIDGET_",
      (__bridge void*) self);
  return self;
}

- (void)popup
{
  gtk_menu_popup (GTK_MENU(self.widget),
                  NULL, NULL, NULL, NULL,
                  1,
                  gtk_get_current_event_time());
}
@end
