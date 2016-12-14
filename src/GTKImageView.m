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

#import "GTKImageView.h"
#import "GTKApplication.h"

@implementation GTKImageView
- init
{
	self = [super init];
	self.imageScaling = GTKImageScaleNone;
	return self;
}

- (void)createMainWidget
{
	[GTKApp.dispatch.gtk sync: ^{
		self.mainWidget = gtk_image_new();
	}];
}

- (void)draw
{
	[super draw];

	__block GdkPixbuf *newPixbuf = NULL;

	switch (self.imageScaling) {
	case GTKImageScaleNone:
		break;

	case GTKImageScaleAxesIndependently:
		newPixbuf = [self.image pixbufScaledToWidth: self.frame.width
						     height: self.frame.height
					  maintainingAspect: false];
		break;

	case GTKImageScaleProportionatelyDown:
		if (self.frame.width < self.image.width ||
		    self.frame.height < self.image.height) {
			newPixbuf = [self.image pixbufScaledToWidth: self.frame.width
							     height: self.frame.height
						  maintainingAspect: true];
		}
		break;

	case GTKImageScaleProportionatelyUpOrDown:
		newPixbuf = [self.image pixbufScaledToWidth: self.frame.width
						     height: self.frame.height
					  maintainingAspect: true];
		break;
	}

	if (NULL != newPixbuf) {
		[GTKApp.dispatch.gtk sync: ^{
			GdkPixbuf *oldPixbuf = gtk_image_get_pixbuf(GTK_IMAGE(self.mainWidget));
			gtk_image_set_from_pixbuf(GTK_IMAGE(self.mainWidget), newPixbuf);
			g_object_unref(G_OBJECT(oldPixbuf));
		}];
	}
}

- (GTKImage *)image
{
	return _image;
}

- (void)setImage: (GTKImage *)image
{
	_image = image;
	[self draw];
}
@end
