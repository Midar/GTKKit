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

#import "MainWindow.h"

@implementation MainWindow
- init
{
    self = [super init];

    self.menuButtonHidden = false;
    self.menuButtonPopOver.width = 150;
    self.menuButtonPopOver.height = 75;
    self.menuLabel = [GTKTextField new];
    [self.menuLabel.constraints fixedToTop: 10];
    [self.menuLabel.constraints flexibleToBottom: 0
                                            left: 0
                                           right: 0];
    self.menuLabel.constraints.centerHorizontal = true;
    [self.menuLabel.constraints fixedWidth: 100];
    [self.menuLabel.constraints fixedHeight: 30];
    self.menuLabel.stringValue = @"Hi there!";
    [self.menuButtonPopOver addView: self.menuLabel];

    GTKRect frame = self.frame;
    frame.x = 50;
    frame.y = 200;
    frame.width = 300;
    frame.height = 400;
    self.frame = frame;

    self.box = [GTKBox new];
    [self.box.constraints flexibleToTop: 0];
    [self.box.constraints fixedToBottom: 10
                                   left: 10
                                  right: 10];
    [self.box.constraints fixedHeight: 150];

    self.toggleEditableButton = [GTKButton new];
    [self.toggleEditableButton.constraints flexibleToTop: 0
                                 left: 0
                                right: 0];
    [self.toggleEditableButton.constraints fixedToBottom: 10];
    self.toggleEditableButton.constraints.centerHorizontal = true;
    [self.toggleEditableButton.constraints fixedWidth: 100];
    [self.toggleEditableButton.constraints fixedHeight: 30];
    self.toggleEditableButton.stringValue = @"Toggle editable";

    self.toggleMultilineButton = [GTKButton new];
    [self.toggleMultilineButton.constraints flexibleToTop: 0
                                 left: 0
                                right: 0];
    [self.toggleMultilineButton.constraints fixedToBottom: 55];
    self.toggleMultilineButton.constraints.centerHorizontal = true;
    [self.toggleMultilineButton.constraints fixedWidth: 100];
    [self.toggleMultilineButton.constraints fixedHeight: 30];
    self.toggleMultilineButton.stringValue = @"Toggle multiline";

    self.slider = [GTKSlider new];
    [self.slider.constraints flexibleToBottom: 0];
    [self.slider.constraints fixedToTop: 10
                                 left: 10
                                right: 10];
    [self.slider.constraints fixedHeight: 50];
    self.slider.minValue = 0.0;
    self.slider.maxValue = 1.0;
    self.slider.doubleValue = 1.0;
    self.slider.numberOfTickMarks = 11;

    self.label = [GTKTextField new];
    [self.label.constraints fixedToTop: 10];
    [self.label.constraints flexibleToBottom: 0
                                   left: 0
                                  right: 0];
    self.label.constraints.centerHorizontal = true;
    [self.label.constraints fixedWidth: 200];
    [self.label.constraints fixedHeight: 30];
    self.label.stringValue = @"Hello, World!";

    [self addView: self.box];
    [self.box addSubview: self.toggleEditableButton];
    [self.box addSubview: self.toggleMultilineButton];
    [self.box addSubview: self.slider];
    [self addView: self.label];

    self.title = @"Example Window";
    self.subtitle = @"Example Subtitle";

    return self;
}
@end
