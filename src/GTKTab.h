/*! @file GTKTab.h
 *
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

#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>

#import "GTKView.h"
#import "GTKCoding.h"

/*!
 * @brief A class representing a tab in a tab view. It wraps around a GTKView,
 * which will be used as the view when the tab is shown. It is also used in
 * tabbed windows.
 */
@interface GTKTab: OFObject <GTKCoding>
@property int tag;
@property (readonly) bool selected;
@property (nullable) OFString *label;
@property (nonnull) GTKView *contentView;
//@property (weak, nullable) GTKTabView *tabView;
@end
