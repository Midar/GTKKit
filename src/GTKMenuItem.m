/*! @file GTKMenuItem.m
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


#import "GTKMenuItem.h"
#import "GTKApplication.h"
#import "GTKKeyedArchiver.h"
#import "GTKKeyedUnarchiver.h"

static void
activate_handler(GtkMenuItem *widget,
		 GTKMenuItem *menuItem)
{
	[GTKApp.dispatch.main async: ^{
		[menuItem sendActionToTarget];
	}];
}

@implementation GTKMenuItem
+ separator
{
	return [[self alloc] initWithSeparator];
}

- init
{
	self = [super init];

	self.tag = -1;
	_isSeparator = false;

	[GTKApp.dispatch.gtk sync: ^{
		_menuItem = gtk_menu_item_new_with_label("QUIT REALLY LONG APP NAME");
		g_object_ref_sink(_menuItem);
		gtk_widget_show(_menuItem);
		gtk_menu_item_set_reserve_indicator(
		    GTK_MENU_ITEM(_menuItem),
		    true);
		g_signal_connect(
		    G_OBJECT(_menuItem),
		    "activate",
		    G_CALLBACK(activate_handler),
		    (__bridge gpointer) self);

		GtkWidget *defaultLabel = gtk_bin_get_child(GTK_BIN(_menuItem));
		gtk_widget_destroy(defaultLabel);


		_grid = gtk_grid_new();
		g_object_ref_sink(_grid);
		gtk_widget_show(_grid);
		gtk_orientable_set_orientation(
		    GTK_ORIENTABLE(_grid),
		    GTK_ORIENTATION_HORIZONTAL);
		gtk_widget_set_hexpand(
		    _grid,
		    true);
		gtk_widget_set_vexpand(
		    _grid,
		    true);
		gtk_grid_set_column_homogeneous(
		    GTK_GRID(_grid),
		    false);
		gtk_container_add(
		    GTK_CONTAINER(_menuItem),
		    _grid);

		_labelWidget = gtk_label_new(NULL);
		g_object_ref_sink(_labelWidget);
		gtk_widget_show(_labelWidget);
		gtk_label_set_markup(
		    GTK_LABEL(_labelWidget),
		    "SECOND LABEL");
		gtk_label_set_justify(
		    GTK_LABEL(_labelWidget),
		    GTK_JUSTIFY_LEFT);
		gtk_widget_set_hexpand(
		    _labelWidget,
		    true);
		gtk_widget_set_vexpand(
		    _labelWidget,
		    true);
		gtk_widget_set_halign(
		    _labelWidget,
		    GTK_ALIGN_START);
		gtk_label_set_xalign(
		    GTK_LABEL(_labelWidget),
		    0.0);
		gtk_label_set_yalign(
		    GTK_LABEL(_labelWidget),
		    0.5);
		gtk_container_add(
		    GTK_CONTAINER(_grid),
		    _labelWidget);

	}];
	return self;
}

- initWithSeparator
{
	self = [super init];

	self.tag = -1;
	_isSeparator = true;

	[GTKApp.dispatch.gtk sync: ^{
		_menuItem = gtk_separator_menu_item_new();
		g_object_ref_sink(_menuItem);
		gtk_widget_set_vexpand(
		    _menuItem,
		    true);
		gtk_widget_set_margin_top(_menuItem, 4);
		gtk_widget_set_margin_bottom(_menuItem, 4);
		gtk_widget_show(_menuItem);
	}];

	return self;
}

- (void)dealloc
{
	g_object_unref(_acceleratorWidget);
	g_object_unref(_labelWidget);
	g_object_unref(_grid);
	g_object_unref(_menuItem);
}

- (instancetype)initWithCoder: (GTKKeyedUnarchiver *)decoder
{
	if ([decoder decodeBoolForKey: @"GTKKit.coding.menuItem.isSeparator"]) {
		self = [self initWithSeparator];
	} else {
		self = [self init];
		self.label = [decoder decodeStringForKey: @"GTKKit.coding.menuItem.label"];
		self.accelerator = [decoder decodeStringForKey: @"GTKKit.coding.menuItem.accelerator"];
	}
	return self;
}

- (void)encodeWithCoder: (GTKKeyedArchiver *)encoder
{
	if (!_isSeparator) {
		[encoder encodeString: self.label
			       forKey: @"GTKKit.coding.menuItem.label"];
		[encoder encodeString: self.accelerator
			       forKey: @"GTKKit.coding.menuItem.accelerator"];
		[encoder encodeBool: false
			     forKey: @"GTKKit.coding.menuItem.isSeparator"];
	} else {
		[encoder encodeBool: true
			     forKey: @"GTKKit.coding.menuItem.isSeparator"];
	}
}

- (GtkWidget *)menuItem
{
	return _menuItem;
}

- (void)sendActionToTarget
{
	[GTKApp.dispatch.main sync: ^{
		if (NULL == self.action) {
			return;
		}

		if (nil == self.target) {
			GTKResponder *target = GTKApp.firstResponder;
			if (nil == target) {
				return;
			}
			IMP imp = [target methodForSelector: self.action];
			void (*func)(id, SEL, id) = (void *) imp;
			func(target, self.action, self);
		} else {
			IMP imp = [self.target methodForSelector: self.action];
			void (*func)(id, SEL, id) = (void *) imp;
			func(self.target, self.action, self);
		}
	}];
}

- (OFString *)label
{
	return _label.copy;
}

- (void)setLabel: (OFString *)label
{
	_label = label.copy;
	[GTKApp.dispatch.gtk sync: ^{
		gtk_label_set_markup(
		    GTK_LABEL(_labelWidget),
		    _label.UTF8String);
	}];
}

- (OFString *)accelerator
{
	return _label.copy;
}

- (void)setAccelerator: (OFString *)label
{
	_label = label.copy;
	[GTKApp.dispatch.gtk sync: ^{
		gtk_label_set_markup(
		    GTK_LABEL(_acceleratorWidget),
		    _label.UTF8String);
	}];
}

- (bool)isSeparator
{
	return _isSeparator;
}
@end
