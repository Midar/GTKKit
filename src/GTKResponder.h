/*! @file GTKResponder.h
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
#import "GTKResponderProtocol.h"

/*!
 * @brief An object which can respond to events.
 *
 * GTKResponder is the parent class for objects which respond to events being
 * propagated through the responder chain, which is a list of objects which can
 * handle events. The default behaviour for each event method is to do simply
 * pass the event on to the next object in the chain if there is one, or to do
 * nothing otherwise. Subclasses implement their own custom behaviours atop that.
 *
 * The responder chain is defined as the chain of objects, beginning with the
 * "first responder", proceeding through the objects pointed to by the nextResponder
 * property of each responder object in turn. Thus, the chain will consist of
 * different objects depending on which object is currently the first responder.

 * Each responder object is responsible for consuming and, if appropriate, forwarding
 * each event it recieves up the responder chain; most of the time, this will simply
 * involve re-sending the recieved message to the nextResponder object if it exists.
 * This is the default implementation of all event messages, so responders do not
 * need to do anything special to handle that case. Thus, each respnder class need
 * only override those event messages it is immediately concerned with -- for example,
 * GTKButton might do well to override the -mouseUp: and -mouseDown: methods, and
 * perhaps the -keyDown: method to check for "enter" presses and pass other keys up
 * the chain.
 */
@interface GTKResponder: OFObject <GTKResponderProtocol>
/*!
 * @brief The next object in the responder chain, if any.
 */
@property (nullable, weak) id<GTKResponderProtocol> nextResponder;
@end
