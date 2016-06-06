#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKOverlay+Properties.h"

@implementation GTKOverlay (Properties)
- (bool)overlayChildPassthrough:(GTKWidget*)child
{
  return gtk_overlay_get_overlay_pass_through(GTK_OVERLAY(self.widget), GTK_WIDGET(child.widget));
}

- (void)setOverlayChildPassthrough:(GTKWidget*)child
                                to:(bool)newValue
{
  gtk_overlay_set_overlay_pass_through(GTK_OVERLAY(self.widget), GTK_WIDGET(child.widget), newValue);
}
@end
