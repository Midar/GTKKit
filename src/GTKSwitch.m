#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKSwitch.h"

@implementation GTKSwitch
- init
{
  self = [super init];
  self.widget = gtk_switch_new();
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
