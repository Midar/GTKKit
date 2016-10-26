/*! @file GTKWindowViewController.h
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

#import "GTKViewController.h"
#import "GTKView.h"
#import "GTKWindowViewControllerDelegate.h"
#import "GTKPopOverViewController.h"

/*!
 * @brief A class representing a view controller that manages a toplevel
 * window and its view hierarchy.
 */
@interface GTKWindowViewController: GTKViewController
{
    __block GtkWidget *_window;
    __block GtkWidget *_headerBar;
    __block GtkWidget *_headerBarRightSeparator;
    __block GtkWidget *_headerBarLeftSeparator;
    __block GtkWidget *_closeButton;
    __block gulong     _closeButtonClickedHandlerID;
    __block GtkWidget *_minimizeButton;
    __block gulong     _minimizeButtonClickedHandlerID;
    __block GtkWidget *_maximizeButton;
    __block gulong     _maximizeButtonClickedHandlerID;
    __block GtkWidget *_menuButton;
    __block gulong     _menuButtonClickedHandlerID;
}

/*!
 * @brief Whether or not this view controller's window has a close button.
 */
@property (getter=isCloseButtonHidden) bool closeButtonHidden;

/*!
 * @brief Whether or not this view controller's window has a close button.
 */
@property (getter=isMinimizeButtonHidden) bool minimizeButtonHidden;

/*!
 * @brief Whether or not this view controller's window has a close button.
 */
@property (getter=isMaximizeButtonHidden) bool maximizeButtonHidden;

/*!
 * @brief Whether or not this view controller's window has a menu button.
 */
@property (getter=isMenuButtonHidden) bool menuButtonHidden;

/*!
 * @brief The delegate of this window.
 */
@property (weak, nullable) OFObject<GTKWindowViewControllerDelegate> *delegate;

/*!
 * @brief Whether or not this view controller's window is the toplevel input focus.
 */
@property (readonly) bool hasToplevelFocus;

/*!
 * @brief The title of the window this view controller manages.
 */
@property (nonnull) OFString *title;

/*!
 * @brief The subtitle of the window this view controller manages.
 */
@property (nonnull) OFString *subtitle;

/*!
 * @brief The position and size of this view controller's window.
 */
@property GTKRect frame;

/*!
 * @brief A boolean indicating whether this view controller's window should be
 * visible to the user.
 */
@property (getter=isHidden) bool hidden;

/*!
 * @brief A bool value indicating whether or not the window
 * this view manages should have a visible titlebar.
 */
@property bool titleVisible;

/*!
 * @brief The opacity level of the window managed by the view controller.
 */
@property double alpha;

/*!
 * @brief A bool value indicating whether or not the window should be
 * resizable.
 */
@property (getter=isResizable) bool resizable;

/*!
 * @brief A bool value indicating whether or not the window should be
 * resizable. Once a window is destroyed, all references to it should be
 * treated as invalid.
 */
@property bool destroyWhenClosed;

@property (nonnull) GTKPopOverViewController *menuButtonPopOver;

/*!
 * @brief Hide the window from the user. This does not destroy the window.
 */
- (void)close;

/*!
 * @brief Destroys the window. Once a window is destroyed, all references to it
 * should be treated as invalid.
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
@end
