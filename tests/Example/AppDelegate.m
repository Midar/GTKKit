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

    GTKButton *button = [GTKButton new];
    [button.constraints flexibleToTop: 0
                                 left: 0
                                right: 0];
    [button.constraints fixedToBottom: 10];
    button.constraints.centerHorizontal = true;
    [button.constraints fixedWidth: 100];
    [button.constraints fixedHeight: 30];
    button.stringValue = @"Click me!";
    button.target = self;
    button.action = @selector(clicked:);

    [self.window addSubview: button];

    self.window.title = @"Example Window";
    self.window.subtitle = @"Example Subtitle";
    self.window.hidden = false;

    // It would be dangerous to modify anything below this line.
    return self;
}

- (void)applicationDidFinishLaunching
{
    [super applicationDidFinishLaunching];
    // Put your custom post-launch startup code below this line.
}

- (void)clicked:(GTKButton *)sender
{
    printf("Clicked!\n");
}
@end
