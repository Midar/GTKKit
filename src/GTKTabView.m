/*! @file GTKTabView.m
 *
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

#import "GTKTabView.h"
#import "GTKKeyedArchiver.h"
#import "GTKKeyedUnarchiver.h"
#import "OFArray+GTKCoding.h"

@implementation GTKTabView
- init
{
	self = [super init];
	self.frameHidden = false;
	_tabs = [OFMutableArray new];
	return self;
}

- (instancetype)initWithCoder: (GTKKeyedUnarchiver *)decoder
{
	self = [super initWithCoder: decoder];
	for (GTKTab *tab in [decoder decodeObjectForKey: @"GTKKit.coding.tabView.tabs"]) {
		[self addTab: tab];
	}
	[decoder decodeBoolForKey: @"GTKKit.coding.tabView.tabsHidden"];
	return self;
}

- (void)encodeWithCoder:(GTKKeyedArchiver *)encoder
{
	[super encodeWithCoder: encoder];
	[encoder encodeObject: _tabs
		       forKey: @"GTKKit.coding.tabView.tabs"];
	[encoder encodeBool: self.tabsHidden
		     forKey: @"GTKKit.coding.tabView.tabsHidden"];
}

- (void)createMainWidget
{
	[GTKApp.dispatch.gtk sync: ^{
		self.mainWidget = gtk_frame_new(NULL);

		_stack = gtk_stack_new();
		g_object_ref_sink(G_OBJECT(_stack));
		gtk_container_add(
		    GTK_CONTAINER(self.mainWidget),
		    _stack);
		gtk_stack_set_homogeneous(GTK_STACK(_stack), true);
		gtk_widget_show(_stack);

		_switcher = gtk_stack_switcher_new();
		g_object_ref_sink(G_OBJECT(_switcher));
		gtk_frame_set_label_widget(
		    GTK_FRAME(self.mainWidget),
		    _switcher);
		gtk_frame_set_label_align(
		    GTK_FRAME(self.mainWidget),
		    0.5, 0.5);
		gtk_stack_switcher_set_stack(
		    GTK_STACK_SWITCHER(_switcher),
		    GTK_STACK(_stack));
		gtk_widget_show(_switcher);
	}];
}

- (void)dealloc
{
	g_object_unref(_stack);
	g_object_unref(_switcher);
}

- (OFArray *)tabs
{
	OFMutableArray *tabs = _tabs.copy;
	[tabs makeImmutable];
	return tabs;
}

- (void)addTab: (GTKTab *)tab
{
	[_tabs addObject: tab];
	[GTKApp.dispatch.gtk sync: ^{
		gtk_stack_add_titled(
		    GTK_STACK(_stack),
		    tab.contentView.overlayWidget,
		    tab.label.UTF8String,
		    tab.label.UTF8String);
	}];
	tab.tabView = self;
}

- (void)removeTab: (GTKTab *)tab
{
	[GTKApp.dispatch.gtk sync: ^{
		gtk_container_remove(
		    GTK_CONTAINER(_stack),
		    tab.contentView.overlayWidget);
	}];
	[_tabs removeObjectIdenticalTo: tab];
	tab.tabView = nil;
}

- (void)renameTab: (nonnull GTKTab *)tab
	 toString: (OFString *)string
{
	[GTKApp.dispatch.gtk sync: ^{
		gtk_container_child_set(
		    GTK_CONTAINER(_stack),
		    tab.contentView.overlayWidget,
		    "name", tab.label.UTF8String,
		    "title", tab.label.UTF8String,
		    NULL);
	}];
}

- (int)indexOfTab: (GTKTab *)tab
{
	return [_tabs indexOfObjectIdenticalTo: tab];
}

- (int)numberOfTabs
{
	return _tabs.count;
}

- (void)insertTab: (nonnull GTKTab *)tab
	  atIndex: (int)index
{
	[_tabs insertObject: tab
		    atIndex: index];
	[GTKApp.dispatch.gtk sync: ^{
		gtk_stack_add_titled(
		    GTK_STACK(_stack),
		    tab.contentView.overlayWidget,
		    tab.label.UTF8String,
		    tab.label.UTF8String);
		gtk_container_child_set(
		    GTK_CONTAINER(_stack),
		    tab.contentView.overlayWidget,
		    "position",
		    index,
		    NULL);
	}];
	tab.tabView = self;
}

- (nullable GTKTab *)tabAtIndex: (int)index
{
	return [_tabs objectAtIndex: index];
}

- (bool)tabsHidden
{
	return _tabsHidden;
}

- (void)setTabsHidden: (bool)hidden
{
	_tabsHidden = hidden;
	[GTKApp.dispatch.gtk sync: ^{
		gtk_widget_set_visible(_switcher, !hidden);
	}];
}

- (bool)frameHidden
{
	return _tabsHidden;
}

- (void)setFrameHidden: (bool)hidden
{
	_frameHidden = hidden;
	[GTKApp.dispatch.gtk sync: ^{
		if (hidden) {
			gtk_frame_set_shadow_type(
			    GTK_FRAME(self.mainWidget),
			    GTK_SHADOW_NONE);
		} else {
			gtk_frame_set_shadow_type(
			    GTK_FRAME(self.mainWidget),
			    GTK_SHADOW_IN);
		}
	}];
}

- (GtkWidget *)stack
{
	return _stack;
}
@end
