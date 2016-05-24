#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKOverlay.h"

@implementation GTKOverlay (Actions)

- (void)addOverlayChild:(GTKWidget*)child {
  gtk_overlay_add_overlay(GTK_OVERLAY(self.widget), GTK_WIDGET([child widget]));
}

- (void)reorderOverlayChild:(GTKWidget*)child toIndex:(int)index {
  gtk_overlay_reorder_overlay(GTK_OVERLAY(self.widget), GTK_WIDGET([child widget]), index);
}

@end
