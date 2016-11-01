/*! @file GTKOffscreenRenderingViewController.m
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

#import "GTKOffscreenRenderingViewController.h"
#import "GTKApplication.h"

@implementation GTKOffscreenRenderingViewController
- init
{
    self = [super init];
    [GTKApp.dispatch.gtk sync: ^{
        _offscreenWindow = gtk_offscreen_window_new();
        g_object_ref_sink(G_OBJECT(_offscreenWindow));
        g_object_set_data(
            G_OBJECT(_offscreenWindow),
            "_GTKKIT_OWNING_VIEW_CONTROLLER_",
            (__bridge gpointer)(self));
        gtk_widget_set_size_request(
            _offscreenWindow,
            1,
            1);
        gtk_container_add(
            GTK_CONTAINER(_offscreenWindow),
            self.contentView.overlayWidget);
    }];
    return self;
}

- (GTKImage *)image
{
    GdkPixbuf *pixbuf = gtk_offscreen_window_get_pixbuf(
        GTK_OFFSCREEN_WINDOW(_offscreenWindow));
    return [GTKImage imageWithPixbuf: pixbuf];
}
@end
