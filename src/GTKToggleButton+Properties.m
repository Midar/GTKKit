#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKToggleButton+Properties.h"

@implementation GTKToggleButton (Properties)
- (void)setDrawIndicator:(bool) newValue
{
  gtk_toggle_button_set_mode(GTK_TOGGLE_BUTTON(self.widget), newValue);
}

- (bool)drawIndicator
{
  return gtk_toggle_button_get_mode(GTK_TOGGLE_BUTTON(self.widget));
}

- (void)setActive:(bool) newValue
{
  gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(self.widget), newValue);
}

- (bool)active
{
  return gtk_toggle_button_get_active(GTK_TOGGLE_BUTTON(self.widget));
}

- (void)setInconsistent:(bool) newValue
{
  gtk_toggle_button_set_inconsistent(GTK_TOGGLE_BUTTON(self.widget), newValue);
}

- (bool)inconsistent
{
  return gtk_toggle_button_get_inconsistent(GTK_TOGGLE_BUTTON(self.widget));
}
@end
