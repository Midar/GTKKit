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

#import "MainWindow.h"

@implementation MainWindow
- init
{
    self = [super init];

    GTKRect frame = self.frame;
    frame.x = 50;
    frame.y = 200;
    frame.width = 500;
    frame.height = 400;
    self.frame = frame;

    self.tabs = [GTKTabbedView new];
    [self.tabs.constraints fixedToTop: 5
                                            bottom: 5
                                              left: 5
                                             right: 5];
    [self.tabs.constraints flexibleWidth: 0];
    [self.tabs.constraints flexibleHeight: 0];

    [self addView: self.tabs];

    [self.tabs addTabTitled: @"Tab One"];
    [self.tabs addTabTitled: @"Tab Two"];
    [self.tabs addTabTitled: @"Tab Three"];

    GTKTextField *label1 = [GTKTextField new];
    label1.stringValue = @"Tab One";
    [self.tabs addView: label1 toTabTitled: @"Tab One"];

    GTKTextField *label2 = [GTKTextField new];
    label2.stringValue = @"Tab Two";
    [self.tabs addView: label2 toTabTitled: @"Tab Two"];

    GTKTextField *label3 = [GTKTextField new];
    label3.stringValue = @"Tab Three";
    [self.tabs addView: label3 toTabTitled: @"Tab Three"];

    self.title = @"Tabbed View Controller";

    return self;
}
@end
