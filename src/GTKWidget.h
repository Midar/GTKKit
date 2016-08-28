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

#import "Exceptions.h"

OF_ASSUME_NONNULL_BEGIN

@class GTKWidget;

extern void gtkkit_widget_destroyed_handler(GtkWidget *_Nonnull widget,
    GTKWidget *_Nonnull wrapper);

/*!
 * @brief The core widget class of GTKKit.
 *
 * Instances of this abstract class's concrete subclasses implement all GTK+
 * widget wrappers that make up the bulk of functionality in GTKKit.
 */
@interface GTKWidget: OFObject
{
#ifdef GTK_WIDGET_M
@public
#endif
	GtkWidget *_widget;
	gulong _widgetDestroyedHandlerID;
}

/*!
 * The property which stores the pointer to the internal GtkWidget structure.
 *
 * This is only useful or interesting to people extending GTKKit with new
 * widget classes or methods.
 *
 * @throws GTKDestroyedWidgetException
 */
@property GtkWidget *widget;

/*!
 * The immediate parent of the widget, if it has one.
 */
@property (weak) GTKWidget *parent;

/*!
 * @brief Convenience method for locating the wrapper for a GTK+ widget C
 *	  pointer using only the pointer itself.
 *
 * @throws GTKNoWrapperForGtkWidgetException
 */
+ (instancetype)wrapperForGtkWidget: (GtkWidget*)widget;
@end

OF_ASSUME_NONNULL_END
