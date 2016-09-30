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
    self.window.size = of_dimension(500,400);

    self.window.delegate = self;

    self.window.title = @"Hello, World!";

    self.textView = [GTKTextView new];
    self.textView.buffer.stringValue = @"Hello, world. This is some example text.";
    self.textView.paddingTop = 5;
    self.textView.paddingBottom = 5;
    self.textView.paddingLeft = 5;
    self.textView.paddingRight = 5;

    [self.window addWidget: self.textView];

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
@end
