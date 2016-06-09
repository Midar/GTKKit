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

#import "GTKWindow.h"

static gboolean
window_state_event_dispatch(GtkWidget *window, GdkEventWindowState *event,
    GTKWindow *sender)
{
  // This code determines the type of window event which has happened, and
  // dispatches to the appropriate delegate method, if it exists.

  if(event->changed_mask & GDK_WINDOW_STATE_MAXIMIZED){
    if(event->new_window_state & GDK_WINDOW_STATE_MAXIMIZED) {
      if( [sender.delegate
              respondsToSelector: @selector(windowDidMaximize:)] ) {
        [sender.delegate windowDidMaximize: sender];
      }
    } else {
      if( [sender.delegate
              respondsToSelector: @selector(windowDidUnmaximize:)] ) {
        [sender.delegate windowDidUnmaximize: sender];
      }
    }
  }

  if(event->changed_mask & GDK_WINDOW_STATE_ICONIFIED) {
    if(event->new_window_state & GDK_WINDOW_STATE_ICONIFIED) {
      if( [sender.delegate
              respondsToSelector: @selector(windowDidMinimize:)] ) {
        [sender.delegate windowDidMinimize: sender];
      }
    } else {
      if( [sender.delegate
              respondsToSelector: @selector(windowDidUnminimize:)] ) {
        [sender.delegate windowDidUnminimize: sender];
      }
    }
  }

  if(event->changed_mask & GDK_WINDOW_STATE_FULLSCREEN) {
    if(event->new_window_state & GDK_WINDOW_STATE_FULLSCREEN) {
      if( [sender.delegate
              respondsToSelector: @selector(windowDidFullscreen:)] ) {
        [sender.delegate windowDidFullscreen: sender];
      }
    } else {
      if( [sender.delegate
              respondsToSelector: @selector(windowDidUnfullscreen:)] ) {
        [sender.delegate windowDidUnfullscreen: sender];
      }
    }
  }

  if(event->changed_mask & GDK_WINDOW_STATE_FOCUSED) {
    if(event->new_window_state & GDK_WINDOW_STATE_FOCUSED) {
      if( [sender.delegate
              respondsToSelector: @selector(windowDidFocus:)] ) {
        [sender.delegate windowDidFocus: sender];
      }
    } else {
      if( [sender.delegate
              respondsToSelector: @selector(windowDidUnfocus:)] ) {
        [sender.delegate windowDidUnfocus: sender];
      }
    }
  }

  return TRUE;
}

static gboolean
window_delete_request(GtkWidget *window, GdkEvent *event, GTKWindow *sender)
{
  if ([sender.delegate respondsToSelector: @selector(windowShouldClose:)]) {
    if ([sender.delegate windowShouldClose: sender]) {
      if ([sender.delegate respondsToSelector: @selector(windowWillClose:)])
        [sender.delegate windowWillClose: sender];
      return FALSE;
    } else {
      return TRUE;
    }
  } else {
    if ([sender.delegate respondsToSelector: @selector(windowWillClose:)]) {
      [sender.delegate windowWillClose: sender];
    }
    return FALSE;
  }
}

@implementation GTKWindow
- (id)init
{
  self = [super init];
  self.widget = gtk_window_new(GTK_WINDOW_TOPLEVEL);
  g_object_set_data(G_OBJECT(self.widget), "_GTKKIT_WRAPPER_WIDGET_",
      (__bridge void*) self);
  g_signal_connect(G_OBJECT (self.widget), "window-state-event",
      G_CALLBACK (window_state_event_dispatch), (__bridge void*) self);
  g_signal_connect(G_OBJECT (self.widget), "delete-event",
      G_CALLBACK (window_delete_request), (__bridge void*) self);
  return self;
}

- (of_dimension_t)defaultSize
{
  return _defaultSize;
}

- (void)setDefaultSize:(of_dimension_t)size
{
  _defaultSize = size;
  gtk_window_set_default_size (GTK_WINDOW (self.widget), (int) size.width,
      (int) size.height);
}

- (of_dimension_t)size
{
  return _size;
}

- (void)setSize:(of_dimension_t)size
{
  _size = size;
  gtk_window_resize (GTK_WINDOW (self.widget), (int) size.width,
      (int) size.height);
}
@end
