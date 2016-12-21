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

/*! @file GTKEvent.h */

#import <ObjFW/ObjFW.h>

OF_ASSUME_NONNULL_BEGIN

/*!
 * @brief The types of event a GTKEvent can represent.
 */
typedef enum GTKEventType {
	/*!
	 * @brief A key down event.
	 */
	GTKEventTypeKeyDown,

	/*!
	 * @brief A key up event.
	 */
	GTKEventTypeKeyUp,

	/*!
	 * @brief A mouse down event.
	 */
	GTKEventTypeMouseDown,

	/*!
	 * @brief A mouse up event.
	 */
	GTKEventTypeMouseUp,

	/*!
	 * @brief A mouse clicked event.
	 */

	GTKEventTypeMouseClicked,
	/*!
	 * @brief A mouse drag event.
	 */
	GTKEventTypeMouseDragged
} GTKEventType;

/*!
 * @brief A structure representing the possible modifier keys that can be
 *	  applied to an event.
 */
typedef struct GTKEventKeyboardModifiers {
	/*!
	 * @brief Whether or not the control key is held down.
	 */
	bool control;

	/*!
	 * @brief Whether or not the alt key is held down.
	 */
	bool alt;

	/*!
	 * @brief Whether or not the shift key is held down.
	 */
	bool shift;
} GTKEventKeyboardModifiers;

/*!
 * @brief A class implementing objects which represent an event in the system.
 *
 * It is a general data object, used to represent various kinds of event. As
 * such, it is not likely that all of this object's properties will ever be
 * used at once.
 */
@interface GTKEvent: OFObject

/*!
 * @brief The type of event this object represents.
 */
@property GTKEventType type;

/*!
 * @brief For a mouse event, the button that was pressed.
 */
@property unsigned int mouseButton;

/*!
 * @brief For a mouse event, the number of clicks this event represents; 1, 2,
 *	  or 3.
 */
@property unsigned int clicks;

/*!
 * @brief For a mouse event, the X coordinate of the pointer in the view's
 *	  coordinate space.
 */
@property unsigned int mouseX;

/*!
 * @brief For a mouse event, the Y coordinate of the pointer in the view's
 *	  coordinate space.
 */
@property unsigned int mouseY;

/*!
 * @brief For a mouse drag event, X coordinate of the origin of the movement in
 *	  the view's coordinate space.
 */
@property int originX;

/*!
 * @brief For a mouse drag event, Y coordinate of the origin of the movement in
 *	  the view's coordinate space.
 */
@property int originY;

/*!
 * @brief For a movement event, the change in position on the X axis.
 */
@property double deltaX;

/*!
 * @brief For a movement event, the change in position on the Y axis.
 */
@property double deltaY;

/*!
 * @brief For a movement event, the change in position on the Z axis.
 */
@property double deltaZ;

/*!
 * @brief For a keyboard event, the character the key represents.
 */
@property char character;

/*!
 * @brief The modifier keys applied to the event.
 */
@property GTKEventKeyboardModifiers modifierKeys;
@end

OF_ASSUME_NONNULL_END
