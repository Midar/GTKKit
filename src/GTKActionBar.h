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

/*!
 * @brief A full-width container bar designed to present contextual actions.
 */
@interface GTKActionBar: GTKBin
/*!
 * @brief The widget to display at the center of the bar.
 *
 * @throws GTKDestroyedWidgetException
 */
@property GTKWidget *centerWidget;

/*!
 * @brief Add a widget to the start of the bar (usually the left side).
 *
 * @throws GTKDestroyedWidgetException
 */
 - (void)addWidgetAtStart:(GTKWidget*)childWidget;

 /*!
  * @brief Add a widget to the end of the bar (usually the right side).
  *
  * @throws GTKDestroyedWidgetException
  */
  - (void)addWidgetAtEnd:(GTKWidget*)childWidget;
@end

OF_ASSUME_NONNULL_END
