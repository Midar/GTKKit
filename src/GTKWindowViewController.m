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

#import "GTKWindowViewController.h"
#import "OFApplication+GTKResponder.h"

/*!
 * @brief A class representing a view controller that manages a toplevel
 * window and its view hierarchy.
 */
@implementation GTKWindowViewController: GTKViewController
- init
{
    self = [super init];

    self.contentView = [GTKView new];
    self.contentView.nextResponder = self;
    self.nextResponder = OFApplication.sharedApplication;

    [GTKCallback sync: ^{
        _headerBar = gtk_header_bar_new();
        g_object_ref_sink(G_OBJECT(_headerBar));
        gtk_widget_show(_headerBar);
        self.window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
        g_object_ref_sink(G_OBJECT(self.window));
        g_object_set_data(
            G_OBJECT(self.window),
            "_GTKKIT_OWNING_VIEW_CONTROLLER_",
            (__bridge gpointer)(self));
        gtk_widget_set_size_request(
            self.window,
            1,
            1);
        gtk_window_set_default_size(
            GTK_WINDOW(self.window),
            100,
            100);
        gtk_container_add(
            GTK_CONTAINER(self.window),
            self.contentView.overlayWidget);
        gtk_header_bar_set_has_subtitle(
            GTK_HEADER_BAR(_headerBar),
            false);
        gtk_window_set_titlebar(
            GTK_WINDOW(self.window),
            _headerBar);
    }];

    self.hidden = true;

    return self;
}

- (void)dealloc
{
    [GTKCallback sync: ^{
        gtk_widget_destroy(self.window);
    }];
}

- (bool)isHidden
{
    __block bool hidden;
    [GTKCallback sync: ^{
        hidden = !gtk_widget_get_visible(self.window);
    }];
    return hidden;
}

- (void)setHidden:(bool)hidden
{
    [GTKCallback sync: ^{
        gtk_widget_set_visible(self.window, !hidden);
    }];
}

- (GTKRect)frame
{
    __block GTKRect frame;
    [GTKCallback sync: ^{
        gtk_window_get_size(
            GTK_WINDOW(self.window),
            &frame.width,
            &frame.height);
        gtk_window_get_position(
            GTK_WINDOW(self.window),
            &frame.x,
            &frame.y);
    }];
    return frame;
}

- (void)setFrame:(GTKRect)frame
{
    [GTKCallback sync: ^{
        gtk_window_resize(GTK_WINDOW(self.window), frame.width, frame.height);
        gtk_window_move(GTK_WINDOW(self.window), frame.x, frame.y);
    }];
}

- (void)addSubview:(nonnull GTKView *)subview
{
    [self.contentView addSubview: subview];
    subview.viewController = self;
}

- (void)close
{
    self.hidden = true;
}

- (void)setTitleVisible:(bool)visible
{
    [GTKCallback sync: ^{
        gtk_window_set_decorated(GTK_WINDOW(self.window), visible);
    }];
}

- (bool)titleVisible
{
    __block bool visible;
    [GTKCallback sync: ^{
        visible = gtk_window_get_decorated(GTK_WINDOW(self.window));
    }];
    return visible;
}

- (void)setResizable:(bool)resizable
{
    [GTKCallback sync: ^{
        gtk_window_set_resizable(GTK_WINDOW(self.window), resizable);
    }];
}

- (bool)isResizable
{
    __block bool resizable;
    [GTKCallback sync: ^{
        resizable = gtk_window_get_resizable(GTK_WINDOW(self.window));
    }];
    return resizable;
}

- (bool)hasToplevelFocus
{
    __block bool hasToplevelFocus;
    [GTKCallback sync: ^{
        hasToplevelFocus = gtk_window_has_toplevel_focus(GTK_WINDOW(self.window));
    }];
    return hasToplevelFocus;
}

- (OFString *)title
{
    __block OFString *title;
    [GTKCallback sync: ^{
        const char *str = gtk_header_bar_get_title(GTK_HEADER_BAR(_headerBar));
        title = [OFString stringWithUTF8String: str];
    }];
    return title;
}

- (void)setTitle:(OFString *)title
{
    [GTKCallback sync: ^{
        gtk_header_bar_set_title(
            GTK_HEADER_BAR(_headerBar),
            title.UTF8String);
    }];
}

- (OFString *)subtitle
{
    __block OFString *subtitle;
    [GTKCallback sync: ^{
        const char *str = gtk_header_bar_get_subtitle(GTK_HEADER_BAR(_headerBar));
        subtitle = [OFString stringWithUTF8String: str];
    }];
    return subtitle;
}

- (void)setSubtitle:(OFString *)subtitle
{
    [GTKCallback sync: ^{
        gtk_header_bar_set_subtitle(
            GTK_HEADER_BAR(_headerBar),
            subtitle.UTF8String);
    }];
}
@end
