#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKButton.h"
#import "GTKButton+Properties.h"

@implementation GTKButton (Properties)
- (void)setLabel:(OFString *)label
{
  gtk_button_set_label (GTK_BUTTON (self.widget), [label UTF8String]);
}

- (OFString *)label
{
  return @(gtk_button_get_label (GTK_BUTTON (self.widget)));
}

- (void)setReliefStyle:(GtkReliefStyle)relief
{
  gtk_button_set_relief (GTK_BUTTON (self.widget), relief);
}

- (GtkReliefStyle)reliefStyle
{
  return gtk_button_get_relief (GTK_BUTTON (self.widget));
}
@end
