#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKMenuItem.h"

static void menuItemActivated(GtkMenuItem *widget, GTKMenuItem *sender)
{
  if (sender.target && sender.action) {
    void (*methodImplementation)(id, SEL, id) = (void(*)(id, SEL, id))[sender.target methodForSelector: sender.action];
    methodImplementation(sender.target, sender.action, sender);
  }
}

@implementation GTKMenuItem
- init
{
  self = [super init];
  self.widget = gtk_menu_item_new();
  menuItemActivatedHandlerID = g_signal_connect(GTK_WIDGET (self.widget), "activate", G_CALLBACK (menuItemActivated), (__bridge void*) self);
  gtk_widget_show_all(GTK_WIDGET(self.widget));
  return self;
}

- (void)dealloc
{
  if (self.widget != NULL)
    g_signal_handler_disconnect(G_OBJECT (self.widget), menuItemActivatedHandlerID);
}

@end
