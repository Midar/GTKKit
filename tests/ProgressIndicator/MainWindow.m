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
    frame.height = 200;
    self.frame = frame;

    self.progress = [GTKProgressIndicator new];
    [self.progress.constraints flexibleToTop: 0
                                      bottom: 0];
    [self.progress.constraints fixedToLeft: 10
                                     right: 10];
    self.progress.constraints.centerVertical = true;
    [self.progress.constraints fixedHeight: 20];
    [self addView: self.progress];

    self.button = [GTKButton new];
    self.button.stringValue = @"Toggle Animation";
    [self.button.constraints fixedToTop: 10];
    [self.button.constraints flexibleToBottom: 0
                                         left: 0
                                        right: 0];
    [self.button.constraints fixedHeight: 30];
    [self.button.constraints fixedWidth: 150];
    self.button.constraints.centerHorizontal = true;
    __weak MainWindow *weakSelf = self;
    [self addView: self.button];
    self.button.actionBlock = ^{
        weakSelf.progress.animate = !weakSelf.progress.animate;
    };

    self.title = @"Progress Indicator";

    return self;
}
@end
