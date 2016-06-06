#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKMenuShell.h"

@implementation GTKMenuShell
- (void)appendMenuItem:(GTKMenuItem *)menuItem
{
  gtk_menu_shell_append(GTK_MENU_SHELL(self.widget), menuItem.widget);
}

- (void)prependMenuItem:(GTKMenuItem *)menuItem
{
  gtk_menu_shell_prepend(GTK_MENU_SHELL(self.widget), menuItem.widget);
}

- (void)insertMenuItem:(GTKMenuItem *)menuItem
            atPosition:(int)pos
{
  gtk_menu_shell_insert(GTK_MENU_SHELL(self.widget), menuItem.widget, pos);
}

- (void)deactivate
{
  gtk_menu_shell_deactivate(GTK_MENU_SHELL(self.widget));
}
@end
