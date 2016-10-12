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

#import "defines.h"
#import "GTKView.h"
#import "GTKImage.h"

typedef OF_ENUM(int, GTKImageScaling) {
    GTKImageScaleNone = 0,
    GTKImageScaleAxesIndependently = 1,
    GTKImageScaleProportionatelyDown = 2,
    GTKImageScaleProportionatelyUpOrDown = 3
};

@interface GTKImageView: GTKView
{
    __weak __block GTKImage *_image;
}
@property (weak) GTKImage *image;
@property GTKImageScaling imageScaling;
@end