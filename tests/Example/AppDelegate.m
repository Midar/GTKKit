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

    GTKView *testView = [GTKView new];
    testView.constraints.top.value = 10;
    testView.constraints.bottom.value = 10;
    testView.constraints.left.value = 10;
    testView.constraints.right.value = 10;
    testView.constraints.horizontal.value = 0;
    testView.constraints.vertical.value = 0;
    testView.constraints.horizontal.type = GTKLayoutConstraintTypeFlexible;
    testView.constraints.vertical.type = GTKLayoutConstraintTypeFlexible;

    [self.window addSubview: testView];

    GTKView *subview = [GTKView new];
    subview.constraints.top.value = 20;
    subview.constraints.bottom.value = 0;
    subview.constraints.left.value = 10;
    subview.constraints.right.value = 10;
    subview.constraints.horizontal.value = 0;
    subview.constraints.vertical.value = 30;
    subview.constraints.horizontal.type = GTKLayoutConstraintTypeFlexible;
    subview.constraints.vertical.type = GTKLayoutConstraintTypeFlexible;
    subview.constraints.bottom.type = GTKLayoutConstraintTypeFlexible;

    [testView addSubview: subview];

    self.window.hidden = false;

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
