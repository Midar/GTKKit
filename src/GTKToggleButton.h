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

#import "GTKButton.h"

OF_ASSUME_NONNULL_BEGIN

/*!
 * @brief A button that retains its state.
 */
@interface GTKToggleButton: GTKButton
{
  gulong _buttonToggledHandlerID;
}
/*!
 * @brief Whether or not to draw a toggle indicator for this button.
 */
@property bool drawIndicator;
/*!
 * @brief The state of the button.
 */
@property bool active;
/*!
 * @brief Whether or not the button is in an "inconsistent" state.
 */
@property bool inconsistent;
@end

OF_ASSUME_NONNULL_END
