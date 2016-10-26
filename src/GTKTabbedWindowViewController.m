/*! @file GTKTabbedWindowViewController.m
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

#import "GTKTabbedWindowViewController.h"
#import "GTKApplication.h"

@implementation GTKTabbedWindowViewController
- init
{
    self = [super init];
    self.views = [OFMutableDictionary new];

    [GTKApp.dispatch.gtk sync: ^{

        _stack = gtk_stack_new();
        g_object_ref(G_OBJECT(_stack));

        gtk_widget_destroy(self.contentView.mainWidget);
        gtk_container_add(
            GTK_CONTAINER(self.contentView.overlayWidget),
            _stack);
        gtk_widget_show(_stack);

        _switcher = gtk_stack_switcher_new();
        g_object_ref(G_OBJECT(_switcher));
        gtk_stack_switcher_set_stack(
            GTK_STACK_SWITCHER(_switcher),
            GTK_STACK(_stack));

        gtk_header_bar_set_custom_title(
            GTK_HEADER_BAR(_headerBar),
            _switcher);
        gtk_widget_show(_switcher);
    }];
    return self;
}

- (void)addTabTitled:(nonnull OFString *)title
{
    GTKView *subview = [GTKView new];
    [self.views setValue: subview forKey: title];
    [GTKApp.dispatch.gtk sync: ^{
        gtk_stack_add_titled(
            GTK_STACK(_stack),
            subview.overlayWidget,
            title.UTF8String,
            title.UTF8String);
    }];
}

- (void)removeTabTitled:(nonnull OFString *)title
{
    GTKView *tab = [self.views valueForKey: title];
    if (nil != tab) {
        [GTKApp.dispatch.gtk sync: ^{
            g_object_ref(tab.overlayWidget);
            gtk_container_remove(
                GTK_CONTAINER(_stack),
                tab.overlayWidget);
        }];
    }
    [self.views removeObjectForKey: title];
}

- (nullable GTKView *)tabViewTitled:(nonnull OFString *)title
{
    return [self.views valueForKey: title];
}

- (void)addView:(nonnull GTKView *)subview toTabTitled:(nonnull OFString *)title
{
    GTKView *view = [self tabViewTitled: title];
    [view addSubview: subview];
}

- (nullable OFString *)titleOfSelectedTab
{
    __block const char *str;
    __block OFString *title;
        gtk_stack_get_visible_child_name(GTK_STACK(_stack));
    [GTKApp.dispatch.gtk sync: ^{
        str = gtk_stack_get_visible_child_name(GTK_STACK(_stack));
        if (str == NULL) {
            str = "";
        }
        title = [OFString stringWithUTF8String: str];
    }];
    return title;
}

- (int)tabCount
{
    return self.views.count;
}
@end
