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

	self.info = [GTKInfoBar new];
	self.info.layer = GTKViewLayerNotification;
	self.info.stringValue = @"Example info bar";
	[self.info addButtonWithLabel: @"Yes" response: GTKResponseTypeYes];
	[self.info addButtonWithLabel: @"No" response: GTKResponseTypeNo];

	[self.contentView addSubview: self.info];

	self.title = @"Info Bar";

	return self;
}
@end
