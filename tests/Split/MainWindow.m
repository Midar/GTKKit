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
	frame.height = 400;
	self.frame = frame;

	self.split = [GTKSplitView new];
	[self.split.constraints fixedToTop: 0
				    bottom: 0
				      left: 0
				     right: 0];
	[self.split.constraints flexibleWidth: 0];
	[self.split.constraints flexibleHeight: 0];

	[self.contentView addSubview: self.split];

	self.leftLabel = [GTKTextField new];
	self.leftLabel.stringValue = @"Left Pane";
	self.leftLabel.constraints.centerHorizontal = true;
	self.leftLabel.constraints.centerVertical = true;
	[self.leftLabel.constraints fixedWidth: 100];
	[self.leftLabel.constraints fixedHeight: 30];
	[self.split.leftView addSubview: self.leftLabel];

	self.rightLabel = [GTKTextField new];
	self.rightLabel.stringValue = @"Right Pane";
	self.rightLabel.constraints.centerHorizontal = true;
	self.rightLabel.constraints.centerVertical = true;
	[self.rightLabel.constraints fixedWidth: 100];
	[self.rightLabel.constraints fixedHeight: 30];
	[self.split.rightView addSubview: self.rightLabel];

	self.title = @"Spit View";
	self.subtitle = @"Example Subtitle";

	return self;
}
@end
