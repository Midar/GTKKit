/*! @file GTKApplication.h
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

#import "GTKResponder.h"
#import "GTKApplicationDelegate.h"
#import "GTKDispatchQueue.h"

extern _Nonnull of_thread_t      gtkkit_objfw_thread;
extern _Nonnull of_thread_t      gtkkit_gtk_thread;
extern const    of_thread_attr_t gtkkit_objfw_thread_attr;

@class GTKApplication;

extern GTKApplication * _Nonnull GTKApp;

@interface GTKStandardDispatchQueues: OFObject
@property (nonnull) GTKDispatchQueue *main;
@property (nonnull) GTKDispatchQueue *background;
@property (nonnull) GTKDispatchQueue *gtk;
+ (nonnull GTKStandardDispatchQueues *)sharedQueues;
@end

/*!
 * @brief A class representing the application as a whole. The shared instance
 * of this class, available from the constant GTKApp, is responsible for setting
 * up, tearing down, and managing the overall flow of the application.
 */
@interface GTKApplication: GTKResponder

/*!
 * @brief An object which exposes the three standard GTKDispatchQueue instances
 * baked into each application: dispatch.main for the main thread, dispatch.gtk
 * for the thread in which GTK+ runs its main loop, and dispatch.background for
 * the default background queue. The easy way to get these is through the GTKApp
 * global constant.
 */
@property (nonnull) GTKStandardDispatchQueues *dispatch;

/*!
 * @brief The application delegate. This can be of any class that implements the
 * GTKApplicationDelegate protocol.
 */
@property (nullable) id<GTKApplicationDelegate> delegate;

/*!
 * @brief The view controller representing the current key window, if there is
 * one.
 */
@property (nullable, readonly) GTKViewController *keyWindow;

/*!
 * @brief The object which is the current first responder.
 */
@property (nonnull) GTKResponder *firstResponder;
@property int * _Nonnull argc;
@property char * _Nonnull * _Nonnull * _Nonnull argv;
@property (nonnull) Class delegateClass;

/*!
 * @brief The shared instance of GTKApplication.
 */
+ (nonnull instancetype)sharedApplication;
- (void)startup;

/*!
 * @brief Tell the application to terminate itself.
 */
- (void)terminate;

/*!
 * @brief Tell the application to start the GTK+ main loop.
 */
- (void)run;

/*!
 * @brief Tell the application to stop the GTK+ main loop.
 */
- (void)stop;
@end
