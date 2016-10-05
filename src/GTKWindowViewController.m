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

/*!
 * @brief A class representing a view controller that manages a toplevel
 * window and its view hierarchy.
 */
@implementation GTKWindowViewController: GTKViewController
- init
{
    self = [super init];

    self.contentView = [GTKView new];

    GTKCallback(^{
        self.window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
        g_object_ref_sink(G_OBJECT(self.window));
        gtk_widget_set_size_request(self.window, 1, 1);
        gtk_window_set_default_size(GTK_WINDOW(self.window), 100, 100);

        gtk_container_add(GTK_CONTAINER(self.window), self.contentView.overlayWidget);

    });

    self.hidden = true;

    return self;
}

- (void)dealloc
{
    GTKCallback(^{
        gtk_widget_destroy(self.window);
    });
}

- (bool)isHidden
{
    __block bool hidden;
    GTKCallback(^{
        hidden = !gtk_widget_get_visible(self.window);
    });
    return hidden;
}

- (void)setHidden:(bool)hidden
{
    GTKCallback(^{
        gtk_widget_set_visible(self.window, !hidden);
    });
}

- (GTKRect)frame
{
    __block GTKRect frame;
    GTKCallback(^{
        gtk_window_get_size(
            GTK_WINDOW(self.window),
            &frame.width,
            &frame.height);
        gtk_window_get_position(
            GTK_WINDOW(self.window),
            &frame.x,
            &frame.y);
    });
    return frame;
}

- (void)setFrame:(GTKRect)frame
{
    GTKCallback(^{
        gtk_window_resize(GTK_WINDOW(self.window), frame.width, frame.height);
        gtk_window_move(GTK_WINDOW(self.window), frame.x, frame.y);
    });
}

- (void)addSubview:(nonnull GTKView *)subview
{
    [self.contentView addSubview: subview];
}

- (void)close
{
    self.hidden = true;
}
@end
