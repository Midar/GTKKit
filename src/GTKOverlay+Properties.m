#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKOverlay.h"

@implementation GTKOverlay (Actions)


- (bool)overlayChildPassthrough:(GTKWidget*)child {
  return gtk_overlay_get_overlay_pass_through(GTK_OVERLAY(self.widget), GTK_WIDGET(child.widget));
}

@end
