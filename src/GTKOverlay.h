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
 * @brief A container which stacks its children on the Z
 * axis.
 *
 * An overlay container is appropriate, for example, when one wishes to have
 * video controls float "above" the video they control, or for paint tools
 * to behave in a similar manner for the image they manipulate.
 */
@interface GTKOverlay: GTKBin
/*!
 * @brief Adds an overlay child widget to the overlay container.
 *
 * @param child The widget to add to the container.
 * @throws GTKDestroyedWidgetException
 */
- (void)addOverlayChild:(GTKWidget*)child;

/*!
 * @brief Changes the z-index ordering of the specified child widget.
 *
 * @param child The child widget to reorder
 * @param index The new index for the chile widget.
 * @throws GTKDestroyedWidgetException
 */
- (void)reorderOverlayChild:(GTKWidget*)child
                    toIndex:(int)index;

/*!
 * @brief Gets whether or not the specified child passes its input through to
 * the widget below. This does not apply to the main child.
 *
 * @param child The child widget to check.
 * @throws GTKDestroyedWidgetException
 */
- (bool)overlayChildPassthrough:(GTKWidget*)child;

/*!
* @brief Sets whether or not the specified child passes its input through to
* the widget below. This does not apply to the main child.
*
* @param child The child widget on which to set the property.
* @param passthrough Whether or not to pass through input.
* @throws GTKDestroyedWidgetException
*/
- (void)setOverlayChildPassthrough:(GTKWidget*)child
                                to:(bool)passthrough;
@end

OF_ASSUME_NONNULL_END
