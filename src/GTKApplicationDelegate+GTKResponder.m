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
#import "GTKApplicationDelegate.h"
#import "GTKResponderProtocol.h"
#import "OFCallback.h"


@implementation GTKApplicationDelegate (GTKResponder)
- (GTKResponder *)firstResponder
{
    return self.keyWindow.firstResponder;
}

- (id<GTKResponderProtocol>)nextResponder
{
    return nil;
}

// Override the default behavior, to try forwarding to the next responder in
// the chain.
- (id)forwardingTargetForSelector:(SEL)selector
{
    return [super forwardingTargetForSelector: selector];
}

- (bool)canBecomeFirstResponder
{
    return false;
}

- (void)willBecomeMapped
{
    // Do nothing.
}

- (void)didBecomeMapped
{
    // Do nothing.
}

- (void)willBecomeUnmapped
{
    // Do nothing.
}

- (void)didBecomeUnmapped
{
    // Do nothing.
}

- (bool)shouldBecomeFirstResponder
{
    return false;
}

- (void)willBecomeFirstResponder
{
    // Do nothing.
}

- (void)didBecomeFirstResponder
{
    // Do nothing.
}

- (bool)shouldResignFirstResponder
{
    return true;
}

- (void)willResignFirstResopnder
{
    // Do nothing.
}

- (void)didResignFirstResponder
{
    // Do nothing.
}

- (void)mouseDown:(nonnull GTKEvent*)event
{
    // Do nothing.
}

- (void)mouseUp:(nonnull GTKEvent*)event
{
    // Do nothing.
}

- (void)mouseClicked:(nonnull GTKEvent*)event
{
    // Do nothing.
}

- (void)scrollWheel:(nonnull GTKEvent*)event
{
    // Do nothing.
}

- (void)mouseEntered:(nonnull GTKEvent*)event
{
    // Do nothing.
}

- (void)mouseLeft:(nonnull GTKEvent*)event
{
    // Do nothing.
}

- (void)keyDown:(nonnull GTKEvent*)event
{
    // Do nothing.
}

- (void)keyUp:(nonnull GTKEvent*)event
{
    // Do nothing.
}

- (void)modifierKeysChanged:(nonnull GTKEvent*)event
{
    // Do nothing.
}

- (void)doCommandBySelector:(SEL)selector
{

}

- (bool)tryToPerform:(SEL)action
                with:(nonnull id)object
{
    return true;
}

- (bool)tryToPerform:(SEL)action
{
    return true;
}
@end