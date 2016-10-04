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

    self.testView = [GTKView new];
    self.testView.constraints.top.value = 10;
    self.testView.constraints.bottom.value = 10;
    self.testView.constraints.left.value = 10;
    self.testView.constraints.right.value = 10;
    self.testView.constraints.horizontal.value = 0;
    self.testView.constraints.vertical.value = 0;
    self.testView.constraints.horizontal.type = GTKLayoutConstraintTypeFlexible;
    self.testView.constraints.vertical.type = GTKLayoutConstraintTypeFlexible;

    [self.window addSubview: self.testView];

    self.subview = [GTKView new];
    self.subview.constraints.top.value = 20;
    self.subview.constraints.bottom.value = 0;
    self.subview.constraints.left.value = 10;
    self.subview.constraints.right.value = 10;
    self.subview.constraints.horizontal.value = 0;
    self.subview.constraints.vertical.value = 30;
    self.subview.constraints.horizontal.type = GTKLayoutConstraintTypeFlexible;
    self.subview.constraints.vertical.type = GTKLayoutConstraintTypeFlexible;
    self.subview.constraints.bottom.type = GTKLayoutConstraintTypeFlexible;

    [self.testView addSubview: self.subview];

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
