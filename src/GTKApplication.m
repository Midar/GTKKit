/*! @file GTKApplication.m
 *
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

#import "GTKApplication.h"
#import "GTKApplicationDelegate.h"
#import "GTKWindow.h"

GTKApplication * _Nonnull GTKApp = nil;

of_thread_t gtkkit_gtk_thread;
of_thread_t gtkkit_objfw_thread;
const of_thread_attr_t gtkkit_objfw_thread_attr;

static void
gtkkit_application_main(GTKApplication *app)
{
    of_application_main(app.argc, app.argv, [app.delegateClass class]);
}

@implementation GTKStandardDispatchQueues
- init
{
    self = [super init];
    self.main = GTKDispatchQueue.main;
    self.background = GTKDispatchQueue.background;
    self.gtk = GTKDispatchQueue.gtk;
    return self;
}

+ (instancetype)sharedQueues
{
    static GTKStandardDispatchQueues *sharedQueues;
    if (sharedQueues == nil) {
        sharedQueues = [self new];
    }
    return sharedQueues;
}
@end

@implementation GTKApplication
- init
{
    self = [super init];
    self.dispatch = GTKStandardDispatchQueues.sharedQueues;
    return self;
}

- (GTKWindow *)keyWindow
{
    for (GTKWindow *window in self.windows) {
        if (window.hasToplevelFocus) {
            return window;
        }
    }
    return nil;
}

+ (instancetype)sharedApplication
{
    static GTKApplication *sharedApplication;
    if (nil == sharedApplication) {
        sharedApplication = [self new];
    }
    return sharedApplication;
}

- (int * _Nonnull)argc
{
    return _argc;
}

- (void)setArgc:(int * _Nonnull)argc
{
    if (_argc == NULL) {
        _argc = argc;
    }
}

- (char * _Nonnull * _Nonnull * _Nonnull)argv
{
    return _argv;
}

- (void)setArgv:(char * _Nonnull * _Nonnull * _Nonnull)argv
{
    if (_argv == NULL) {
        _argv = argv;
    }
}

- (void)terminate
{
    if ([self.delegate respondsToSelector: @selector(applicationShouldTerminate)]) {
        if (![self.delegate applicationShouldTerminate]) {
            return;
        }
    }
    [self stop];
    [OFApplication terminate];
}

- (void)startup
{
    gtkkit_gtk_thread = of_thread_current();
    gtk_init(self.argc, self.argv);
    of_thread_new(
        &gtkkit_objfw_thread,
        &gtkkit_application_main,
        self,
        &gtkkit_objfw_thread_attr);
	self.delegate =
		(id<GTKApplicationDelegate>)(OFApplication.sharedApplication.delegate);
}

- (void)run
{
    gtk_main();
}

- (void)stop
{
    gtk_main_quit();
}

- (id)forwardingTargetForSelector:(SEL)selector
{
    return [super forwardingTargetForSelector: selector];
}

- (void)becomeFirstResponder
{
    // Default implementation does nothing.
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

- (void)mouseDragged:(nonnull GTKEvent*)event
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
@end
