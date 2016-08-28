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

#import "GTKContainer.h"

OF_ASSUME_NONNULL_BEGIN

/*!
 * @brief A GNOME-style header bar, designed to be used as an alternative to
 *	  traditional window titlebars and menubars.
 */
@interface GTKHeaderBar: GTKContainer
/*!
 * The title shown on the header bar.
 *
 * @throws GTKDestroyedWidgetException
 */
@property OFString *title;

/*!
 * The subtitle shown on the header bar.
 *
 * @throws GTKDestroyedWidgetException
 */
@property OFString *subtitle;

/*!
 * Whether or not to show a subtitle on the header bar.
 *
 * @throws GTKDestroyedWidgetException
 */
@property bool hasSubtitle;

/*!
 * Whether or not to show window control buttons on the header bar.
 *
 * @throws GTKDestroyedWidgetException
 */
@property bool showWindowButtons;

/*!
 * @brief The layout of the window buttons.
 *
 * The format of the layout string is a comma separated list of button names,
 * then a colon, then another such list of names, with the first list being the
 * names of window buttons on the left of the title, and the second those of the
 * buttons on the right. The allowable button names are:
 *
 * - minimize
 * - maximize
 * - close
 * - icon
 * - menu
 *
 * @throws GTKDestroyedWidgetException
 */
@property OFString *windowButtonLayout;
@end

OF_ASSUME_NONNULL_END
