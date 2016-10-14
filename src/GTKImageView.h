/*! @file GTKImageView.h
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

/*!
 * @brief The kinds of scaling method a GTKImageView can use for its image.
 */
typedef enum GTKImageScaling {

    /*!
     * @brief No scaling. The image will be shown at its native size, regardless
     * of the size of the GTKImageView.
     */
    GTKImageScaleNone,

    /*!
     * @brief Scale the image to fit the GTKImageView exactly, regardless of its
     * native aspect ratio.
     */
    GTKImageScaleAxesIndependently,

    /*!
     * @brief If the native size of the image is larger than the GTKImageView,
     * scale it down to fit, maintiaining the native aspect ratio of the image.
     */
    GTKImageScaleProportionatelyDown,

    /*!
     * @brief Scale the image to fit the GTKImageView, maintaining its native
     * aspect ratio.
     */
    GTKImageScaleProportionatelyUpOrDown
} GTKImageScaling;


/*!
 * @brief A class representing a view which displays an image to the user.
 */
@interface GTKImageView: GTKView
{
    __weak __block GTKImage *_image;
}

/*!
 * @brief The image the view displays to the user.
 */
@property (weak) GTKImage *image;

/*!
 * @brief The scaling method the view should use for the image it displays.
 */
@property GTKImageScaling imageScaling;
@end
