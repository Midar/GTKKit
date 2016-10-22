/*! @file GTKBox.h
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

#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>

#import "GTKApplication.h"
#import "GTKApplicationDelegate.h"
#import "GTKCallback.h"

static GTKApplication *_sharedApplication;

static void
get_toplevel_window(gpointer data, gpointer userdata)
{
    GtkWindow *window = (GtkWindow *)(data);

    if (gtk_window_has_toplevel_focus(window)) {
        userdata = (gpointer)(window);
    }
};

static void
gtkkit_application_main(GTKApplication *app)
{
    of_application_main(app.argc, app.argv, [app.delegateClass class]);
}

@implementation GTKApplication
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

+ (instancetype)sharedApplication
{
    if (nil == _sharedApplication) {
        _sharedApplication = [self new];
    }
    return _sharedApplication;
}

- (void)terminate
{
    if ([self.delegate respondsToSelector: @selector(applicationShouldTerminate)]) {
        if (![self.delegate applicationShouldTerminate]) {
            return;
        }
    }
    [OFApplication terminate];
}

+ (void)terminate
{
    [self.sharedApplication terminate];
}

- (void)startup
{
    gtkkit_gtk_thread = of_thread_current();
    gtk_init(self.argc, self.argv);
	self.delegate =
		(id<GTKApplicationDelegate>)(OFApplication.sharedApplication.delegate);
    if ([self.delegate respondsToSelector: @selector(applicationWillFinishLaunching)]) {
        [self.delegate applicationWillFinishLaunching];
    }
    of_thread_new(
        &gtkkit_objfw_thread,
        &gtkkit_application_main,
        self,
        &gtkkit_objfw_thread_attr);
}

+ (void)startup
{
    [self.sharedApplication startup];
}

- (void)run
{
    gtk_main();
}

+ (void)run
{
    [self.sharedApplication run];
}
@end
