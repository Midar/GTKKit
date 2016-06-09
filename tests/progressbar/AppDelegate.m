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
  gtk_init(NULL,NULL);

  self.window = [GTKWindow new];
  self.window.size = of_dimension(300,50);
  // This makes the AppDelegate also act as the GTKWindowDelegate for the window.
  self.window.delegate = self;
  self.window.title = @"Hello, World!";
  self.window.resizable = false;

  self.grid = [GTKGrid new];
  [self.window addWidget: self.grid];

  self.pbar = [GTKProgressBar new];
  self.pbar.expandHorizontal = true;
  self.pbar.marginStart = 10;
  self.pbar.marginEnd = 10;
  self.pbar.marginTop = 10;
  self.pbar.marginBottom = 10;

  self.button = [GTKButton new];
  self.button.label = @"Click me!";
  self.button.target = self;
  self.button.action = @selector(buttonClicked:);
  self.button.marginStart = 10;
  self.button.marginEnd = 10;
  self.button.marginBottom = 10;

  self.label = [GTKLabel new];
  self.label.expandHorizontal = true;
  self.label.text = @"Value: 0.0";
  self.label.marginStart = 10;
  self.label.marginEnd = 10;
  self.label.marginBottom = 10;

  [self.grid attachWidget: self.pbar
                     left: 1
                      top: 1
                    width: 3
                   height: 1];

  [self.grid attachWidget: self.label
                     left: 1
                      top: 2
                    width: 3
                   height: 1];

  [self.grid attachWidget: self.button
                     left: 2
                      top: 3
                    width: 1
                   height: 1];

  return self;
}

- (void)applicationDidFinishLaunching
{
  [self.window showAll];

  gtk_main();
}

- (void)applicationWillTerminate
{
  gtk_main_quit();
}

- (void)windowWillClose:(GTKWindow *)sender
{
  [OFApplication terminate];
}

- (void)buttonClicked:(GTKButton *)sender
{
  if (self.pbar.value > .99) {
    self.pbar.value = 0.0;
  } else {
    self.pbar.value += 0.1;
  }
  self.label.text = [OFString stringWithFormat: @"Value: %.1f", self.pbar.value];
}
@end
