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
    frame.width = 700;
    frame.height = 500;
    self.frame = frame;

    self.tabView = [GTKTabView new];
    [self addView: self.tabView];
    [self.tabView.constraints fixedToTop: 10
                                  bottom: 10
                                    left: 10
                                   right: 10];

    self.tab1 = [GTKTab new];
    self.tab1.label = @"Tab One";
    [self.tabView addTab: self.tab1];

    self.tab2 = [GTKTab new];
    self.tab2.label = @"Tab Two";
    [self.tabView addTab: self.tab2];

    self.tab3 = [GTKTab new];
    self.tab3.label = @"Tab Three";
    [self.tabView addTab: self.tab3];

    self.tab4 = [GTKTab new];
    self.tab4.label = @"Tab Four";
    [self.tabView addTab: self.tab4];

    self.label1 = [GTKTextField new];
    self.label1.stringValue = @"Tab One";
    [self.tab1.contentView addSubview: self.label1];

    self.label2 = [GTKTextField new];
    self.label2.stringValue = @"Tab Two";
    [self.tab2.contentView addSubview: self.label2];

    self.label3 = [GTKTextField new];
    self.label3.stringValue = @"Tab Three";
    [self.tab3.contentView addSubview: self.label3];

    self.label4 = [GTKTextField new];
    self.label4.stringValue = @"Tab Four";
    [self.tab4.contentView addSubview: self.label4];

    self.title = @"Tab View";

    return self;
}
@end
