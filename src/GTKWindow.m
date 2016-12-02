/*! @file GTKWindow.m
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

#import "GTKWindow.h"
#import "GTKApplicationDelegate.h"
#import "GTKWindowDelegate.h"
#import "GTKApplication.h"
#import "GTKKeyedArchiver.h"
#import "GTKKeyedUnarchiver.h"
#import "OFArray+GTKCoding.h"

static void
close_button_clicked_handler(GtkButton *button, GTKWindow *window)
{
    [GTKApp.dispatch.main async: ^{
        if ([window.delegate respondsToSelector: @selector(windowShouldClose)]) {
            if (![window.delegate windowShouldClose]) {
                return;
            }
        }

        if ([window.delegate respondsToSelector: @selector(windowWillClose)]) {
            [window.delegate windowWillClose];
        }

        if (window.destroyWhenClosed) {
            [window destroy];
        } else {
            window.hidden = true;
        }

        if ([window.delegate respondsToSelector: @selector(windowDidClose)]) {
            [window.delegate windowDidClose];
        }
    }];
}

static void
minimize_button_clicked_handler(GtkButton *button, GTKWindow *window)
{
    [GTKApp.dispatch.main async: ^{
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
}

static void
maximize_button_clicked_handler(GtkButton *button, GTKWindow *window)
{
    [GTKApp.dispatch.main async: ^{
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
}

static void
menu_button_clicked_handler(GtkButton *button, GTKWindow *window)
{
    window.menuButtonPopOver.hidden = false;
}

static void
gesture_drag_begin_handler(GtkGestureDrag *gesture, gdouble start_x, gdouble start_y, GTKView *view)
{

}

static void
gesture_drag_update_handler(GtkGestureDrag *gesture, gdouble offset_x, gdouble offset_y, GTKView *view)
{
    GTKEvent *event = [GTKEvent new];

    event.type = GTKEventTypeMouseDragged;
    event.mouseButton = 1;

    double x, y;

    gtk_gesture_drag_get_start_point(gesture, &x, &y);
    event.originX = x;
    event.originY = y;

    gtk_gesture_drag_get_offset(gesture, &x, &y);
    event.deltaX = x;
    event.deltaY = y;

    event.mouseX = event.originX + event.deltaX;
    event.mouseY = event.originY + event.deltaY;

    [view mouseDragged: event];
}

static void
gesture_drag_end_handler(GtkGestureDrag *gesture, gdouble offset_x, gdouble offset_y, GTKView *view)
{

}

@interface GTKWindow ()
- (void)updateHeaderbarSeparatorVisibility;
@end

@implementation GTKWindow
- init
{
    self = [super init];

    self.contentView = [GTKView new];
    self.contentView.nextResponder = self;
    self.nextResponder = GTKApp;

    self.firstResponder = self;
    self.destroyWhenClosed = false;

    _headerBarStartViews = [OFMutableArray new];
    _headerBarEndViews = [OFMutableArray new];

    [GTKApp.dispatch.gtk sync: ^{
        _window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
        g_object_ref_sink(G_OBJECT(_window));
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


        _headerBar = gtk_header_bar_new();
        g_object_ref_sink(G_OBJECT(_headerBar));
        gtk_widget_show(_headerBar);

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
        g_object_ref_sink(_closeButton);
        gtk_widget_show(_closeButton);

        gtk_header_bar_pack_end(
            GTK_HEADER_BAR(_headerBar),
            _closeButton);

        gtk_button_set_relief(GTK_BUTTON(_closeButton), GTK_RELIEF_NONE);

		g_signal_connect(
			G_OBJECT(_closeButton),
			"clicked",
			G_CALLBACK(close_button_clicked_handler),
			(__bridge gpointer)(self));

        _minimizeButton = gtk_button_new_from_icon_name(
            "zoom-out-symbolic",
            GTK_ICON_SIZE_BUTTON);
        g_object_ref_sink(_minimizeButton);
        gtk_widget_show(_minimizeButton);

        gtk_header_bar_pack_end(
            GTK_HEADER_BAR(_headerBar),
            _minimizeButton);

        gtk_button_set_relief(GTK_BUTTON(_minimizeButton), GTK_RELIEF_NONE);

		g_signal_connect(
			G_OBJECT(_minimizeButton),
			"clicked",
			G_CALLBACK(minimize_button_clicked_handler),
			(__bridge gpointer)(self));

        _maximizeButton = gtk_button_new_from_icon_name(
            "zoom-in-symbolic",
            GTK_ICON_SIZE_BUTTON);
        g_object_ref_sink(_maximizeButton);

        gtk_widget_show(_maximizeButton);

        gtk_header_bar_pack_end(
            GTK_HEADER_BAR(_headerBar),
            _maximizeButton);

        gtk_button_set_relief(GTK_BUTTON(_maximizeButton), GTK_RELIEF_NONE);

		g_signal_connect(
			G_OBJECT(_maximizeButton),
			"clicked",
			G_CALLBACK(maximize_button_clicked_handler),
			(__bridge gpointer)(self));

        _headerBarRightSeparator = gtk_separator_new(GTK_ORIENTATION_VERTICAL);
        g_object_ref_sink(_headerBarRightSeparator);
        gtk_widget_show(_headerBarRightSeparator);
        gtk_header_bar_pack_end(
            GTK_HEADER_BAR(_headerBar),
            _headerBarRightSeparator);

        _menuButton = gtk_button_new_from_icon_name(
            "open-menu-symbolic",
            GTK_ICON_SIZE_BUTTON);
        g_object_ref_sink(_menuButton);

        gtk_widget_show(_menuButton);

        gtk_header_bar_pack_start(
            GTK_HEADER_BAR(_headerBar),
            _menuButton);

        gtk_button_set_relief(GTK_BUTTON(_menuButton), GTK_RELIEF_NONE);

		g_signal_connect(
			G_OBJECT(_menuButton),
			"clicked",
			G_CALLBACK(menu_button_clicked_handler),
			(__bridge gpointer)(self));

        _headerBarLeftSeparator = gtk_separator_new(GTK_ORIENTATION_VERTICAL);
        g_object_ref_sink(_headerBarLeftSeparator);
        gtk_widget_show(_headerBarLeftSeparator);
        gtk_header_bar_pack_start(
            GTK_HEADER_BAR(_headerBar),
            _headerBarLeftSeparator);

        GtkGesture *gesture = gtk_gesture_drag_new(_window);

        g_signal_connect(
            gesture,
            "drag-begin",
            G_CALLBACK(gesture_drag_begin_handler),
            (__bridge gpointer)(self));

        g_signal_connect(
            gesture,
            "drag-update",
            G_CALLBACK(gesture_drag_update_handler),
            (__bridge gpointer)(self));

        g_signal_connect(
            gesture,
            "drag-end",
            G_CALLBACK(gesture_drag_end_handler),
            (__bridge gpointer)(self));
    }];

    self.closeButtonHidden = false;
    self.minimizeButtonHidden = true;
    self.maximizeButtonHidden = true;
    self.menuButtonHidden = true;
    self.hidden = true;

    self.menuButtonPopOver = [GTKPopover new];
    self.menuButtonPopOver.relativeWidget = _menuButton;

    [GTKApp.windows addObject: self];

    return self;
}

- (instancetype)initWithCoder:(GTKKeyedUnarchiver *)decoder
{
	self = [self init];
    self.contentView = [decoder decodeObjectForKey: @"GTKKit.coding.window.contentView"];
    self.frame = [decoder decodeRectForKey: @"GTKKit.coding.window.contentView"];
    self.title = [decoder decodeStringForKey: @"GTKKit.coding.window.title"];
    self.title = [decoder decodeStringForKey: @"GTKKit.coding.window.subtitle"];
    self.closeButtonHidden = [decoder decodeBoolForKey: @"GTKKit.coding.window.closeButtonHidden"];
    self.minimizeButtonHidden = [decoder decodeBoolForKey: @"GTKKit.coding.window.minimizeButtonHidden"];
    self.maximizeButtonHidden = [decoder decodeBoolForKey: @"GTKKit.coding.window.maximizeButtonHidden"];
    self.menuButtonHidden = [decoder decodeBoolForKey: @"GTKKit.coding.window.menuButtonHidden"];
    self.hidden = [decoder decodeBoolForKey: @"GTKKit.coding.window.hidden"];
    self.titleVisible = [decoder decodeBoolForKey: @"GTKKit.coding.window.titleVisible"];
    self.alpha = [decoder decodeDoubleForKey: @"GTKKit.coding.window.alpha"];
    self.resizable = [decoder decodeBoolForKey: @"GTKKit.coding.window.resizable"];
    self.destroyWhenClosed = [decoder decodeBoolForKey: @"GTKKit.coding.window.destroyWhenClosed"];
    for (GTKView *view in [decoder decodeObjectForKey: @"GTKKit.coding.window.headerBarStartViews"]) {
        [self addViewToHeaderBarStart: view];
    }
    for (GTKView *view in [decoder decodeObjectForKey: @"GTKKit.coding.window.headerBarEndViews"]) {
        [self addViewToHeaderBarEnd: view];
    }
    self.menuButtonPopOver = [decoder decodeObjectForKey: @"GTKKit.coding.window.menuButtonPopOver"];
    return self;
}

- (void)encodeWithCoder:(GTKKeyedArchiver *)encoder
{
    [encoder encodeObject: self.contentView forKey: @"GTKKit.coding.window.contentView"];
    [encoder encodeRect: self.frame forKey: @"GTKKit.coding.window.frame"];
    [encoder encodeString: self.title forKey: @"GTKKit.coding.window.title"];
    [encoder encodeString: self.title forKey: @"GTKKit.coding.window.subtitle"];
    [encoder encodeBool: self.isCloseButtonHidden forKey: @"GTKKit.coding.window.closeButtonHidden"];
    [encoder encodeBool: self.isMinimizeButtonHidden forKey: @"GTKKit.coding.window.minimizeButtonHidden"];
    [encoder encodeBool: self.isMaximizeButtonHidden forKey: @"GTKKit.coding.window.maximizeButtonHidden"];
    [encoder encodeBool: self.isMenuButtonHidden forKey: @"GTKKit.coding.window.menuButtonHidden"];
    [encoder encodeBool: self.isHidden forKey: @"GTKKit.coding.window.hidden"];
    [encoder encodeBool: self.titleVisible forKey: @"GTKKit.coding.window.titleVisible"];
    [encoder encodeDouble: self.titleVisible forKey: @"GTKKit.coding.window.alpha"];
    [encoder encodeBool: self.isResizable forKey: @"GTKKit.coding.window.resizable"];
    [encoder encodeBool: self.destroyWhenClosed forKey: @"GTKKit.coding.window.destroyWhenClosed"];
    [encoder encodeObject: self.titleView forKey: @"GTKKit.coding.window.titleView"];
    [encoder encodeObject: _headerBarStartViews forKey: @"GTKKit.coding.window.headerBarStartViews"];
    [encoder encodeObject: _headerBarEndViews forKey: @"GTKKit.coding.window.headerBarStartViews"];
    [encoder encodeObject: self.menuButtonPopOver forKey: @"GTKKit.coding.window.menuButtonPopOver"];
}

- (void)dealloc
{
    g_object_unref(_headerBar);
    g_object_unref(_closeButton);
    g_object_unref(_minimizeButton);
    g_object_unref(_maximizeButton);
    g_object_unref(_headerBarRightSeparator);
    g_object_unref(_menuButton);
    g_object_unref(_headerBarLeftSeparator);
    g_object_unref(_window);
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

- (void)destroy
{
    [GTKApp.dispatch.gtk sync: ^{
        gtk_widget_destroy(_window);
    }];
    [GTKApp.windows removeObject: self];
}

- (void)addViewToHeaderBarStart:(nonnull GTKView *)view
{
    [self removeViewFromHeaderBar: view];
    [view removeFromSuperview];
    view.nextResponder = self;
    view.superview = self.contentView;
    [_headerBarStartViews addObject: view];
    [GTKApp.dispatch.gtk sync: ^{
        gtk_header_bar_pack_start(
            GTK_HEADER_BAR(_headerBar),
            view.overlayWidget);
    }];
}

- (void)addViewToHeaderBarEnd:(nonnull GTKView *)view
{
    [self removeViewFromHeaderBar: view];
    [view removeFromSuperview];
    view.nextResponder = self;
    view.superview = self.contentView;
    [_headerBarEndViews addObject: view];
    [GTKApp.dispatch.gtk sync: ^{
        gtk_header_bar_pack_end(
            GTK_HEADER_BAR(_headerBar),
            view.overlayWidget);
    }];
}

- (void)removeViewFromHeaderBar:(nonnull GTKView *)view
{
    view.nextResponder = nil;
    view.superview = nil;
    [_headerBarEndViews removeObjectIdenticalTo: view];
    [_headerBarStartViews removeObjectIdenticalTo: view];
	[GTKApp.dispatch.gtk sync: ^{
		gtk_widget_unparent(view.overlayWidget);
	}];
}

- (nullable GTKView *)titleView
{
    return _titleView;
}

- (void)setTitleView:(nullable GTKView *)view
{
    _titleView = view;
    [GTKApp.dispatch.gtk sync: ^{
        gtk_header_bar_set_custom_title(
            GTK_HEADER_BAR(_headerBar),
            view.overlayWidget);
    }];
}

- (void)addView:(nonnull GTKView *)subview
{
    [self.contentView addSubview: subview];
}

- (id)copy
{
    GTKKeyedArchiver *coder = [GTKKeyedArchiver new];
    [coder encodeObject: self forKey: @"GTKKit.copying.GTKView"];
    GTKKeyedUnarchiver *decoder = [GTKKeyedUnarchiver keyedUnarchiverWithXMLString: coder.XMLString];
    return [decoder decodeObjectForKey: @"GTKKit.copying.GTKView"];
}
@end
