#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKMenuItem+Properties.h"

static void
menuItemActivated(GtkMenuItem *widget, GTKMenuItem *sender)
{
  if (sender.target && sender.action) {
    void (*methodImplementation)(id, SEL, id) = \
        (void(*)(id, SEL, id))[sender.target methodForSelector: sender.action];
    methodImplementation(sender.target, sender.action, sender);
  }
}

@implementation GTKMenuItem (Properties)
- (OFString *)label
{
  const gchar *str = gtk_menu_item_get_label (GTK_MENU_ITEM(self.widget));
  return [OFString stringWithUTF8String: str];
}

- (void)setLabel:(OFString *)label
{
  gtk_menu_item_set_label(GTK_MENU_ITEM(self.widget), [label UTF8String]);
}

- (GTKMenu *)submenu
{
  GtkWidget *menu = gtk_menu_item_get_submenu(GTK_MENU_ITEM(self.widget));
  return [GTKMenu widgetFromGtkWidget: menu];
}

- (void)setSubmenu:(GTKMenu *)submenu
{
  gtk_menu_item_set_submenu(GTK_MENU_ITEM(self.widget), GTK_WIDGET(submenu.widget));
}

- initWithLabel:(OFString *)label
{
  self = [self init];
  gtk_widget_destroy(GTK_WIDGET(self.widget));
  self.widget = gtk_menu_item_new_with_label("");
  _menuItemActivatedHandlerID = g_signal_connect(GTK_WIDGET (self.widget),
      "activate", G_CALLBACK (menuItemActivated), (__bridge void*) self);
  self.label = label;
  gtk_widget_show_all(GTK_WIDGET(self.widget));
  return self;
}

+ (instancetype)menuItemWithLabel:(OFString *)label
{
  return [[self alloc] initWithLabel: label];
}
@end
