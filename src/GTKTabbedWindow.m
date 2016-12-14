/*! @file GTKTabbedWindow.m
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

#import "GTKTabbedWindow.h"
#import "GTKApplication.h"
#import "GTKTabView.h"

@implementation GTKTabbedWindow: GTKWindow
- init
{
	self = [super init];

	self.contentView.tabsHidden = true;
	self.contentView.frameHidden = true;

	[GTKApp.dispatch.gtk sync: ^{
		_switcher = gtk_stack_switcher_new();
		g_object_ref_sink(G_OBJECT(_switcher));
		gtk_widget_show(_switcher);
		gtk_stack_switcher_set_stack(
		    GTK_STACK_SWITCHER(_switcher),
		    GTK_STACK(self.contentView.stack));
		gtk_header_bar_set_custom_title(
		    GTK_HEADER_BAR(_headerBar),
		    _switcher);
	}];

	return self;
}

- (void)dealloc
{
	g_object_unref(_switcher);
}

- (void)createContentView
{
	self.contentView = [GTKTabView new];
}

- (nullable GTKTabView *)contentView
{
	return (GTKTabView *)(_contentView);
}

- (void)setContentView: (nullable GTKTabView *)view
{
	if (_contentView == NULL) {
		_contentView = (GTKView *)(view);
	}
}

- (nullable GTKView *)titleView
{
	return _titleView;
}

- (void)setTitleView: (nullable GTKView *)view
{
	// Do nothing.
}
@end
