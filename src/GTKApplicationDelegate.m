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

#import "GTKApplicationDelegate.h"
#import "GTKCallback.h"

static void
get_toplevel_window(gpointer data, gpointer userdata)
{
    GtkWindow *window = (GtkWindow *)(data);

    if (gtk_window_has_toplevel_focus(window)) {
        userdata = (gpointer)(window);
    }
};

@implementation GTKApplicationDelegate
- (void)applicationDidFinishLaunching
{
    // The default implementation does nothing.
}

- (void)applicationWillTerminate
{
    gtk_main_quit();
}

- (GTKViewController*)keyWindow
{
    __block GTKViewController *viewController;
    [GTKCallback sync: ^{
        GList *windows = gtk_window_list_toplevels();

        gpointer window = NULL;

        g_list_foreach(windows, (GFunc)(get_toplevel_window), window);

        if (NULL == window) {
            viewController = nil;
            return;
        }

        viewController = (__bridge GTKViewController *)(g_object_get_data(
        		G_OBJECT(window),
                "_GTKKIT_OWNING_VIEW_CONTROLLER_"));

        g_list_free(windows);
    }];
    return viewController;
}
@end
