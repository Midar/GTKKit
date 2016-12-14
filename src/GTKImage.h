/*! @file GTKImage.h
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

/*!
 * @brief An enumeration of the image file formats supported by GTKImage
 */
typedef enum GTKImageFormat {

	/*!
	 * @brief JPEG format.
	 */
	GTKImageFormatJPEG,

	/*!
	 * @brief PNG format.
	 */
	GTKImageFormatPNG,

	/*!
	 * @brief TIFF format.
	 */
	GTKImageFormatTIFF,

	/*!
	 * @brief ICO format.
	 */
	GTKImageFormatICO,

	/*!
	 * @brief BMP format.
	 */
	GTKImageFormatBMP
} GTKImageFormat;

/*!
 * @brief An enumeration of the supported sizes for stock icons.
 */
typedef enum GTKIconSize {

	/*!
	 * @brief A small icon.
	 */
	GTKIconSizeSmall = 16,

	/*!
	 * @brief A medium icon.
	 */
	GTKIconSizeMedium = 24,

	/*!
	 * @brief A large icon.
	 */
	GTKIconSizeLarge = 36,

	/*!
	 * @brief An extra-large icon.
	 */
	GTKIconSizeXLarge = 48
} GTKIconSize;

/*!
 * @brief A model class which represents image data.
 */
@interface GTKImage: OFObject
{
	__block GdkPixbuf *_pixbuf;
	__block int        _width;
	__block int        _height;
}

/*!
 * @brief The native width of the image.
 */
@property (readonly) int width;

/*!
 * @brief The native height of the image.
 */
@property (readonly) int height;

/*!
 * @brief Create an image from a local (file://) URL.
 */
+ imageWithURL: (OFURL *)url;

/*!
 * @brief Create an image from a stock icon in the default theme, at the specified
 * pixel size.
 */
+ imageWithIconName: (OFString *)name
	       size:(int)size;

+ imageWithPixbuf: (GdkPixbuf *)pixbuf;

/*!
 * @brief Save the image represented by this GTKImage to a file with the
 * specified format.
 */
- (void)writeImageToURL: (OFURL *)url
		 format: (GTKImageFormat)format;

/*!
 * @brief Save the image represented by this GTKImage to a file with the
 * specified format.
 */
- (void)writeImageToFile: (OFString *)url
		  format: (GTKImageFormat)format;

// Private methods.
- (GdkPixbuf *)pixbuf;
- (GdkPixbuf *)pixbufScaledToWidth: (int)width
			    height:(int)height
		 maintainingAspect:(bool)aspect;
@end
