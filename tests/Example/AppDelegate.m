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

#import "AppDelegate.h"

GTK_APPLICATION_DELEGATE(AppDelegate)

@implementation AppDelegate
- init
{
    self = [super init];
    // Put your custom initialization below this line. At this point, the GTK+
    // main loop thread is up and running. If you need to send messages or call
    // functions in that thread, surround that code with a [GTKCallback async: ^{}]
    // or [GTKCallback sync: ^{}] block.

    self.testView = [GTKView new];

    [GTKCallback sync: ^{
        self.window = gtk_window_new(GTK_WINDOW_TOPLEVEL);

        gtk_container_add(GTK_CONTAINER(self.window), self.testView.overlayWidget);
        gtk_widget_show(self.testView.overlayWidget);
        gtk_widget_show(self.window);
    }];

    self.subview = [GTKView new];
    self.subview.constraints.top.value = 10;
    self.subview.constraints.bottom.value = 10;
    self.subview.constraints.left.value = 10;
    self.subview.constraints.right.value = 10;
    self.subview.constraints.horizontal.value = 0;
    self.subview.constraints.vertical.value = 0;
    self.subview.constraints.horizontal.type = GTKLayoutConstraintTypeFlexible;
    self.subview.constraints.vertical.type = GTKLayoutConstraintTypeFlexible;

    [self.testView addSubview: self.subview];

    //[self.testView addSubview: self.subview];
    // It would be dangerous to modify anything below this line.
    return self;
}

- (void)applicationDidFinishLaunching
{
    [super applicationDidFinishLaunching];
    // Put your custom post-launch startup code below this line
}
@end
