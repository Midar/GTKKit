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
  self.window.size = of_dimension(400,100);

  // This makes the AppDelegate also act as the GTKWindowDelegate for the window.
  self.window.delegate = self;

  self.window.title = @"GTKLevelBar Demo";

  self.grid = [GTKGrid new];
  self.grid.expandHorizontal = true;
  self.grid.expandVertical = true;
  self.grid.rowsHomogeneous = true;

  self.lbar = [GTKLevelBar new];
  self.lbar.expandHorizontal = true;
  self.lbar.marginTop = 10;
  self.lbar.marginBottom = 10;
  self.lbar.marginStart = 10;
  self.lbar.marginEnd = 10;
  self.lbar.minValue = 0;
  self.lbar.maxValue = 100;

  [self.grid attachWidget: self.lbar
                     left: 1
                      top: 1
                    width: 1
                   height: 1];

  self.scale = [GTKScale new];
  self.scale.expandHorizontal = true;
  self.scale.marginBottom = 10;
  self.scale.marginStart = 10;
  self.scale.marginEnd = 10;
  self.scale.target = self;
  self.scale.action = @selector(scaleValueChanged:);
  self.scale.minValue = 0;
  self.scale.maxValue = 100;
  self.scale.digits = 1;
  self.scale.stepSize = 1;
  self.scale.formatString = @"%.0f%%";

  [self.grid attachWidget: self.scale
                     left: 1
                      top: 2
                    width: 1
                   height: 1];

  [self.window addWidget: self.grid];

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

// This demonstrates the use of a GTKWindowDelegate method. This makes the
// application exit when the window is closed.

- (void)windowWillClose:(GTKWindow *)sender
{
  [OFApplication terminate];
}

- (void)scaleValueChanged:(GTKScale *)sender
{
  self.lbar.value = sender.value;
}
@end
