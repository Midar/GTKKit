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

	self.list = [GTKListView new];
	[self.list.constraints fixedToTop: 5
				   bottom: 5
				     left: 5
				    right: 5];

	[self.contentView addSubview: self.list];

	self.title = @"List View";

	return self;
}
@end
