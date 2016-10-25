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

    self.window = [MainWindow new];
    self.window.delegate = self;

    // It would be dangerous to modify anything below this line.

    return self;
}

- (void)applicationDidFinishLaunching
{
    // Put your custom post-launch startup code below this line.
    self.window.hidden = false;

    self.window.split.dividerPosition = 0.3;
}

- (void)windowDidClose
{
    [GTKApp terminate];
}
@end
