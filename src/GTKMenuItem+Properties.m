#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKMenuItem+Properties.h"

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

@end
