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

#import "GTKResponder.h"

@implementation GTKResponder

// Override the default behavior, to try forwarding to the next responder in
// the chain.
- (id)forwardingTargetForSelector:(SEL)selector
{
    if (nil == self.nextResponder) {
        return [super forwardingTargetForSelector: selector];
    }

    return self.nextResponder;
}

- (bool)canBecomeFirstResponder
{
    return false;
}

- (void)willBecomeMapped
{
    [self.nextResponder tryToPerform: @selector(willBecomeMapped:)];
}

- (void)didBecomeMapped
{
    [self.nextResponder tryToPerform: @selector(didBecomeMapped:)];
}

- (void)willBecomeUnmapped
{
    [self.nextResponder tryToPerform: @selector(willBecomeUnmapped:)];
}

- (void)didBecomeUnmapped
{
    [self.nextResponder tryToPerform: @selector(didBecomeUnmapped:)];
}

- (bool)shouldBecomeFirstResponder
{
    return false;
}

- (void)willBecomeFirstResponder
{
    [self.nextResponder tryToPerform: @selector(willBecomeFirstResponder:)];
}

- (void)didBecomeFirstResponder
{
    [self.nextResponder tryToPerform: @selector(didBecomeFirstResponder:)];
}

- (bool)shouldResignFirstResponder
{
    return true;
}

- (void)willResignFirstResopnder
{
    [self.nextResponder tryToPerform: @selector(willResignFirstResopnder:)];
}

- (void)didResignFirstResponder
{
    [self.nextResponder tryToPerform: @selector(didResignFirstResponder:)];
}

- (void)mouseDown:(nonnull GTKEvent*)event
{
    [self.nextResponder tryToPerform: @selector(mouseDown:)
                                with: event];
}

- (void)mouseUp:(nonnull GTKEvent*)event
{
    [self.nextResponder tryToPerform: @selector(mouseUp:)
                                with: event];
}

- (void)scrollWheel:(nonnull GTKEvent*)event
{
    [self.nextResponder tryToPerform: @selector(scrollWheel:)
                                with: event];
}

- (void)mouseEntered:(nonnull GTKEvent*)event
{
    [self.nextResponder tryToPerform: @selector(mouseEntered:)
                                with: event];
}

- (void)mouseLeft:(nonnull GTKEvent*)event
{
    [self.nextResponder tryToPerform: @selector(mouseLeft:)
                                with: event];
}

- (void)keyDown:(nonnull GTKEvent*)event
{
    [self.nextResponder tryToPerform: @selector(keyDown:)
                                with: event];
}

- (void)keyUp:(nonnull GTKEvent*)event
{
    [self.nextResponder tryToPerform: @selector(keyUp:)
                                with: event];
}

- (void)modifierKeysChanged:(nonnull GTKEvent*)event
{
    [self.nextResponder tryToPerform: @selector(modifierKeysChanged:)
                                with: event];
}

- (void)doCommandBySelector:(SEL)selector
{
    if ([self respondsToSelector: selector]) {
        IMP imp = [self methodForSelector:selector];
        void (*func)(id, SEL) = (void *)(imp);
        func(self, selector);
    }
}

- (bool)tryToPerform:(SEL)action
                with:(nonnull id)object
{
    if ([self respondsToSelector: action]) {
        [self performSelector: action
                   withObject: object
                   afterDelay: 0.0];
        return true;
    }
    return false;
}

- (bool)tryToPerform:(SEL)action
{
    if ([self respondsToSelector: action]) {
        IMP imp = [self methodForSelector:action];
        void (*func)(id, SEL) = (void *)(imp);
        func(self, action);
        return true;
    }
    return false;
}
@end
