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
    // Put your custom initialization below this line.
    self.window = [GTKWindowViewController new];

    GTKRect frame = self.window.frame;
    frame.x = 50;
    frame.y = 200;
    frame.width = 300;
    frame.height = 500;
    self.window.frame = frame;

    GTKView *testView = [GTKView new];
    [testView.constraints fixedToTop: 10
                              bottom: 10
                                left: 10
                               right: 10];
    [testView.constraints flexibleHorizontal: 0];
    [testView.constraints flexibleVertical: 0];

    [self.window addSubview: testView];

    GTKView *subview = [GTKView new];
    [subview.constraints fixedToTop: 10
                               left: 10
                              right: 10];
    [subview.constraints flexibleToBottom: 50];
    [subview.constraints flexibleHorizontal: 0];
    [subview.constraints flexibleVertical: 0];

    [testView addSubview: subview];

    self.window.hidden = false;

    // It would be dangerous to modify anything below this line.
    return self;
}

- (void)applicationDidFinishLaunching
{
    [super applicationDidFinishLaunching];
    // Put your custom post-launch startup code below this line.
}
@end
