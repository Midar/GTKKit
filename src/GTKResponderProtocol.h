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

#import "defines.h"
#import "GTKEvent.h"

@protocol GTKResponderProtocol
/*!
 * @brief The next object in the responder chain, if any.
 */
@property (nullable, weak) id<GTKResponderProtocol> nextResponder;

/*!
 * @brief Whether or not an object can become first responder. The default
 * implementation of this property returns false; subclasses must override
 * that implementation if they wish to become first responder.
 */
@property (readonly) bool canBecomeFirstResponder;

/*!
 * @brief Respond to a mouse button being pressed.
 *
 * @param event A GTKEvent instance containing information about the event.
 */
- (void)mouseDown:(nonnull GTKEvent *)event;

/*!
 * @brief Respond to a mouse button being released.
 *
 * @param event A GTKEvent instance containing information about the event.
 */
- (void)mouseUp:(nonnull GTKEvent*)event;

/*!
 * @brief Respond to the scroll wheel being moved.
 *
 * @param event A GTKEvent instance containing information about the event.
 */
- (void)scrollWheel:(nonnull GTKEvent*)event;

/*!
 * @brief Respond to the mouse entering the view's on-screen rectangle.
 *
 * @param event A GTKEvent instance containing information about the event.
 */
- (void)mouseEntered:(nonnull GTKEvent*)event;

/*!
 * @brief Respond to the mouse leaving the view's on-screen rectangle.
 *
 * @param event A GTKEvent instance containing information about the event.
 */
- (void)mouseLeft:(nonnull GTKEvent*)event;

/*!
 * @brief Respond to a key bring pressed.
 *
 * @param event A GTKEvent instance containing information about the event.
 */
- (void)keyDown:(nonnull GTKEvent*)event;

/*!
 * @brief Respond to a key being released.
 *
 * @param event A GTKEvent instance containing information about the event.
 */
- (void)keyUp:(nonnull GTKEvent*)event;

/*!
 * @brief Respond to the modifier-key state being changed.
 *
 * @param event A GTKEvent instance containing information about the event.
 */
- (void)modifierKeysChanged:(nonnull GTKEvent*)event;

/*!
 * @brief Attempt to perform a given command.
 *
 * @param selector The selector of the command to attempt.
 */
- (void)doCommandBySelector:(_Nonnull SEL)selector;

/*!
 * @brief If this responder responds to the message given by SEL, send it
 * that message with the given argument.
 *
 * @param action The selector of the message to attempt to send.
 * @param object The object to use as the argument to the message.
 *
 * @returns true if the message was sent, false otherwise.
 */
- (bool)tryToPerform:(_Nonnull SEL)action
                with:(nonnull id)object;

/*!
 * @brief If this responder responds to the message given by SEL, send it
 * that message.
 *
 * @param action The selector of the message to attempt to send.
 *
 * @returns true if the message was sent, false otherwise.
 */
- (bool)tryToPerform:(_Nonnull SEL)action;

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
 * @returns true if the object should become the first responder, false otherwise.
 */
- (bool)shouldBecomeFirstResponder;

/*!
 * @brief Respond to the responder being told that it is going to become the first responder.
 */
- (void)willBecomeFirstResponder;

/*!
 * @brief Respond to the responder being told that it just became the first responder.
 */
- (void)didBecomeFirstResponder;

/*!
 * @brief Ask the object if it should stop being the first responder.
 *
 * @returns true if the object should stop being the first responder, false otherwise.
 */
- (bool)shouldResignFirstResponder;

/*!
 * @brief Respond to the object being told that it is about to stop being the first responder.
 */
- (void)willResignFirstResopnder;

/*!
 * @brief Respond to the object being told that it is no longer the first responder.
 */
- (void)didResignFirstResponder;

@end
