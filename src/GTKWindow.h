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

/*! @file GTKWindow.h */

#import <ObjFW/ObjFW.h>
#import <gtk/gtk.h>

#import "GTKView.h"
#import "GTKWindowDelegate.h"
#import "GTKPopover.h"

OF_ASSUME_NONNULL_BEGIN

/*!
 * @brief A class representing a toplevel window.
 */
@interface GTKWindow: GTKResponder <GTKCoding, OFCopying>
{
	GtkWidget *_window;
	GtkWidget *_headerBar;
	GtkWidget *_headerBarRightSeparator;
	GtkWidget *_headerBarLeftSeparator;
	GtkWidget *_closeButton;
	GtkWidget *_minimizeButton;
	GtkWidget *_maximizeButton;
	GtkWidget *_menuButton;
	GTKView *_titleView;
	OFMutableArray <__kindof GTKView*> *_headerBarStartViews;
	OFMutableArray <__kindof GTKView*> *_headerBarEndViews;
	GTKView *_contentView;
}

/*!
 * @brief The GTKView that holds all this window's subviews.
 */
- (nullable GTKView*)contentView;

/*!
 * @brief The GTKView that holds all this window's subviews.
 */
- (void)setContentView: (nullable GTKView*)view;

/*!
 * @brief The GTKResponder which gets event messages first for this window.
 */
@property (nullable) GTKResponder *firstResponder;

/*!
 * @brief Whether or not this window has a close button.
 */
@property (getter=isCloseButtonHidden) bool closeButtonHidden;

/*!
 * @brief Whether or not this view window has a close button.
 */
@property (getter=isMinimizeButtonHidden) bool minimizeButtonHidden;

/*!
 * @brief Whether or not this window has a close button.
 */
@property (getter=isMaximizeButtonHidden) bool maximizeButtonHidden;

/*!
 * @brief Whether or not this window has a menu button.
 */
@property (getter=isMenuButtonHidden) bool menuButtonHidden;

/*!
 * @brief The delegate object for this window.
 */
@property (weak, nullable) OFObject <GTKWindowDelegate> *delegate;

/*!
 * @brief Whether or not this window is the toplevel input focus.
 */
@property (readonly) bool hasToplevelFocus;

/*!
 * @brief The title of this window.
 */
@property OFString *title;

/*!
 * @brief The subtitle of this window.
 */
@property OFString *subtitle;

/*!
 * @brief The position and size of this window.
 */
@property GTKRect frame;

/*!
 * @brief A boolean indicating whether this window should be hidden from the user.
 */
@property (getter=isHidden) bool hidden;

/*!
 * @brief A bool value indicating whether or not this window should have a
 *	  visible titlebar.
 */
@property bool titleVisible;

/*!
 * @brief The opacity level of this window.
 */
@property double alpha;

/*!
 * @brief A bool value indicating whether or not this window should be
 *	  resizable.
 */
@property (getter=isResizable) bool resizable;

/*!
 * @brief A bool value indicating whether or not this window should be
 *	  destroyed once closed.
 *
 * Once a window is destroyed, all references to it should be treated as
 * invalid.
 */
@property bool destroyWhenClosed;

/*!
 * @brief The GTKPopOver that is shown when the menu button in the window's
 *	  header bar is clicked.
 */
@property GTKPopover *menuButtonPopOver;

/*!
 * @brief An optional GTKView which can replace the default title and subtitle.
 */
@property (nullable) GTKView *titleView;

/*!
 * @brief Hide the window from the user. This does not destroy the window
 *	  unless the window's destroyWhenClosed property is true.
 */
- (void)close;

/*!
 * @brief Destroys the window. Once a window is destroyed, all references to it
 *	  should be treated as invalid.
 */
- (void)destroy;

/*!
 * @brief Minimize the window.
 */
- (void)minimize;

/*!
 * @brief Maximize the window.
 */
- (void)maximize;

/*!
 * @brief Adds a GTKView to the header bar, after the left separator (which is
 *	  only shown if any of the system-provided buttons on the left are
 *	  shown).
 */
- (void)addViewToHeaderBarStart: (GTKView*)view;

/*!
 * @brief Removes the specified view from the header bar.
 */
- (void)removeViewFromHeaderBar: (GTKView*)view;

/*!
 * @brief Adds a GTKView to the header bar, before the right separator (which
 *	  is only shown if any of the system-provided buttons on the right are
 *	  shown).
 */
- (void)addViewToHeaderBarEnd: (GTKView*)view;

- (void)createContentView;
@end

OF_ASSUME_NONNULL_END
