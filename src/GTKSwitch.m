#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKSwitch.h"

@implementation GTKSwitch
- init
{
  self = [super init];
  self.widget = gtk_switch_new();
  g_object_ref(G_OBJECT(self.widget));
  g_object_set_data(G_OBJECT(self.widget), "_GTKKIT_WRAPPER_WIDGET_",
      (__bridge void*) self);
  return self;
}

- (bool)active
{
  return gtk_switch_get_active(GTK_SWITCH(self.widget));
}

- (bool)state
{
  return gtk_switch_get_state(GTK_SWITCH(self.widget));
}

- (void)setActive:(bool)active
{
  gtk_switch_set_active(GTK_SWITCH(self.widget), active);
}

- (void)setState:(bool)state
{
  gtk_switch_set_state(GTK_SWITCH(self.widget), state);
}
@end
