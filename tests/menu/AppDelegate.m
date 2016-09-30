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

    // This makes the AppDelegate also act as the GTKWindowDelegate for the window.
    self.window.delegate = self;

    self.window.title = @"Hello, World!";

    self.menu = [GTKMenu new];

    self.fooMenu = [GTKMenuItem menuItemWithLabel: @"Foo"];
    self.fooMenu.target = self;
    self.fooMenu.action = @selector(fooMenuClicked:);

    self.barMenu = [GTKMenuItem menuItemWithLabel: @"Bar"];
    self.barMenu.target = self;
    self.barMenu.action = @selector(barMenuClicked:);

    self.bazMenu = [GTKMenuItem menuItemWithLabel: @"Baz"];
    self.bazMenu.target = self;
    self.bazMenu.action = @selector(bazMenuClicked:);

    [self.menu appendMenuItem: self.fooMenu];
    [self.menu appendMenuItem: self.barMenu];
    [self.menu appendMenuItem: self.bazMenu];

    self.button = [GTKButton new];
    self.button.label = @"Click me!";
    self.button.target = self;
    self.button.action = @selector(buttonClicked:);

    [self.window addWidget: self.button];

    return self;
}

- (void)applicationDidFinishLaunching
{
    [super applicationDidFinishLaunching];

    [self.window showAll];

    gtk_main();
}

// This demonstrates the use of a GTKWindowDelegate method. This makes the
// application exit when the window is closed.

- (void)windowWillClose:(GTKWindow *)sender
{
    [OFApplication terminate];
}

- (void)buttonClicked:(GTKButton *)sender
{
    [self.menu popup];
}

- (void)fooMenuClicked:(GTKMenuItem *)sender
{
    printf("Foo Menu Item Clicked!\n");
}

- (void)barMenuClicked:(GTKMenuItem *)sender
{
    printf("Bar Menu Item Clicked!\n");
}

- (void)bazMenuClicked:(GTKMenuItem *)sender
{
    printf("Baz Menu Item Clicked!\n");
}
@end
