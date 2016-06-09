#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKToggleButton.h"

static void
buttonToggled(GtkWidget *button, GTKButton *sender)
{
  if (sender.target && sender.action) {
    void (*methodImplementation)(id, SEL, id) = \
        (void(*)(id, SEL, id))[sender.target methodForSelector: sender.action];
    methodImplementation(sender.target, sender.action, sender);
  }
}

@implementation GTKToggleButton
- init
{
  self = [super init];
  g_object_unref(G_OBJECT(self.widget));
  gtk_widget_destroy(GTK_WIDGET(self.widget));
  self.widget = gtk_toggle_button_new ();
  g_object_ref(G_OBJECT(self.widget));
  g_object_set_data(G_OBJECT(self.widget), "_GTKKIT_WRAPPER_WIDGET_",
      (__bridge void*) self);
  _buttonToggledHandlerID = g_signal_connect(GTK_WIDGET (self.widget),
      "toggled", G_CALLBACK (buttonToggled), (__bridge void*) self);
  return self;
}

- (void)dealloc
{
  if (self.widget != NULL)
    g_signal_handler_disconnect(G_OBJECT (self.widget),
        _buttonToggledHandlerID);
}
@end
