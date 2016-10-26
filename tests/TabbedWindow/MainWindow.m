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

    [self addTabTitled: @"Tabbed Window View Controller"];
    [self addTabTitled: @"Tab Two"];
    [self addTabTitled: @"Tab Three"];
    [self addTabTitled: @"Tab Four"];

    GTKTextField *label1 = [GTKTextField new];
    label1.stringValue = @"Tab One";
    [self addView: label1 toTabTitled: @"Tabbed Window View Controller"];

    GTKTextField *label2 = [GTKTextField new];
    label2.stringValue = @"Tab Two";
    [self addView: label2 toTabTitled: @"Tab Two"];

    GTKTextField *label3 = [GTKTextField new];
    label3.stringValue = @"Tab Three";
    [self addView: label3 toTabTitled: @"Tab Three"];

    GTKTextField *label4 = [GTKTextField new];
    label4.stringValue = @"Tab Four";
    [self addView: label4 toTabTitled: @"Tab Four"];

    return self;
}
@end
