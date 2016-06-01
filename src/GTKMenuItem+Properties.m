#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKMenuItem+Properties.h"

static void menuItemActivated(GtkWidget *button, GTKMenuItem *sender) {
  #pragma clang diagnostic push
  #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
  if (sender.target && sender.action)
    [sender.target performSelector: sender.action withObject: sender];
  #pragma clang diagnostic pop
}

@implementation GTKMenuItem (Properties)

@dynamic label;

- (OFString *)label {
  const gchar *str = gtk_menu_item_get_label (GTK_MENU_ITEM(self.widget));
  return [OFString stringWithUTF8String: str];
}

- (void)setLabel:(OFString *)label {
  gtk_menu_item_set_label(GTK_MENU_ITEM(self.widget), [label UTF8String]);
}

- (GTKMenu *)submenu {
  GtkWidget *menu = gtk_menu_item_get_submenu(GTK_MENU_ITEM(self.widget));
  return [GTKMenu widgetFromGtkWidget: menu];
}

- (void)setSubmenu:(GTKMenu *)submenu {
  gtk_menu_item_set_submenu(GTK_MENU_ITEM(self.widget), GTK_WIDGET(submenu.widget));
}

- (id)initWithLabel:(OFString *)label {
  self = [self init];
  self.widget = gtk_menu_item_new_with_label("Hello");
  g_signal_connect(GTK_WIDGET (self.widget), "activate", G_CALLBACK (menuItemActivated), (__bridge void*) self);
  self.label = label;
  gtk_widget_show_all(GTK_WIDGET(self.widget));
  return self;
}

+ (id)menuItemWithLabel:(OFString *)label {
  id menuItem = [[self alloc] initWithLabel: label];
  return menuItem;
}

@end
