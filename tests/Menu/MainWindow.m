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

    self.menu = [GTKMenu new];

    GTKRect frame = self.frame;
    frame.width = 300;
    frame.height = 200;
    self.frame = frame;

    GTKMenuItem *item = [GTKMenuItem new];
    item.label = @"About Long App Name";
    [self.menu addItem: item];

    item = [GTKMenuItem separator];
    [self.menu addItem: item];

    item = [GTKMenuItem new];
    item.label = @"Quit Long App Name";
    item.target = GTKApp;
    item.action = @selector(terminate);
    [self.menu addItem: item];

    self.button = [GTKButton new];
    self.button.stringValue = @"Menu Button";
    self.button.constraints
        .fixedWidth(100)
        .fixedHeight(30)
        .centerInSuperview();
    [self.contentView addSubview: self.button];

    self.button.menu = self.menu;

    self.title = @"Menus";
    self.subtitle = @"";

    return self;
}
@end
