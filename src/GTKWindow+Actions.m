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

#import "GTKContainer.h"
#import "GTKWindow.h"
#import "GTKWindow+Actions.h"

@implementation GTKWindow (Actions)
- (void)present
{
  gtk_window_present(GTK_WINDOW(self.widget));
}

- (bool)activateDefaultWidget
{
  return gtk_window_activate_default(GTK_WINDOW(self.widget));
}

- (bool)activateFocusedWidget
{
  return gtk_window_activate_focus(GTK_WINDOW(self.widget));
}

- (void)close
{
  if ([self.delegate respondsToSelector: @selector(windowShouldClose:)] &&
      [self.delegate windowShouldClose: self]) {
    if ([self.delegate respondsToSelector: @selector(windowWillClose:)])
      [self.delegate windowWillClose: self];
    gtk_window_close(GTK_WINDOW(self.widget));
  }
}

- (void)minimize
{
  if ([self.delegate respondsToSelector: @selector(windowShouldMinimize:)] &&
      [self.delegate windowShouldMinimize: self]) {
    if ([self.delegate respondsToSelector:
        @selector(windowWillMinimize:)])
      [self.delegate windowWillMinimize:self];
    gtk_window_iconify(GTK_WINDOW(self.widget));
  }
}

- (void)unminimize
{
  gtk_window_deiconify (GTK_WINDOW (self.widget));
}

- (void)maximize
{
  if ([self.delegate respondsToSelector: @selector(windowShouldMaximize:)] &&
      [self.delegate windowShouldMaximize: self]) {
    if ([self.delegate respondsToSelector:
        @selector(windowWillMaximize:)])
      [self.delegate windowWillMaximize:self];
    gtk_window_maximize(GTK_WINDOW(self.widget));
  }
}

- (void)unmaximize
{
  gtk_window_maximize(GTK_WINDOW(self.widget));
}

- (void)fullscreen
{
  gtk_window_fullscreen(GTK_WINDOW(self.widget));
}

- (void)unfullscreen
{
  gtk_window_unfullscreen(GTK_WINDOW(self.widget));
}
@end
