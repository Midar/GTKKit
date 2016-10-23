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

#import "GTKImage.h"
#import "GTKApplication.h"

@interface GTKImage ()
- initWithPixbuf:(GdkPixbuf *)pixbuf;
@end

@implementation GTKImage
+ imageWithURL:(OFURL *)url
{
    return [[self alloc] initWithURL: url];
}

+ imageWithPixbuf:(GdkPixbuf *)pixbuf
{
    return [[self alloc] initWithPixbuf: pixbuf];
}

- initWithURL:(OFURL *)url
{
    self = [self init];

    of_comparison_result_t result = [url.scheme caseInsensitiveCompare: @"file"];
    if (result != 0) {
        return nil;
    }

    __block GError *err = NULL;

    [GTKApp.dispatch.gtk sync: ^{
        _pixbuf = gdk_pixbuf_new_from_file(
            url.path.UTF8String,
            &err);

        _width = gdk_pixbuf_get_width(_pixbuf);
        _height = gdk_pixbuf_get_height(_pixbuf);
    }];

    if (NULL == _pixbuf) {
        return nil;
    }

    return self;
}

- initWithPixbuf:(GdkPixbuf *)pixbuf
{
    self = [self init];
    _pixbuf = pixbuf;
    return self;
}

- (void)dealloc
{
    g_object_unref(_pixbuf);
}

- (GdkPixbuf *)pixbuf
{
    return _pixbuf;
}

- (GdkPixbuf *)pixbufScaledToWidth:(int)width
                            height:(int)height
                 maintainingAspect:(bool)aspect
{
    __block GdkPixbuf *newPixbuf;

    int targetWidth = width;
    int targetHeight = height;

    double widthRatio = (double)(self.width) / (double)(width);
    double heightRatio = (double)(self.height) / (double)(height);

    if (aspect == true) {
        if (heightRatio > widthRatio) {
            targetWidth = self.width / heightRatio;
        } else {
            targetHeight = self.height / widthRatio;
        }
    }

    [GTKApp.dispatch.gtk sync: ^{
        newPixbuf = gdk_pixbuf_scale_simple(
            self.pixbuf,
            targetWidth,
            targetHeight,
            GDK_INTERP_BILINEAR);
    }];

    return newPixbuf;
}
@end
