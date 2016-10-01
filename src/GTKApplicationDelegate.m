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

static int *argc;
static char ***argv;

static gboolean
gtkkit_gtk_main_quit(gpointer userdata)
{
    gtk_main_quit();
    return false;
}

@implementation GTKApplicationDelegate
- init
{
    self = [super init];
    [self startGTKThread];
    return self;
}

- (void)applicationDidFinishLaunching
{
    return;
}

- (void)applicationWillTerminate
{
    gdk_threads_add_idle(gtkkit_gtk_main_quit, NULL);
}

- (void)startGTKThread
{
    [[OFThread threadWithThreadBlock: ^id _Nullable (void){
        [OFApplication.sharedApplication getArgumentCount: &argc
                                        andArgumentValues: &argv];
        gtk_init(argc, argv);
        gtk_main();
        return nil;
    }] start];
}
@end
