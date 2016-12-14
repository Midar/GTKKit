/*! @file GTKLayoutConstraints.h
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

#import "GTKCoding.h"
#import "GTKCoder.h"

/*!
 * @brief The types of constraint it's possible to use.
 */
typedef enum GTKLayoutConstraintType {
	/*!
	 * @brief A flexible constraint, the value of which is a percentage of the
	 * relevant axis of the superview.
	 */
	GTKLayoutConstraintTypeFlexible,
	/*!
	 * @brief A fixed constraint, the value of which is a fixed number of pixels.
	 */
	GTKLayoutConstraintTypeFixed
} GTKLayoutConstraintType;

/*!
 * @brief A class whose instances represent layout constraints.
 *
 * The properties of these objects are used in calculating the position and size
 * of views in view hierarchies.
 */
@interface GTKLayoutConstraint: OFObject <GTKCoding>

- initWithType:(GTKLayoutConstraintType)type
		 value:(double)value;

/*!
 * @brief The type of the constraint, either GTKLayoutConstraintTypeFixed or
 * GTKLayoutConstraintTypeFlexible.
 */
@property GTKLayoutConstraintType type;

/*!
 * @brief The value associated with the constraint.
 *
 * The meaning of this value depends on the type of the constraint; for fixed
 * constraints, it represents an offset in pixels; for flexible constraints, it
 * is a percentage value used to calculate a pixel offset. Negative values are
 * valid; they can be used to move part of a
 * subview outside the bounds of the parent view (clipped to its space). In the
 * case of flexible constraints, a zero value is interpreted as any value being
 * acceptable. If 0% is actually desired, 0 fixed is mathematically identical.
 */
@property double value;
+ (nullable instancetype)layoutConstraintWithType:(GTKLayoutConstraintType)type
											value:(double)value;
@end

/*!
 * @brief A class representing the layout constraints of a view.
 */
@interface GTKLayoutConstraints: OFObject <GTKCoding>

/*!
 * @brief The width constraint of the view. This constrains the width of
 * the view.
 */
@property (nonnull) GTKLayoutConstraint *width;

/*!
 * @brief The height constraint of the view. This constrains the height of the
 * view.
 */
@property (nonnull) GTKLayoutConstraint *height;

/*!
 * @brief The top constraint of this view. This constrains the upper edge of the
 * view relative to the top of its superview.
 */
@property (nonnull) GTKLayoutConstraint *top;

/*!
 * @brief The right constraint of this view. This constrains the right edge of
 * the view relative to the right of its superview.
 */
@property (nonnull) GTKLayoutConstraint *right;

/*!
 * @brief The bottom constraint of this view. This constrains the lower edge of the
 * view relative to the bottom of its superview.
 */
@property (nonnull) GTKLayoutConstraint *bottom;

/*!
 * @brief The left constraint of this view. This constrains the left edge of the
 * view relative to the left of its superview.
 */
@property (nonnull) GTKLayoutConstraint *left;

/*!
 * @brief A boolean value indicating whether or not the view should be centered
 * in its superview on the horizontal axis.
 */
@property bool centerHorizontal;

/*!
 * @brief A boolean value indicating whether or not the view should be centered
 * in its superview on the vertical axis.
 */
@property bool centerVertical;

/*!
 * @brief Set the constraint's top, bottom, left and right to fixed, at the
 * given values.
 *
 * @param top The value of the top constraint
 * @param bottom The value of the bottom constraint
 * @param left The value of the left constraint
 * @param right The value of the right constraint
 */
 - (void)fixedToTop:(double)top
			bottom:(double)bottom
			  left:(double)left
			 right:(double)right;

/*!
 * @brief Set the constraint's top, left and right to fixed, at the
 * given values.
 *
 * @param top The value of the top constraint
 * @param bottom The value of the bottom constraint
 * @param right The value of the right constraint
 */
- (void)fixedToTop:(double)top
			  left:(double)left
			 right:(double)right;

/*!
 * @brief Set the constraint's top, bottom, and left to fixed, at the
 * given values.
 *
 * @param top The value of the top constraint
 * @param bottom The value of the bottom constraint
 * @param left The value of the left constraint
 */
- (void)fixedToTop:(double)top
			bottom:(double)bottom
			  left:(double)left;

/*!
 * @brief Set the constraint's top, bottom, and right to fixed, at the
 * given values.
 *
 * @param top The value of the top constraint
 * @param bottom The value of the bottom constraint
 * @param right The value of the right constraint
 */
- (void)fixedToTop:(double)top
			bottom:(double)bottom
			 right:(double)right;

/*!
 * @brief Set the constraint's bottom, left and right to fixed, at the
 * given values.
 *
 * @param bottom The value of the bottom constraint
 * @param left The value of the left constraint
 * @param right The value of the right constraint
 */
- (void)fixedToBottom:(double)bottom
				 left:(double)left
				right:(double)right;

/*!
 * @brief Set the constraint's top and bottom to fixed, at the given values.
 *
 * @param top The value of the top constraint
 * @param bottom The value of the bottom constraint
 */
- (void)fixedToTop:(double)top
			bottom:(double)bottom;

/*!
 * @brief Set the constraint's top and left to fixed, at the given values.
 *
 * @param top The value of the top constraint
 * @param left The value of the left constraint
 */
- (void)fixedToTop:(double)top
			  left:(double)left;

/*!
 * @brief Set the constraint's top and right to fixed, at the given values.
 *
 * @param top The value of the top constraint
 * @param right The value of the right constraint
 */
- (void)fixedToTop:(double)top
			 right:(double)right;

/*!
 * @brief Set the constraint's bottom and left to fixed, at the given values.
 *
 * @param bottom The value of the bottom constraint
 * @param left The value of the left constraint
 */
