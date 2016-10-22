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

    __weak typeof(self) weakSelf = self;
    self.window.slider.actionBlock = ^{
        weakSelf.window.label.alpha = weakSelf.window.slider.doubleValue;
    };

    self.window.toggleEditableButton.target = self;
    self.window.toggleEditableButton.action = @selector(toggleEditableButtonClicked:);

    self.window.toggleMultilineButton.target = self;
    self.window.toggleMultilineButton.action = @selector(toggleMultilineButtonClicked:);

    // It would be dangerous to modify anything below this line.

    return self;
}

- (void)applicationDidFinishLaunching
{
    // Put your custom post-launch startup code below this line.
    self.window.hidden = false;
    printf("Hello!\n");
}

- (void)applicationWillTerminate
{
    printf("Goodbye!\n");
}

- (void)toggleEditableButtonClicked:(GTKButton *)sender
{
    self.window.label.editable = !self.window.label.editable;
}

- (void)toggleMultilineButtonClicked:(GTKButton *)sender
{
    self.window.label.multiline = !self.window.label.multiline;
}

- (void)windowDidClose
{
    [GTKApplication terminate];
}
@end
