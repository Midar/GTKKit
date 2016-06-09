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
#import "GTKWindow+Properties.h"

@implementation GTKWindow (Properties)
- (void)setTitle:(OFString * _Nonnull)title
{
  const char * newTitle = [title UTF8String];
  gtk_window_set_title(GTK_WINDOW (self.widget), newTitle);
}

- (OFString * _Nonnull)title
{
  const char *title = gtk_window_get_title (GTK_WINDOW (self.widget));
  return [OFString stringWithUTF8String: title];
}

- (void)setResizable:(bool)resizable
{
  gtk_window_set_resizable (GTK_WINDOW (self.widget), resizable);
}

- (bool)resizable
{
  return gtk_window_get_resizable (GTK_WINDOW (self.widget));
}

- (void)width:(int)width height:(int)height
{
  gtk_window_resize (GTK_WINDOW (self.widget), width, height);
}

- (bool)modal
{
  return gtk_window_get_modal (GTK_WINDOW (self.widget));
}

- (void)setModal:(bool)modal
{
  gtk_window_set_modal (GTK_WINDOW (self.widget), modal);
}

- (of_point_t)position
{
  int x;
  int y;
  gtk_window_get_position (GTK_WINDOW (self.widget), &x, &y);
  return of_point (x, y);
}

- (void)setPosition:(of_point_t)position
{
  gtk_window_move (GTK_WINDOW (self.widget), position.x, position.y);
}

- (void)setTransientForWindow:(GTKWindow *)window
{
  gtk_window_set_transient_for (GTK_WINDOW (self.widget),
      GTK_WINDOW ([window widget]));
}

- (void)setAttachedToWindow:(GTKWindow *)window
{
  gtk_window_set_attached_to (GTK_WINDOW (self.widget),
      GTK_WIDGET ([window widget]));
}

- (GTKWindow *)transientForWindow
{
  return [GTKWindow widgetFromGtkWidget:
    GTK_WIDGET (gtk_window_get_transient_for (GTK_WINDOW (self.widget)))];
}

- (GTKWindow *)attachedToWindow
{
  return [GTKWindow widgetFromGtkWidget:
    GTK_WIDGET (gtk_window_get_attached_to (GTK_WINDOW (self.widget)))];
}

- (bool)destroyWithParent
{
    return gtk_window_get_destroy_with_parent (GTK_WINDOW (self.widget));
}

- (void)setDestroyWithParent:(bool)setting
{
  gtk_window_set_destroy_with_parent (GTK_WINDOW (self.widget), setting);
}

- (bool)maximized
{
  return gtk_window_is_maximized (GTK_WINDOW (self.widget));
}

- (bool)decorated
{
    return gtk_window_get_decorated (GTK_WINDOW (self.widget));
}

- (void)setDecorated:(bool)setting
{
  gtk_window_set_decorated (GTK_WINDOW (self.widget), setting);
}

- (void)setDeletable:(bool)setting
{
  gtk_window_set_deletable (GTK_WINDOW (self.widget), setting);
}

- (bool)deletable
{
  return gtk_window_get_deletable (GTK_WINDOW (self.widget));
}

- (bool)active
{
  return gtk_window_is_active (GTK_WINDOW (self.widget));
}

- (bool)hideTitlebarWhenMaximized
{
  return gtk_window_get_hide_titlebar_when_maximized (GTK_WINDOW (self.widget));
}

- (void)setHideTitlebarWhenMaximized:(bool)hide
{
  gtk_window_set_hide_titlebar_when_maximized (GTK_WINDOW (self.widget), hide);
}

- (GTKWidget*)titlebar
{
  GtkWidget *titlebarWidget = gtk_window_get_titlebar(GTK_WINDOW(self.widget));
  return (__bridge GTKWidget*)g_object_get_data(G_OBJECT(titlebarWidget),
      "_GTKKIT_WRAPPER_WIDGET_");
}

- (void)setTitlebar:(GTKWidget*)titlebarWidget
{
  gtk_window_set_titlebar(GTK_WINDOW(self.widget), titlebarWidget.widget);
}
@end
