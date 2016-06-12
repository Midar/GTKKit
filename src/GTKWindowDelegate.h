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

@class GTKWindow;

/*!
 * @brief A protocol for objects which act as delegates for @ref GTKWindow
 * objects. All the methods in this protocol are optional.
 */
@protocol GTKWindowDelegate <OFObject>

@optional

/*!
 * @brief This will be sent to the delegate when the window is told to close;
 * if it returns true, the window will close, otherwise it will not.
 */
- (bool)windowShouldClose: (GTKWindow *)sender;

/*!
 * @brief This will be sent to the delegate when it has been determined that
 * the window should close, just before the actual closing is done.
 */
- (void)windowWillClose: (GTKWindow *)sender;

// This will be sent to the delegate when the window has actually been closed.
- (void)windowDidClose: (GTKWindow *)sender;

// This will be sent to the delegate when the window is sent the minimize
// message, before the actual minimizing happens. If this returns true,
// the minimizing will then happen, otherwise it will not.
- (bool)windowShouldMinimize: (GTKWindow *)sender;

// This will be sent to the delegate when it has been determined that the
// window should be minimized, but before the minimizing actually happens.
- (void)windowWillMinimize: (GTKWindow *)sender;

// This will be sent to the delegate immediately after the window has actually
// been minimized.
- (void)windowDidMinimize: (GTKWindow *)sender;

// This will be sent to the delegate immediately after the window has actually
// been minimized.
- (void)windowDidUnminimize: (GTKWindow *)sender;

// This will be sent to the delegate when the window is sent the maximize
// message, before the actual maximizing happens. If this returns true,
// the maximizing will then happen, otherwise it will not.
- (bool)windowShouldMaximize: (GTKWindow *)sender;

// This will be sent to the delegate when it has been determined that the
// window should be maximized, but before the maximizing actually happens.
- (void)windowWillMaximize: (GTKWindow *)sender;

// This will be sent to the delegate immediately after the window has actually
// been maximized.
- (void)windowDidMaximize: (GTKWindow *)sender;

// This will be sent to the delegate immediately after the window has actually
// been unmaximized.
- (void)windowDidUnmaximize: (GTKWindow *)sender;

// This will be sent to the delegate immediately after the window has actually
// been made fullscreen.
- (void)windowDidFullscreen: (GTKWindow *)sender;

// This will be sent to the delegate immediately after the window has actually
// been made non-fullscreen.
- (void)windowDidUnfullscreen: (GTKWindow *)sender;

// This will be sent to the delegate immediately after the window has actually
// been focused.
- (void)windowDidFocus: (GTKWindow *)sender;

// This will be sent to the delegate immediately after the window has actually
// been unfocused.
- (void)windowDidUnfocus: (GTKWindow *)sender;

@end
