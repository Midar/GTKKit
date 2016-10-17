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
    frame.height = 400;
    self.window.frame = frame;

    GTKButton *button = [GTKButton new];
    [button.constraints flexibleToTop: 0
                                 left: 0
                                right: 0];
    [button.constraints fixedToBottom: 10];
    button.constraints.centerHorizontal = true;
    [button.constraints fixedWidth: 100];
    [button.constraints fixedHeight: 30];
    button.stringValue = @"Toggle editable";
    button.target = self;
    button.action = @selector(editableClicked:);

    GTKButton *button2 = [GTKButton new];
    [button2.constraints flexibleToTop: 0
                                 left: 0
                                right: 0];
    [button2.constraints fixedToBottom: 50];
    button2.constraints.centerHorizontal = true;
    [button2.constraints fixedWidth: 100];
    [button2.constraints fixedHeight: 30];
    button2.stringValue = @"Toggle multiline";
    button2.target = self;
    button2.action = @selector(multilinedClicked:);

    GTKSlider *slider = [GTKSlider new];
    [slider.constraints flexibleToTop: 0];
    [slider.constraints fixedToBottom: 70
                                 left: 10
                                right: 10];
    [slider.constraints fixedHeight: 50];
    slider.target = self;
    slider.action = @selector(sliderUpdated:);
    slider.numberOfTickMarks = 5;

    self.label = [GTKTextField new];
    [self.label.constraints fixedToTop: 10];
    [self.label.constraints flexibleToBottom: 0
                                   left: 0
                                  right: 0];
    self.label.constraints.centerHorizontal = true;
    [self.label.constraints fixedWidth: 200];
    [self.label.constraints fixedHeight: 30];
    self.label.stringValue = @"Hello, World!";

    [self.window addSubview: button];
    [self.window addSubview: button2];
    [self.window addSubview: slider];
    [self.window addSubview: self.label];

    self.window.delegate = self;
    self.window.title = @"Example Window";
    self.window.subtitle = @"Example Subtitle";

    [button becomeFirstResponder];

    // It would be dangerous to modify anything below this line.

    return self;
}

- (void)applicationDidFinishLaunching
{
    // Put your custom post-launch startup code below this line.

    self.window.hidden = false;

    printf("Hello!\n");
}

- (void)editableClicked:(GTKButton *)sender
{
    printf("Target-Action Message Sent!\n");
    self.label.editable = !self.label.editable;
}

- (void)multilinedClicked:(GTKButton *)sender
{
    printf("Target-Action Message Sent!\n");
    self.label.multiline = !self.label.multiline;
}

- (void)sliderUpdated:(GTKSlider *)sender
{
    printf("Slider Value: %d\n", sender.intValue);
}

- (void)windowDidClose
{
    printf("Goodbye!\n");
    [OFApplication terminate];
}
@end