- (void)fixedToBottom:(double)bottom
				 left:(double)left;

/*!
 * @brief Set the constraint's bottom and right to fixed, at the given values.
 *
 * @param bottom The value of the bottom constraint
 * @param right The value of the right constraint
 */
- (void)fixedToBottom:(double)bottom
				right:(double)right;

/*!
 * @brief Set the constraint's left and right to fixed, at the given values.
 *
 * @param left The value of the left constraint
 * @param right The value of the right constraint
 */
- (void)fixedToLeft:(double)left
			  right:(double)right;

/*!
* @brief Set the constraint's top fixed, at the given values.
*
* @param top The value of the top constraint
*/
- (void)fixedToTop:(double)top;

/*!
* @brief Set the constraint's bottom fixed, at the given values.
*
* @param bottom The value of the bottom constraint
*/
- (void)fixedToBottom:(double)bottom;

/*!
* @brief Set the constraint's left fixed, at the given values.
*
* @param left The value of the left constraint
*/
- (void)fixedToLeft:(double)left;

/*!
* @brief Set the constraint's right fixed, at the given values.
*
* @param right The value of the right constraint
*/
- (void)fixedToRight:(double)right;

/*!
* @brief Set the constraint's horizontal flexible, at the given values.
*
* @param horizontal The value of the right constraint
*/
- (void)fixedWidth:(double)width;

/*!
* @brief Set the constraint's vertical flexible, at the given values.
*
* @param vertical The value of the right constraint
*/
- (void)fixedHeight:(double)height;

/*!
 * @brief Set the constraint's top, bottom, left and right to flexible, at the
 * given values.
 *
 * @param top The value of the top constraint
 * @param bottom The value of the bottom constraint
 * @param left The value of the left constraint
 * @param right The value of the right constraint
 */
- (void)flexibleToTop:(double)top
			   bottom:(double)bottom
				 left:(double)left
				right:(double)right;

/*!
 * @brief Set the constraint's top, left and right to flexible, at the given values.
 *
 * @param top The value of the top constraint
 * @param left The value of the left constraint
 * @param right The value of the right constraint
 */
- (void)flexibleToTop:(double)top
				 left:(double)left
				right:(double)right;

/*!
 * @brief Set the constraint's top, bottom, and left to flexible, at the
 * given values.
 *
 * @param top The value of the top constraint
 * @param bottom The value of the bottom constraint
 * @param left The value of the left constraint
 */
- (void)flexibleToTop:(double)top
			   bottom:(double)bottom
				 left:(double)left;

/*!
 * @brief Set the constraint's top, bottom, and right to flexible, at the
 * given values.
 *
 * @param top The value of the top constraint
 * @param bottom The value of the bottom constraint
 * @param right The value of the right constraint
 */
- (void)flexibleToTop:(double)top
			   bottom:(double)bottom
				right:(double)right;

/*!
 * @brief Set the constraint's bottom, left and right to flexible, at the
 * given values.
 *
 * @param bottom The value of the bottom constraint
 * @param left The value of the left constraint
 * @param right The value of the right constraint
 */
- (void)flexibleToBottom:(double)bottom
					left:(double)left
				   right:(double)right;

/*!
 * @brief Set the constraint's top and bottom  to flexible, at the
 * given values.
 *
 * @param top The value of the top constraint
 * @param bottom The value of the bottom constraint
 */
- (void)flexibleToTop:(double)top
			   bottom:(double)bottom;

/*!
 * @brief Set the constraint's top and left and right to flexible, at the
 * given values.
 *
 * @param top The value of the top constraint
 * @param left The value of the left constraint
 */
- (void)flexibleToTop:(double)top
				 left:(double)left;

/*!
 * @brief Set the constraint's top and right to flexible, at the given values.
 *
 * @param top The value of the top constraint
 * @param right The value of the right constraint
 */
- (void)flexibleToTop:(double)top
				right:(double)right;

/*!
 * @brief Set the constraint's bottom and left to flexible, at the given values.
 *
 * @param bottom The value of the bottom constraint
 * @param left The value of the left constraint
 */
- (void)flexibleToBottom:(double)bottom
					left:(double)left;

/*!
 * @brief Set the constraint's bottom and right to flexible, at the given values.
 *
 * @param bottom The value of the bottom constraint
 * @param right The value of the right constraint
 */
- (void)flexibleToBottom:(double)bottom
				   right:(double)right;

/*!
 * @brief Set the constraint's left and right to flexible, at the
 * given values.
 *
 * @param left The value of the left constraint
 * @param right The value of the right constraint
 */
- (void)flexibleToLeft:(double)left
				 right:(double)right;

/*!
* @brief Set the constraint's top flexible, at the given values.
*
* @param top The value of the top constraint
*/
- (void)flexibleToTop:(double)top;

/*!
* @brief Set the constraint's bottom flexible, at the given values.
*
* @param bottom The value of the bottom constraint
*/
- (void)flexibleToBottom:(double)bottom;

/*!
* @brief Set the constraint's left flexible, at the given values.
*
* @param left The value of the left constraint
*/
- (void)flexibleToLeft:(double)left;

/*!
* @brief Set the constraint's right flexible, at the given values.
*
* @param right The value of the right constraint
*/
- (void)flexibleToRight:(double)right;

/*!
* @brief Set the constraint's horizontal flexible, at the given values.
*
* @param horizontal The value of the right constraint
*/
- (void)flexibleWidth:(double)width;

/*!
* @brief Set the constraint's vertical flexible, at the given values.
*
* @param vertical The value of the right constraint
*/
- (void)flexibleHeight:(double)height;

@end
