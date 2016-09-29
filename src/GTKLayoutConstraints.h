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

#ifndef OF_ENUM
#define OF_ENUM(_type, _name) enum _name : _type _name; enum _name : _type
#endif

 /*

Springs and struts are a metaphor for the two kinds of GTKLayoutConstraint:

  - Struts represent a fixed relationship between a view and its parent.

  - Springs represent a flexible relationship between a view and its parent.

Each view has exactly six "points" at which a spring or strut can be defined,
four outer points, one for each cardinal direction, and two inner, one horizontal
and one vertical. These six points define the positioning and resize behavior
of a view within its parent view:

  - If an inner point has a strut, the view's size in that orientation is
	fixed to the strut's value.
  - If an inner point has a spring, the view's size in that orientation is
	free to change to satisfy the other relationships. This can mean using the
	natural size, or resizing the widget to fill the space.
  - If an outer point has a strut, the distance between that edge of the view
	and the matching inner edge of the parent view is fixed to the value of
	the strut.
  - If an outer point has a spring, the distance between that edge of the view
	and the matching inner edge of the parent view is free to change to satisfy
	the other relationships.
  - If the outer points for an axis are both springs, the view is centered in
	its parent view in that axis. The values associated with both springs are
	ignored in this case.
  - If the inner and outer points for an axis are all struts, then the widget
	and its parent cannot be resized on that axis.
  - Satisfying struts is a higher priority than satisfying springs - by definition,
	springs are meant to be flexible.
  - Negative values for constraints are valid; negative inner constraints
	will be treated as "don't care", while negative outer constraints will
	position part or all of a view "outside" the bounds of the superview,
	clipped to the superview's bounds.

In addition to the above, certain facts can be derived or taken as read:

  - If the inner and outer points of a view for a particular axis are all
	springs, the widget's "natural" size is used for its width or height, and it
	is centered in its parent view in that axis.

  - If the outer points of a view for a particular axis are struts, and
	the inner one for that orientation a spring, the widget's size in that axis
	is determined by filling the space left over from satisfying the struts.

  - If the outer points of a view for a particular axis are springs, and the
	inner point is a strut, the strut's size in that axis is the value of the
	inner strut, and its position is to center in the parent view on that axis.

The biggest limitation of this system of layout is that a widget's size and
position are calculated ignoring any other views that may be in the same parent
view. The advantage, however, is that calculating layouts is very much simpler.
This system proved sufficient for NeXTSTEP and OS X prior to Lion; it is not an
unreasonable choice even today.

Both springs and struts can have values associated with them; the meaning of the
value of a strut is generally a number of pixels, while the meaning of a spring's
value is the percentage of the available space in that axis to use as a pixel
value, with the exception that a value of 0 attached to a spring is interpreted
as indicating that any value is acceptable; if 0% is the intended value, a strut
with value 0 is exactly equal to the intended value.

Internally, the position and size of each view is calculated in the form of an
OFRect structure, which is then translated to a GdkRectangle struct for the GTK+
widget the view wraps around. This is accomplished by hooking to the
"get-child-position" signal of the View's internal GtKOverlay with a function
that, for a given GtkWidget, does the following:

  - Get the view for the widget
  - Get the parent view for the view
  - Ask the parent view for an OFRect defining the view's layout with the
	-layoutSubview: method of the parent view.
  - Assign the values from the OFRect to the relevant member variables of the
	supplied GdkRectangle pointer.
  - Return true.

The result of this is the sizing and positioning of the given widget. This will
be called once for each such widget, whenever the window layout might need
updating. It can also be triggered by sending a view the -updateLayout message,
which will emit the get-child-position signal for the relevant GtkOverlay
widget.

The default implementation of -layoutSubview: examines the receiver's width and
height, and calculates a rectangle that satisfies the six constraints of the
argument view in the receiver's coordinate system. GTKWindow's implementation
does the same thing, but in a coordinate space reduced by the amount of vertical
space taken up by the titlebar/toolbar.

This design leaves open the future implementation of a full Autolayout-style
layout engine - all that would need change is the default implementation of
-layoutSubview:, and all the built-in view classes will inherit the new behavior.

*/

typedef OF_ENUM(int, GTKLayoutConstraintType) {
	GTKLayoutConstraintTypeFlexible,
	GTKLayoutConstraintTypeFixed
};

/*!
 * @brief A class whose instances represent layout constraints.
 *
 * The properties of these objects are used in calculating the position and size
 * of views in view hierarchies.
 */
@interface GTKLayoutConstraint: OFObject

- initWithType:(GTKLayoutConstraintType)type
				 value:(double)value;

/*!
 * @brief The type of the constraint, ethere GTKLayoutConstraintTypeFixed or
 * GTKLayoutConstraintTypeFlexible.
 */
@property GTKLayoutConstraintType type;

/*!
 * @brief The value associated with the constraint.
 *
 * The meaning of this value depends on the type of the constraint; for fixed
 * constraints, it represents an offset in pixels; for flexible constraints, it
 * is a percentage value used to calculate a pixel offset. Negative values are
 * valid; in the case of fixed constraint, they can be used to move part of a
 * subview outside the bounds of the parent view (clipped to its space). In the
 * case of flexible constraints, a zero value is interpreted as any value being
 * acceptable. If 0% is actually desired, 0 fixed is mathematically identical.
 */
@property double value;
+ (nullable instancetype)layoutConstraintWithType:(GTKLayoutConstraintType)type
											value:(double)value;
@end

@interface GTKLayoutConstraints: OFObject

/*!
 * @brief The horizontal constraint of the view. This constrains the width of
 * the view.
 */
@property (nonnull, copy) GTKLayoutConstraint *horizontal;

/*!
 * @brief The vertical constraint of the view. This constrains the height of the
 * view.
 */
@property (nonnull, copy) GTKLayoutConstraint *vertical;

/*!
 * @brief The top constraint of this view. This constrains the upper edge of the
 * view relative to the top of its superview.
 */
@property (nonnull, copy) GTKLayoutConstraint *top;

/*!
 * @brief The right constraint of this view. This constrains the right edge of
 * the view relative to the right of its superview.
 */
@property (nonnull, copy) GTKLayoutConstraint *right;

/*!
 * @brief The bottom constraint of this view. This constrains the lower edge of the
 * view relative to the bottom of its superview.
 */
@property (nonnull, copy) GTKLayoutConstraint *bottom;

/*!
 * @brief The left constraint of this view. This constrains the left edge of the
 * view relative to the left of its superview.
 */
@property (nonnull, copy) GTKLayoutConstraint *left;

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

@end
