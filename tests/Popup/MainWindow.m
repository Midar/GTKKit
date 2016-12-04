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

    self.popup = [GTKPopUpButton new];
    [self.popup.constraints flexibleToTop: 0
                                     left: 0];
    self.popup.constraints.centerVertical = true;
    [self.popup.constraints fixedToRight: 10];
    [self.popup.constraints fixedWidth: 200];
    [self.popup.constraints fixedHeight: 30];
    [self.popup insertItemWithTitle: @"Item One" at: 0];
    [self.popup insertItemWithTitle: @"Item Two" at: 1];
    [self.popup insertItemWithTitle: @"Item Three" at: 2];
    [self.popup selectItemAt: 0];

    self.combo = [GTKComboBox new];
    [self.combo.constraints flexibleToTop: 0
                                     right: 0];
    self.combo.constraints.centerVertical = true;
    [self.combo.constraints fixedToLeft: 10];
    [self.combo.constraints fixedWidth: 200];
    [self.combo.constraints fixedHeight: 30];
    [self.combo insertItemWithTitle: @"Item One" at: 0];
    [self.combo insertItemWithTitle: @"Item Two" at: 1];
    [self.combo insertItemWithTitle: @"Item Three" at: 2];
    [self.combo selectItemAt: 0];

    [self.contentView addSubview: self.popup];
    [self.contentView addSubview: self.combo];

    self.title = @"Combo Box and Pop-Up Button";

    return self;
}
@end
