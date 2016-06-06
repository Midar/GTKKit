#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKLevelBar.h"

@implementation GTKLevelBar (Properties)
- (GtkLevelBarMode)mode
{
  return gtk_level_bar_get_mode(GTK_LEVEL_BAR(self.widget));
}

- (void)setMode:(GtkLevelBarMode)mode
{
  gtk_level_bar_set_mode(GTK_LEVEL_BAR(self.widget), mode);
}

- (double)value
{
  return gtk_level_bar_get_value(GTK_LEVEL_BAR(self.widget));
}

- (void)setValue:(double)value
{
  gtk_level_bar_set_value(GTK_LEVEL_BAR(self.widget), value);
}

- (double)min
{
  return gtk_level_bar_get_min_value(GTK_LEVEL_BAR(self.widget));
}

- (void)setMin:(double)value
{
  gtk_level_bar_set_min_value(GTK_LEVEL_BAR(self.widget), value);
}

- (double)max
{
  return gtk_level_bar_get_max_value(GTK_LEVEL_BAR(self.widget));
}

- (void)setMax:(double)value
{
  gtk_level_bar_set_max_value(GTK_LEVEL_BAR(self.widget), value);
}

- (bool)inverted
{
  return gtk_level_bar_get_inverted(GTK_LEVEL_BAR(self.widget));
}

- (void)setInverted:(bool)inverted
{
  gtk_level_bar_set_inverted(GTK_LEVEL_BAR(self.widget), inverted);
}
@end
