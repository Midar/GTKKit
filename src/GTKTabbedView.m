/*! @file GTKTabbedViewController.m
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

#import "GTKTabbedView.h"
#import "GTKApplication.h"

@implementation GTKTabbedView
- init
{
    self = [super init];
    self.views = [OFMutableDictionary new];

    [GTKApp.dispatch.gtk sync: ^{
        gtk_widget_destroy(self.mainWidget);
        g_object_unref(G_OBJECT(self.mainWidget));

        self.mainWidget = gtk_frame_new(NULL);
        g_object_ref_sink(G_OBJECT(self.mainWidget));
        gtk_container_add(
            GTK_CONTAINER(self.overlayWidget),
            self.mainWidget);
        gtk_widget_show(self.mainWidget);

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
@end
