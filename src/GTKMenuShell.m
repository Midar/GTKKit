#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>
#import "GTKMenuShell.h"

@implementation GTKMenuShell

- (id)init {
	self = [super init];
  if (self) {
    self.menuItems = [OFMutableArray array];
  }
	return self;
}

- (void)appendMenuItem:(GTKMenuItem *)menuItem {
  [self.menuItems addObject: menuItem];
  gtk_menu_shell_append(GTK_MENU_SHELL(self.widget), menuItem.widget);
}

- (void)prependMenuItem:(GTKMenuItem *)menuItem {
  [self.menuItems addObject: menuItem];
  gtk_menu_shell_prepend(GTK_MENU_SHELL(self.widget), menuItem.widget);
}

- (void)insertMenuItem:(GTKMenuItem *)menuItem atPosition:(int)pos {
  [self.menuItems addObject: menuItem];
  gtk_menu_shell_insert(GTK_MENU_SHELL(self.widget), menuItem.widget, pos);
}

- (void)deactivate {
  gtk_menu_shell_deactivate(GTK_MENU_SHELL(self.widget));
}

@end
