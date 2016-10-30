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

    GTKRect frame = self.frame;
    frame.x = 50;
    frame.y = 200;
    frame.width = 500;
    frame.height = 200;
    self.frame = frame;

    self.segment1 = [GTKSegmentedControl new];
    self.segment1.segments = 3;
    self.segment1.trackingMode = GTKSegmentSwitchTrackingMomentary;
    [self.segment1 setImage: [GTKImage imageWithStockIconName: @"document-new" size: GTKIconSizeSmall]
                 forSegment: 0];
    [self.segment1 setImage: [GTKImage imageWithStockIconName: @"document-open" size: GTKIconSizeSmall]
                 forSegment: 1];
    [self.segment1 setImage: [GTKImage imageWithStockIconName: @"document-save" size: GTKIconSizeSmall]
                 forSegment: 2];

    self.segment2 = [GTKSegmentedControl new];
    self.segment2.segments = 2;
    self.segment2.trackingMode = GTKSegmentSwitchTrackingSelectAny;
    [self.segment2 setImage: [GTKImage imageWithStockIconName: @"format-text-bold" size: GTKIconSizeSmall]
                 forSegment: 0];
    [self.segment2 setImage: [GTKImage imageWithStockIconName: @"format-text-italic" size: GTKIconSizeSmall]
                 forSegment: 1];

    self.segment3 = [GTKSegmentedControl new];
    self.segment3.segments = 3;
    self.segment3.trackingMode = GTKSegmentSwitchTrackingSelectOne;
    [self.segment3 setImage: [GTKImage imageWithStockIconName: @"zoom-in" size: GTKIconSizeSmall]
                 forSegment: 0];
    [self.segment3 setImage: [GTKImage imageWithStockIconName: @"zoom-original" size: GTKIconSizeSmall]
                 forSegment: 1];
    [self.segment3 setImage: [GTKImage imageWithStockIconName: @"zoom-out" size: GTKIconSizeSmall]
                 forSegment: 2];

    [self addViewToHeaderBarStart: self.segment1];
    [self addViewToHeaderBarStart: self.segment2];
    [self addViewToHeaderBarEnd: self.segment3];

    self.label = [GTKTextField new];
    self.label.multiline = true;
    [self.label.constraints fixedToTop: 10
                                bottom: 10
                                  left: 10
                                 right: 10];
    self.label.stringValue = @"This window shows three segmented controls in the header bar.";
    [self addView: self.label];

    self.title = @"Segmented Controls";

    return self;
}
@end
