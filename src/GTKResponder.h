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

/*! @file GTKResponder.h */

#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>

#import "GTKEvent.h"

OF_ASSUME_NONNULL_BEGIN

/*!
 * @brief An object which can respond to events.
 *
 * GTKResponder is the parent class for objects which respond to events being
 * propagated through the responder chain, which is a list of objects which can
 * handle events. The default behaviour for each event method is to do simply
 * pass the event on to the next object in the chain if there is one, or to do
 * nothing otherwise. Subclasses implement their own custom behaviours atop
 * that.
 *
 * The responder chain is defined as the chain of objects, beginning with the
 * "first responder", proceeding through the objects pointed to by the
 * nextResponder property of each responder object in turn. Thus, the chain
 * will consist of different objects depending on which object is currently the
 * first responder.
 *
 * Each responder object is responsible for consuming and, if appropriate,
 * forwarding each event it recieves up the responder chain; most of the time,
 * this will simply involve re-sending the recieved message to the
 * nextResponder object if it exists.
 * This is the default implementation of all event messages, so responders do
 * not need to do anything special to handle that case. Thus, each respnder
 * class need only override those event messages it is immediately concerned
 * with -- for example, GTKButton might do well to override the -mouseUp: and
 * -mouseDown: methods, and perhaps the -keyDown: method to check for "enter"
 * presses and pass other keys up the chain.
 */
@interface GTKResponder: OFObject
/*!
 * @brief The next object in the responder chain, if any.
 */
@property (nullable, weak) GTKResponder *nextResponder;

/*!
 * @brief Whether or not an object can become first responder.
 *
 * The default implementation of this property returns false; subclasses must
 * override that implementation if they wish to become first responder.
 */
@property (readonly) bool canBecomeFirstResponder;

/*!
 * @brief Tell the view to try to become first responder.
 */
- (void)becomeFirstResponder;

/*!
 * @brief Respond to a mouse button being pressed.
 *
 * @param event A GTKEvent instance containing information about the event.
 */
- (void)mouseDown: (GTKEvent*)event;

/*!
 * @brief Respond to a mouse button being released.
 *
 * @param event A GTKEvent instance containing information about the event.
 */
- (void)mouseUp: (GTKEvent*)event;

/*!
 * @brief Respond to a mouse button being clicked.
 *
 * @param event A GTKEvent instance containing information about the event.
 */
- (void)mouseClicked: (GTKEvent*)event;

/*!
 * @brief Respond to a mouse drag event.
 *
 * @param event A GTKEvent instance containing information about the event.
 */
- (void)mouseDragged: (GTKEvent*)event;

/*!
 * @brief Respond to the scroll wheel being moved.
 *
 * @param event A GTKEvent instance containing information about the event.
 */
- (void)scrollWheel: (GTKEvent*)event;

/*!
 * @brief Respond to the mouse entering the view's on-screen rectangle.
 *
 * @param event A GTKEvent instance containing information about the event.
 */
- (void)mouseEntered: (GTKEvent*)event;

/*!
 * @brief Respond to the mouse leaving the view's on-screen rectangle.
 *
 * @param event A GTKEvent instance containing information about the event.
 */
- (void)mouseLeft: (GTKEvent*)event;

/*!
 * @brief Respond to a key bring pressed.
 *
 * @param event A GTKEvent instance containing information about the event.
 */
- (void)keyDown: (GTKEvent*)event;

/*!
 * @brief Respond to a key being released.
 *
 * @param event A GTKEvent instance containing information about the event.
 */
- (void)keyUp: (GTKEvent*)event;

/*!
 * @brief Respond to the modifier-key state being changed.
 *
 * @param event A GTKEvent instance containing information about the event.
 */
- (void)modifierKeysChanged: (GTKEvent*)event;

/*!
 * @brief Attempt to perform a given command.
 *
 * @param selector The selector of the command to attempt.
 */
- (void)doCommandBySelector: (SEL)selector;

/*!
 * @brief If this responder responds to the message given by SEL, send it that
 *	  message with the given argument.
 *
 * @param action The selector of the message to attempt to send.
 * @param object The object to use as the argument to the message.
 *
 * @returns true if the message was sent, false otherwise.
 */
- (bool)tryToPerform: (SEL)action
		with: (id)object;

/*!
 * @brief If this responder responds to the message given by SEL, send it that
 *	  message.
 *
 * @param action The selector of the message to attempt to send.
 *
 * @returns true if the message was sent, false otherwise.
 */
- (bool)tryToPerform: (SEL)action;

/*!
 * @brief Respond to the view being told that it will be rendered on-screen.
 */
- (void)willBecomeMapped;

/*!
 * @brief Respond to the view being told that it was rendered on-screen.
 */
- (void)didBecomeMapped;

/*!
 * @brief Respond to the view being told that it will be removed from the screen.
 */
- (void)willBecomeUnmapped;

/*!
 * @brief Respond to the veiw being told that it was removed from the screen.
 */
- (void)didBecomeUnmapped;

/*!
 * @brief Ask the responder if it should become the first responder.
 *
 * @returns true if the object should become the first responder, false
 *	    otherwise.
 */
- (bool)shouldBecomeFirstResponder;

/*!
 * @brief Respond to the responder being told that it is going to become the
 *	  first responder.
 */
- (void)willBecomeFirstResponder;

/*!
 * @brief Respond to the responder being told that it just became the first
 *	  responder.
 */
- (void)didBecomeFirstResponder;

/*!
 * @brief Ask the object if it should stop being the first responder.
 *
 * @returns true if the object should stop being the first responder, false
 *	    otherwise.
 */
- (bool)shouldResignFirstResponder;

/*!
 * @brief Respond to the object being told that it is about to stop being the
 *	  first responder.
 */
- (void)willResignFirstResopnder;

/*!
 * @brief Respond to the object being told that it is no longer the first
 *	  responder.
 */
- (void)didResignFirstResponder;
@end

OF_ASSUME_NONNULL_END
