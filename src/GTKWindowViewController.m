/*! @file GTKWindowViewController.m
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
#import "GTKApplicationDelegate.h"
#import "GTKWindowViewControllerDelegate.h"
#import "GTKApplication.h"

static void
close_button_clicked_handler(GtkButton *button, gpointer userdata)
{
    GTKWindowViewController *window = (__bridge GTKWindowViewController *)(userdata);

    OFTimer *timer = [OFTimer
        timerWithTimeInterval: 0
        repeats: false
        block: ^ (OFTimer *timer) {
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
        }];

    [[OFRunLoop mainRunLoop] addTimer: timer];
}

static void
minimize_button_clicked_handler(GtkButton *button, gpointer userdata)
{
    GTKWindowViewController *window = (__bridge GTKWindowViewController *)(userdata);

    OFTimer *timer = [OFTimer
        timerWithTimeInterval: 0
        repeats: false
        block: ^ (OFTimer *timer) {

            if ([window.delegate respondsToSelector: @selector(windowShouldMinimize)]) {
                if (![window.delegate windowShouldMinimize]) {
                    return;
                }
            }

            if ([window.delegate respondsToSelector: @selector(windowWillMinimize)]) {
                [window.delegate windowWillMinimize];
            }

            [window minimize];

            if ([window.delegate respondsToSelector: @selector(windowDidMinimize)]) {
                [window.delegate windowDidMinimize];
            }
        }];

    [[OFRunLoop mainRunLoop] addTimer: timer];
}

static void
maximize_button_clicked_handler(GtkButton *button, gpointer userdata)
{
    GTKWindowViewController *window = (__bridge GTKWindowViewController *)(userdata);

    OFTimer *timer = [OFTimer
        timerWithTimeInterval: 0
        repeats: false
        block: ^ (OFTimer *timer) {

            if ([window.delegate respondsToSelector: @selector(windowShouldMaximize)]) {
                if (![window.delegate windowShouldMaximize]) {
                    return;
                }
            }

            if ([window.delegate respondsToSelector: @selector(windowWillMaximize)]) {
                [window.delegate windowWillMaximize];
            }

            [window maximize];

            if ([window.delegate respondsToSelector: @selector(windowDidMaximize)]) {
                [window.delegate windowDidMaximize];
            }
        }];

    [[OFRunLoop mainRunLoop] addTimer: timer];
}

static void
menu_button_clicked_handler(GtkButton *button, gpointer userdata)
{

}

@interface GTKWindowViewController ()
- (void)updateHeaderbarSeparatorVisibility;
@end

@implementation GTKWindowViewController
- init
{
    self = [super init];

    self.firstResponder = self;

    [GTKApp.dispatch.gtk sync: ^{

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
        gtk_header_bar_set_decoration_layout(
            GTK_HEADER_BAR(_headerBar),
            ":");
        _closeButton = gtk_button_new_from_icon_name(
            "window-close-symbolic",
            GTK_ICON_SIZE_BUTTON);

        gtk_widget_show(_closeButton);

        gtk_header_bar_pack_end(
            GTK_HEADER_BAR(_headerBar),
            _closeButton);

        gtk_button_set_relief(GTK_BUTTON(_closeButton), GTK_RELIEF_NONE);

		_closeButtonClickedHandlerID = g_signal_connect(
			G_OBJECT(_closeButton),
			"clicked",
			G_CALLBACK(close_button_clicked_handler),
			(__bridge gpointer)(self));

        _minimizeButton = gtk_button_new_from_icon_name(
            "zoom-out-symbolic",
            GTK_ICON_SIZE_BUTTON);

        gtk_widget_show(_minimizeButton);

        gtk_header_bar_pack_end(
            GTK_HEADER_BAR(_headerBar),
            _minimizeButton);

        gtk_button_set_relief(GTK_BUTTON(_minimizeButton), GTK_RELIEF_NONE);

		_minimizeButtonClickedHandlerID = g_signal_connect(
			G_OBJECT(_minimizeButton),
			"clicked",
			G_CALLBACK(minimize_button_clicked_handler),
			(__bridge gpointer)(self));

        _maximizeButton = gtk_button_new_from_icon_name(
            "zoom-in-symbolic",
            GTK_ICON_SIZE_BUTTON);

        gtk_widget_show(_maximizeButton);

        gtk_header_bar_pack_end(
            GTK_HEADER_BAR(_headerBar),
            _maximizeButton);

        gtk_button_set_relief(GTK_BUTTON(_maximizeButton), GTK_RELIEF_NONE);

		_maximizeButtonClickedHandlerID = g_signal_connect(
			G_OBJECT(_maximizeButton),
			"clicked",
			G_CALLBACK(maximize_button_clicked_handler),
			(__bridge gpointer)(self));

        _headerBarRightSeparator = gtk_separator_new(GTK_ORIENTATION_VERTICAL);
        gtk_widget_show(_headerBarRightSeparator);
        gtk_header_bar_pack_end(
            GTK_HEADER_BAR(_headerBar),
            _headerBarRightSeparator);

        _menuButton = gtk_button_new_from_icon_name(
            "open-menu-symbolic",
            GTK_ICON_SIZE_BUTTON);

        gtk_widget_show(_menuButton);

        gtk_header_bar_pack_start(
            GTK_HEADER_BAR(_headerBar),
            _menuButton);

        gtk_button_set_relief(GTK_BUTTON(_menuButton), GTK_RELIEF_NONE);

		_menuButtonClickedHandlerID = g_signal_connect(
			G_OBJECT(_menuButton),
			"clicked",
			G_CALLBACK(menu_button_clicked_handler),
			(__bridge gpointer)(self));

        _headerBarLeftSeparator = gtk_separator_new(GTK_ORIENTATION_VERTICAL);
        gtk_widget_show(_headerBarLeftSeparator);
        gtk_header_bar_pack_start(
            GTK_HEADER_BAR(_headerBar),
            _headerBarLeftSeparator);
    }];

    self.closeButtonHidden = false;
    self.minimizeButtonHidden = true;
    self.maximizeButtonHidden = true;
    self.menuButtonHidden = true;
    self.hidden = true;

    return self;
}

- (void)dealloc
{
    [GTKApp.dispatch.gtk sync: ^{
        gtk_widget_destroy(_window);
    }];
}

- (bool)isHidden
{
    __block bool hidden;
    [GTKApp.dispatch.gtk sync: ^{
        hidden = !gtk_widget_get_visible(_window);
    }];
    return hidden;
}

- (void)setHidden:(bool)hidden
{
    [GTKApp.dispatch.gtk sync: ^{
        gtk_widget_set_visible(_window, !hidden);
    }];
}

- (GTKRect)frame
{
    __block GTKRect frame;
    [GTKApp.dispatch.gtk sync: ^{
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
    [GTKApp.dispatch.gtk sync: ^{
        gtk_window_resize(GTK_WINDOW(_window), frame.width, frame.height);
        gtk_window_move(GTK_WINDOW(_window), frame.x, frame.y);
    }];
}

- (void)close
{
    self.hidden = true;
}

- (void)setTitleVisible:(bool)visible
{
    [GTKApp.dispatch.gtk sync: ^{
        gtk_window_set_decorated(GTK_WINDOW(_window), visible);
    }];
}

- (bool)titleVisible
{
    __block bool visible;
    [GTKApp.dispatch.gtk sync: ^{
        visible = gtk_window_get_decorated(GTK_WINDOW(_window));
    }];
    return visible;
}

- (void)setResizable:(bool)resizable
{
    [GTKApp.dispatch.gtk sync: ^{
        gtk_window_set_resizable(GTK_WINDOW(_window), resizable);
    }];
}

- (bool)isResizable
{
    __block bool resizable;
    [GTKApp.dispatch.gtk sync: ^{
        resizable = gtk_window_get_resizable(GTK_WINDOW(_window));
    }];
    return resizable;
}

- (bool)hasToplevelFocus
{
    __block bool hasToplevelFocus;
    [GTKApp.dispatch.gtk sync: ^{
        hasToplevelFocus = gtk_window_has_toplevel_focus(GTK_WINDOW(_window));
    }];
    return hasToplevelFocus;
}

- (OFString *)title
{
    __block OFString *title;
    [GTKApp.dispatch.gtk sync: ^{
        const char *str = gtk_header_bar_get_title(GTK_HEADER_BAR(_headerBar));
        title = [OFString stringWithUTF8String: str];
    }];
    return title;
}

- (void)setTitle:(OFString *)title
{
    [GTKApp.dispatch.gtk sync: ^{
        gtk_header_bar_set_title(
            GTK_HEADER_BAR(_headerBar),
            title.UTF8String);
    }];
}

- (OFString *)subtitle
{
    __block OFString *subtitle;
    [GTKApp.dispatch.gtk sync: ^{
        const char *str = gtk_header_bar_get_subtitle(GTK_HEADER_BAR(_headerBar));
        subtitle = [OFString stringWithUTF8String: str];
    }];
    return subtitle;
}

- (void)setSubtitle:(OFString *)subtitle
{
    [GTKApp.dispatch.gtk sync: ^{
        gtk_header_bar_set_subtitle(
            GTK_HEADER_BAR(_headerBar),
            subtitle.UTF8String);
    }];
}

- (double)alpha
{
    __block double alpha;
    [GTKApp.dispatch.gtk sync: ^{
        alpha = gtk_widget_get_opacity(_window);
    }];
    return alpha;
}

- (void)setAlpha:(double)alpha
{
    [GTKApp.dispatch.gtk sync: ^{
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

- (void)minimize
{
    [GTKApp.dispatch.gtk sync: ^{
        gtk_window_iconify(GTK_WINDOW(_window));
    }];
}

- (void)maximize
{
    [GTKApp.dispatch.gtk sync: ^{
        gtk_window_maximize(GTK_WINDOW(_window));
    }];
}

- (bool)isCloseButtonHidden
{
    __block bool hidden;
    [GTKApp.dispatch.gtk sync: ^{
        hidden = gtk_widget_get_visible(_closeButton);
    }];
    return hidden;
}

- (void)setCloseButtonHidden:(bool)hidden
{
    [GTKApp.dispatch.gtk sync: ^{
        gtk_widget_set_visible(_closeButton, !hidden);
    }];
    [self updateHeaderbarSeparatorVisibility];
}

- (bool)isMinimizeButtonHidden
{
    __block bool hidden;
    [GTKApp.dispatch.gtk sync: ^{
        hidden = gtk_widget_get_visible(_minimizeButton);
    }];
    return hidden;
}

- (void)setMinimizeButtonHidden:(bool)hidden
{
    [GTKApp.dispatch.gtk sync: ^{
        gtk_widget_set_visible(_minimizeButton, !hidden);
    }];
    [self updateHeaderbarSeparatorVisibility];
}

- (bool)isMaximizeButtonHidden
{
    __block bool hidden;
    [GTKApp.dispatch.gtk sync: ^{
        hidden = gtk_widget_get_visible(_maximizeButton);
    }];
    return hidden;
}

- (void)setMaximizeButtonHidden:(bool)hidden
{
    [GTKApp.dispatch.gtk sync: ^{
        gtk_widget_set_visible(_maximizeButton, !hidden);
    }];
    [self updateHeaderbarSeparatorVisibility];
}

- (bool)isMenuButtonHidden
{
    __block bool hidden;
    [GTKApp.dispatch.gtk sync: ^{
        hidden = gtk_widget_get_visible(_menuButton);
    }];
    return hidden;
}

- (void)setMenuButtonHidden:(bool)hidden
{
    [GTKApp.dispatch.gtk sync: ^{
        gtk_widget_set_visible(_menuButton, !hidden);
    }];
    [self updateHeaderbarSeparatorVisibility];
}

- (void)updateHeaderbarSeparatorVisibility
{
    [GTKApp.dispatch.gtk sync: ^{
        if (!gtk_widget_get_visible(_minimizeButton) &&
            !gtk_widget_get_visible(_maximizeButton) &&
            !gtk_widget_get_visible(_closeButton)) {
            gtk_widget_set_visible(_headerBarRightSeparator, false);
        } else {
            gtk_widget_set_visible(_headerBarRightSeparator, true);
        }
        if (!gtk_widget_get_visible(_menuButton)) {
            gtk_widget_set_visible(_headerBarLeftSeparator, false);
        } else {
            gtk_widget_set_visible(_headerBarLeftSeparator, true);
        }
    }];
}
@end
