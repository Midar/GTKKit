/*
 * Copyright (c) 2014, 2015, 2016
 *   Kyle Cardoza <Kyle.Cardoza@icloud.com>
 *
 * All rights reserved.
 *
 * This file is part of GTKKit. It may be distributed under the terms of the
 * 2-clause BSD License, which can be found in the file COPYING.BSD included in
 * the packaging of this file.
 *
 * Alternatively, it may be distributed under the terms of the GNU Lesser
 * General Public License, either version 2 or 3, which can be found in the
 * files COPYING.LGPL2 and COPYING.LGPL3, respectively, both also included in
 * the packaging of this file.
 */

#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKMenuShell.h"

@implementation GTKMenuShell
- (void)appendMenuItem: (GTKMenuItem*)menuItem
{
	if (self.widget == NULL)
		@throw [GTKDestroyedWidgetException new];

	menuItem.parent = self;
	gtk_menu_shell_append(GTK_MENU_SHELL(self.widget), menuItem.widget);
}

- (void)prependMenuItem: (GTKMenuItem*)menuItem
{
	if (self.widget == NULL)
		@throw [GTKDestroyedWidgetException new];

	menuItem.parent = self;
	gtk_menu_shell_prepend(GTK_MENU_SHELL(self.widget), menuItem.widget);
}

- (void)insertMenuItem: (GTKMenuItem*)menuItem
            atPosition: (int)position
{
	if (self.widget == NULL)
		@throw [GTKDestroyedWidgetException new];

	menuItem.parent = self;
	gtk_menu_shell_insert(GTK_MENU_SHELL(self.widget),
	    menuItem.widget, position);
}

- (void)deactivate
{
	if (self.widget == NULL)
		@throw [GTKDestroyedWidgetException new];

	gtk_menu_shell_deactivate(GTK_MENU_SHELL(self.widget));
}
@end
