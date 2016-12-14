/*! @file GTKMenu.m
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


#import "GTKMenu.h"
#import "GTKApplication.h"
#import "GTKKeyedArchiver.h"
#import "GTKKeyedUnarchiver.h"
#import "OFArray+GTKCoding.h"
#import "GTKView.h"

static void
map_handler(GtkWidget *overlay,
	    GTKView   *view)
{
	[GTKApp.dispatch.main async: ^{
		//[view willBecomeMapped];
	}];
}

@implementation GTKMenu
- init
{
	self = [super init];
	_menuItems = [OFMutableArray new];
	[GTKApp.dispatch.gtk sync: ^{
		_menu = gtk_menu_new();
		g_object_ref_sink(_menu);

		g_signal_connect(
		    G_OBJECT(_menu),
		    "map",
		    G_CALLBACK(map_handler),
		    (__bridge gpointer) self);
	}];
	return self;
}

- (instancetype)initWithCoder: (GTKKeyedUnarchiver *)decoder
{
	self = [self init];

	for (GTKMenuItem *item in [decoder decodeObjectForKey: @"GTKKit.coding.menu.items"]) {
		[self addItem: item];
	}

	return self;
}

- (void)encodeWithCoder: (GTKKeyedArchiver *)encoder
{
	[encoder encodeObject: _menuItems
		       forKey: @"GTKKit.coding.menu.items"];
}

- (void)dealloc
{
	g_object_unref(_menu);
}

- (void)addItem: (GTKMenuItem *)item
{
	[_menuItems addObject: item];
	[GTKApp.dispatch.gtk sync: ^{
		gtk_menu_shell_append(
		    GTK_MENU_SHELL(_menu),
		    item.menuItem);
	}];
}

- (void)insertItem: (GTKMenuItem *)item
	   atIndex: (int)index
{
	[_menuItems insertObject: item
			 atIndex: index];
	[GTKApp.dispatch.gtk sync: ^{
		gtk_menu_shell_insert(
		    GTK_MENU_SHELL(_menu),
		    item.menuItem,
		    index);
	}];
}

- (void)removeItem: (GTKMenuItem *)item
{
	[_menuItems removeObjectIdenticalTo: item];
	[GTKApp.dispatch.gtk sync: ^{
		gtk_container_remove(
		    GTK_CONTAINER(_menu),
		    item.menuItem);
	}];
}

- (int)numberOfItems
{
	return _menuItems.count;
}

- (GTKMenuItem *)itemAtIndex: (int)index
{
	return [_menuItems objectAtIndex: index];
}

- (GTKMenuItem *)itemWithTag: (int)tag
{
	for (GTKMenuItem *item in _menuItems) {
		if (item.tag == tag) {
			return item;
		}
	}
	return nil;
}

- (OFArray *)itemArray
{
	OFMutableArray *array = _menuItems.copy;
	[array makeImmutable];
	return array;
}

- (void)popUpAtView: (GTKView *)view
{
	[GTKApp.dispatch.gtk sync: ^{
		gtk_menu_popup_at_widget(
		    GTK_MENU(_menu),
		    view.overlayWidget,
		    GDK_GRAVITY_SOUTH_WEST,
		    GDK_GRAVITY_NORTH_WEST,
		    NULL);
	}];
}
@end
