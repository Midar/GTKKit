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

#import <ObjFW/ObjFW.h>

#import <gtk/gtk.h>

#import "GTKWidget.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKWidget (Properties)
@property OFString *name;
@property bool sensitive;
@property (readonly) bool effectiveSensitivity;
@property double opacity;
@property (readonly) bool isFocus;
@property GtkAlign horizontalAlign;
@property GtkAlign verticalAlign;
@property int marginStart;
@property int marginEnd;
@property int marginTop;
@property int marginBottom;
@property bool expandHorizontal;
@property bool expandVertical;
@property int widthRequest;
@property int heightRequest;
@end

OF_ASSUME_NONNULL_END
