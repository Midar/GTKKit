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

#import "GTKKit.h"
#import "AppDelegate.h"

OF_APPLICATION_DELEGATE(AppDelegate)

@implementation AppDelegate
- init
{
    self = [super init];

    self.window = [GTKWindow new];
    self.window.size = of_dimension(300,200);
    self.window.title = @"Hello, world!";
    self.window.delegate = self;

    self.button = [GTKButton buttonWithLabel: @"Click me!"];
    self.button.target = self;
    self.button.action = @selector(buttonClicked:);

    [self.window addWidget: self.button];

    return self;
}

- (void)applicationDidFinishLaunching
{
    [self.window showAll];

    // All customization should go above this line.
    [super applicationDidFinishLaunching];
}

- (void)buttonClicked:(id)sender
{
    printf("Hello, world!\n");
}

- (void)windowWillClose:(GTKWindow *)sender
{
    [OFApplication terminate];
}

@end
