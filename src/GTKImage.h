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

/*!
 * @brief A widget that shows an image.
 */
@interface GTKImage: GTKWidget
{
    OFString *_imageFile;
    OFString *_iconName;
}

/*!
 * @brief the full path of the image to use.
 * @throws GTKDestroyedWidgetException
 */
@property OFString *imageFile;

/*!
 * @brief The name of the GTK+ internal icon to use.
 * @throws GTKDestroyedWidgetException
 */
@property OFString *iconName;

/*!
 * @brief The size of the icon to use. One of the folowing possible values:
 *
 * - GTK_ICON_SIZE_MENU
 * - GTK_ICON_SIZE_SMALL_TOOLBAR
 * - GTK_ICON_SIZE_LARGE_TOOLBAR
 * - GTK_ICON_SIZE_BUTTON
 * - GTK_ICON_SIZE_DND
 * - GTK_ICON_SIZE_DIALOG
 * @throws GTKDestroyedWidgetException
 */
@property GtkIconSize iconSize;
@end

OF_ASSUME_NONNULL_END
