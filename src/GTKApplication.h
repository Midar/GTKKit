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

#import "defines.h"
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

@interface GTKApplication: GTKResponder
@property (nonnull) GTKStandardDispatchQueues *dispatch;
@property (nullable) id<GTKApplicationDelegate> delegate;
@property (nullable, readonly) GTKViewController *keyWindow;
@property (nonnull) GTKResponder *firstResponder;
@property int * _Nonnull argc;
@property char * _Nonnull * _Nonnull * _Nonnull argv;
@property (nonnull) Class delegateClass;
+ (nonnull instancetype)sharedApplication;
- (void)startup;
- (void)terminate;
- (void)run;
- (void)stop;
@end
