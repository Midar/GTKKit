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

#import "GTKScrollable.h"

@implementation GTKScrollable
- (GtkAdjustment*)horizontalAdjustment
{
	return gtk_scrollable_get_hadjustment(GTK_SCROLLABLE(self.widget));
}

- (void)setHorizontalAdjustment: (GtkAdjustment*)adjustment
{
	gtk_scrollable_set_hadjustment(GTK_SCROLLABLE(self.widget), adjustment);
}

- (GtkAdjustment*)verticalAdjustment
{
	return gtk_scrollable_get_vadjustment(GTK_SCROLLABLE(self.widget));
}

- (void)setVerticalAdjustment: (GtkAdjustment*)adjustment
{
	gtk_scrollable_set_vadjustment(GTK_SCROLLABLE(self.widget), adjustment);
}

- (GtkScrollablePolicy)horizontalScrollingPolicy
{
	return gtk_scrollable_get_hscroll_policy(GTK_SCROLLABLE(self.widget));
}

- (void)setHorizontalScrollingPolicy: (GtkScrollablePolicy)policy
{
	return gtk_scrollable_set_hscroll_policy(GTK_SCROLLABLE(self.widget),
	    policy);
}

- (GtkScrollablePolicy)verticalScrollingPolicy
{
	return gtk_scrollable_get_vscroll_policy(GTK_SCROLLABLE(self.widget));
}

- (void)setVerticalScrollingPolicy: (GtkScrollablePolicy)policy
{
	return gtk_scrollable_set_vscroll_policy(GTK_SCROLLABLE(self.widget),
	    policy);
}
@end
