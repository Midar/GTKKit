#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKButton.h"

static void
buttonClicked(GtkWidget *button, GTKButton *sender)
{
  if (sender.target && sender.action) {
    void (*methodImplementation)(id, SEL, id) = \
        (void(*)(id, SEL, id))[sender.target methodForSelector: sender.action];
    methodImplementation(sender.target, sender.action, sender);
  }
}

@implementation GTKButton
- init
{
  self = [super init];
  self.widget = gtk_button_new ();
  g_object_ref(G_OBJECT(self.widget));
  g_object_set_data(G_OBJECT(self.widget), "_GTKKIT_WRAPPER_WIDGET_",
      (__bridge void*) self);
  _clickedHandlerID = g_signal_connect(GTK_WIDGET (self.widget), "clicked",
      G_CALLBACK (buttonClicked), (__bridge void*) self);
  return self;
}

- (void)dealloc
{
  if (self.widget != NULL)
    g_signal_handler_disconnect(G_OBJECT (self.widget), _clickedHandlerID);
}
@end
