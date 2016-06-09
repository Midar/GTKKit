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

#import "GTKBin.h"

OF_ASSUME_NONNULL_BEGIN

@interface GTKScrolledWindow: GTKBin
@property GtkAdjustment *horizontalAdjustment;
@property GtkAdjustment *verticalAdjustment;
@property GtkPolicyType horizontalScrollingPolicy;
@property GtkPolicyType verticalScrollingPolicy;
@property GtkCornerType placement;
@property GtkShadowType shadowType;
@property int minContentWidth;
@property int minContentHeight;
@property bool kineticScrollingEnabled;
@property bool overlayScrollingEnabled;
@property bool captureButtonPress;
@end

OF_ASSUME_NONNULL_END
