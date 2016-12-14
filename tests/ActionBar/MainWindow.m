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

	self.actions = [GTKActionBar new];

	GTKSegmentedControl *control1 = [GTKSegmentedControl new];
	control1.segments = 3;
	[self.actions addSubviewStart: control1];

	GTKSegmentedControl *control2 = [GTKSegmentedControl new];
	control2.segments = 2;
	self.actions.centerView = control2;

	GTKSegmentedControl *control3 = [GTKSegmentedControl new];
	control3.segments = 4;
	[self.actions addSubviewEnd: control3];

	[self.contentView addSubview: self.actions];

	self.title = @"Action Bar";

	return self;
}
@end
