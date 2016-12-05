/*! @file GTKNotebookView.m
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

#import "GTKNotebookView.h"
#import "GTKKeyedArchiver.h"
#import "GTKKeyedUnarchiver.h"
#import "OFArray+GTKCoding.h"

@interface GTKNotebookView ()
- (void)reorderTab:(GTKTab *)tab toIndex:(int)index;
@end

static GTKTab *
gtk_widget_get_owning_tab(GtkWidget *widget)
{
    return (__bridge GTKTab *)g_object_get_data(
        G_OBJECT(widget),
        "_GTKKIT_OWNING_TAB_");
}

static void
page_reordered_handler(GtkNotebook     *widget,
                       GtkWidget       *child,
                       guint            index,
                       GTKNotebookView *notebook)
{
    GTKTab *tab = gtk_widget_get_owning_tab(child);
    [notebook reorderTab: tab toIndex: index];
}

@implementation GTKNotebookView
- init
{
    self = [super init];
    return self;
}

- (instancetype)initWithCoder:(GTKKeyedUnarchiver *)decoder
{
	self = [super initWithCoder: decoder];

    for (GTKTab *tab in [decoder decodeObjectForKey: @"GTKKit.coding.tabView.tabs"]) {
        [self addTab: tab];
    }

    OFString *positionType = [decoder decodeStringForKey: @"GTKKit.coding.notebookView.tabPosition"];
    if ([positionType isEqual: @"top"]) {
        self.tabPosition = GTKPositionTypeTop;
    } else if ([positionType isEqual: @"bottom"]) {
        self.tabPosition = GTKPositionTypeBottom;
    } else if ([positionType isEqual: @"left"]) {
        self.tabPosition = GTKPositionTypeLeft;
    } else {
        self.tabPosition = GTKPositionTypeRight;
    }

    self.tabsHidden = [decoder decodeBoolForKey: @"GTKKit.coding.notebookView.tabsHidden"];

    return self;
}

- (void)encodeWithCoder:(GTKKeyedArchiver *)encoder
{
    switch (self.tabPosition) {
    case GTKPositionTypeTop:
        [encoder encodeString: @"top" forKey: @"GTKKit.coding.notebookView.tabPosition"];
        break;
    case GTKPositionTypeBottom:
        [encoder encodeString: @"bottom" forKey: @"GTKKit.coding.notebookView.tabPosition"];
        break;
    case GTKPositionTypeLeft:
        [encoder encodeString: @"left" forKey: @"GTKKit.coding.notebookView.tabPosition"];
        break;
    case GTKPositionTypeRight:
        [encoder encodeString: @"right" forKey: @"GTKKit.coding.notebookView.tabPosition"];
        break;
    }

    [encoder encodeBool: self.tabsHidden forKey: @"GTKKit.coding.notebookView.tabsHidden"];
    [encoder encodeObject: _tabs forKey: @"GTKKit.coding.tabView.tabs"];
}

- (void)createMainWidget
{
    [GTKApp.dispatch.gtk sync: ^{
        self.mainWidget = gtk_notebook_new();
        gtk_notebook_popup_disable(GTK_NOTEBOOK(self.mainWidget));


		g_signal_connect(
			G_OBJECT(self.mainWidget),
			"page-reordered",
			G_CALLBACK(page_reordered_handler),
			(__bridge gpointer)(self));
    }];
}

- (void)dealloc
{

}

- (GTKPositionType)tabPosition
{
    return _tabPosition;
}

- (void)setTabPosition:(GTKPositionType)position
{
    _tabPosition = position;
    [GTKApp.dispatch.gtk sync: ^{
        gtk_notebook_set_tab_pos(
            GTK_NOTEBOOK(self.mainWidget),
            (GtkPositionType)(position));
    }];
}

- (bool)tabsHidden
{
    return _tabsHidden;
}

- (void)setTabsHidden:(bool)hidden
{
    _tabsHidden = hidden;
    [GTKApp.dispatch.gtk sync: ^{
        gtk_notebook_set_show_tabs(
            GTK_NOTEBOOK(self.mainWidget),
            !hidden);
    }];
}

- (bool)scrollable
{
    return _scrollable;
}

- (void)setScrollable:(bool)scrollable
{
    _scrollable = scrollable;
    [GTKApp.dispatch.gtk sync: ^{
        gtk_notebook_set_scrollable(
            GTK_NOTEBOOK(self.mainWidget),
            scrollable);
    }];
}

- (OFArray *)tabs
{
    OFMutableArray *tabs = _tabs.copy;
    [tabs makeImmutable];
    return tabs;
}

- (void)addTab:(GTKTab *)tab
{
    [_tabs addObject: tab];
    [GTKApp.dispatch.gtk sync: ^{
        gtk_notebook_append_page(
            GTK_NOTEBOOK(self.mainWidget),
            tab.contentView.overlayWidget,
            NULL);
        gtk_notebook_set_tab_label_text(
            GTK_NOTEBOOK(self.mainWidget),
            tab.contentView.overlayWidget,
            tab.label.UTF8String);
        gtk_notebook_set_tab_reorderable(
            GTK_NOTEBOOK(self.mainWidget),
            tab.contentView.overlayWidget,
            true);
    }];
    tab.notebookView = self;
}

- (void)removeTab:(GTKTab *)tab
{
    [GTKApp.dispatch.gtk sync: ^{
        gtk_container_remove(
            GTK_CONTAINER(self.mainWidget),
            tab.contentView.overlayWidget);
    }];
    [_tabs removeObjectIdenticalTo: tab];
    tab.notebookView = nil;
}

- (void)renameTab:(nonnull GTKTab *)tab
         toString:(OFString *)string
{
    [GTKApp.dispatch.gtk sync: ^{
        gtk_container_child_set(
            GTK_CONTAINER(self.mainWidget),
            tab.contentView.overlayWidget,
            "tab-label", tab.label.UTF8String,
            NULL);
    }];
}

- (void)reorderTab:(GTKTab *)tab toIndex:(int)index
{
    [_tabs removeObjectIdenticalTo: tab];
    [_tabs insertObject: tab
                atIndex: index];
}

- (int)indexOfTab:(GTKTab *)tab
{
    return [_tabs indexOfObjectIdenticalTo: tab];
}

- (int)numberOfTabs
{
    return _tabs.count;
}

- (void)insertTab:(nonnull GTKTab *)tab
          atIndex:(int)index
{
    [_tabs insertObject: tab
                atIndex: index];
    [GTKApp.dispatch.gtk sync: ^{
        gtk_notebook_insert_page(
            GTK_NOTEBOOK(self.mainWidget),
            tab.contentView.overlayWidget,
            NULL,
            index);
        gtk_container_child_set(
            GTK_CONTAINER(self.mainWidget),
            tab.contentView.overlayWidget,
            "tab-label", tab.label.UTF8String,
            NULL);
    }];
    tab.notebookView = self;
}

- (nullable GTKTab *)tabAtIndex:(int)index
{
    return [_tabs objectAtIndex: index];
}
@end
