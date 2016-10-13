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
#import "GTKApplicationDelegate+GTKResponder.h"
#import "GTKWindowViewControllerDelegate.h"

static void
close_button_clicked_handler(GtkButton *button, gpointer userdata)
{
    GTKWindowViewController *window = (__bridge GTKWindowViewController *)(userdata);

    //FIXME: Make a window delegate protocol and apply it here.

    if ([window.delegate respondsToSelector: @selector(windowShouldClose)]) {
        if (![window.delegate windowShouldClose]) {
            return;
        }
    }

    if ([window.delegate respondsToSelector: @selector(windowWillClose)]) {
        [window.delegate windowWillClose];
    }

    window.hidden = true;

    if ([window.delegate respondsToSelector: @selector(windowDidClose)]) {
        [window.delegate windowDidClose];
    }
}

@implementation GTKWindowViewController
- init
{
    self = [super init];

    [self willBecomeFirstResponder];
    self.firstResponder = self;
    [self didBecomeFirstResponder];

    self.contentView = [GTKView new];
    self.contentView.nextResponder = self;
    self.nextResponder = (GTKApplicationDelegate *)(OFApplication.sharedApplication.delegate);

    [GTKCallback sync: ^{

        _headerBar = gtk_header_bar_new();
        g_object_ref_sink(G_OBJECT(_headerBar));
        gtk_widget_show(_headerBar);

        _window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
        g_object_ref_sink(G_OBJECT(_window));
        g_object_set_data(
            G_OBJECT(_window),
            "_GTKKIT_OWNING_VIEW_CONTROLLER_",
            (__bridge gpointer)(self));
        gtk_widget_set_size_request(
            _window,
            1,
            1);
        gtk_window_set_default_size(
            GTK_WINDOW(_window),
            100,
            100);
        gtk_container_add(
            GTK_CONTAINER(_window),
            self.contentView.overlayWidget);
        gtk_header_bar_set_has_subtitle(
            GTK_HEADER_BAR(_headerBar),
            false);
        gtk_window_set_titlebar(
            GTK_WINDOW(_window),
            _headerBar);

        _closeButton = gtk_button_new_from_icon_name(
            "window-close",
            GTK_ICON_SIZE_BUTTON);

        gtk_widget_show(_closeButton);

        gtk_header_bar_pack_end(
            GTK_HEADER_BAR(_headerBar),
            _closeButton);

		_closeButtonClickedHandlerID = g_signal_connect(
			G_OBJECT(_closeButton),
			"clicked",
			G_CALLBACK(close_button_clicked_handler),
			(__bridge gpointer)(self));
    }];

    self.hidden = true;

    return self;
}

- (void)dealloc
{
    [GTKCallback sync: ^{
        gtk_widget_destroy(_window);
    }];
}

- (bool)isHidden
{
    __block bool hidden;
    [GTKCallback sync: ^{
        hidden = !gtk_widget_get_visible(_window);
    }];
    return hidden;
}

- (void)setHidden:(bool)hidden
{
    [GTKCallback sync: ^{
        gtk_widget_set_visible(_window, !hidden);
    }];
}

- (GTKRect)frame
{
    __block GTKRect frame;
    [GTKCallback sync: ^{
        gtk_window_get_size(
            GTK_WINDOW(_window),
            &frame.width,
            &frame.height);
        gtk_window_get_position(
            GTK_WINDOW(_window),
            &frame.x,
            &frame.y);
    }];
    return frame;
}

- (void)setFrame:(GTKRect)frame
{
    [GTKCallback sync: ^{
        gtk_window_resize(GTK_WINDOW(_window), frame.width, frame.height);
        gtk_window_move(GTK_WINDOW(_window), frame.x, frame.y);
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
        gtk_window_set_decorated(GTK_WINDOW(_window), visible);
    }];
}

- (bool)titleVisible
{
    __block bool visible;
    [GTKCallback sync: ^{
        visible = gtk_window_get_decorated(GTK_WINDOW(_window));
    }];
    return visible;
}

- (void)setResizable:(bool)resizable
{
    [GTKCallback sync: ^{
        gtk_window_set_resizable(GTK_WINDOW(_window), resizable);
    }];
}

- (bool)isResizable
{
    __block bool resizable;
    [GTKCallback sync: ^{
        resizable = gtk_window_get_resizable(GTK_WINDOW(_window));
    }];
    return resizable;
}

- (bool)hasToplevelFocus
{
    __block bool hasToplevelFocus;
    [GTKCallback sync: ^{
        hasToplevelFocus = gtk_window_has_toplevel_focus(GTK_WINDOW(_window));
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

- (double)alpha
{
    __block double alpha;
    [GTKCallback sync: ^{
        alpha = gtk_widget_get_opacity(_window);
    }];
    return alpha;
}

- (void)setAlpha:(double)alpha
{
    [GTKCallback sync: ^{
        gtk_widget_set_opacity(_window, alpha);
    }];
}

- (bool)canBecomeFirstResponder
{
    return true;
}

- (bool)shouldBecomeFirstResponder
{
    return true;
}
@end
