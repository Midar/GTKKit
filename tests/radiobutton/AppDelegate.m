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

    self.grid = [GTKGrid new];

    self.button1 = [GTKRadioButton radioButtonWithLabelText: @"Option 1"];
    self.button1.target = self;
    self.button1.action = @selector(buttonToggled:);

    self.button2 = [GTKRadioButton radioButtonWithLabelText: @"Option 2"
                              joiningGroupWithRadioButton: self.button1];
    self.button2.target = self;
    self.button2.action = @selector(buttonToggled:);

    self.button3 = [GTKRadioButton radioButtonWithLabelText: @"Option 3"
                              joiningGroupWithRadioButton: self.button1];
    self.button3.target = self;
    self.button3.action = @selector(buttonToggled:);

    [self.grid attachWidget: self.button1
                       left: 1
                        top: 1
                      width: 1
                     height: 1];

    [self.grid attachWidget: self.button2
                       left: 1
                        top: 2
                      width: 1
                     height: 1];

    [self.grid attachWidget: self.button3
                       left: 1
                        top: 3
                      width: 1
                     height: 1];

    [self.window addWidget: self.grid];

    return self;
}

- (void)applicationDidFinishLaunching
{
    [super applicationDidFinishLaunching];

    [self.window showAll];

    gtk_main();
}

- (void)buttonToggled:(id)sender
{
  printf("Option selected: ");
  if (sender == self.button1) {
    printf("Option 1");
  } else if (sender == self.button2) {
    printf("Option 2");
  } else if (sender == self.button3) {
    printf("Option 3");
  }
  printf("\n");
}

- (void)windowWillClose:(GTKWindow *)sender
{
  [OFApplication terminate];
}

@end
