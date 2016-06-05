#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKHeaderBar+Actions.h"

@implementation GTKHeaderBar (Actions)

- (void)addWidgetAtStart:(GTKWidget *)child {
  gtk_header_bar_pack_start(GTK_HEADER_BAR(self.widget), GTK_WIDGET(child.widget));
}

- (void)addWidgetAtEnd:(GTKWidget *)child {
  gtk_header_bar_pack_start(GTK_HEADER_BAR(self.widget), GTK_WIDGET(child.widget));
}

@end
