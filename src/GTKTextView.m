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

#import "GTKTextView.h"


@implementation GTKTextView
/*
+ (void)initialize
{
	if (self == [GTKTextView class])
		[self inheritMethodsFromClass: [GTKScrollable class]];
}
*/

- init
{
    self = [super init];
    self.widget = gtk_text_view_new();
    g_object_ref_sink(G_OBJECT(self.widget));
    g_object_set_data(G_OBJECT(self.widget), "_GTKKIT_WRAPPER_WIDGET_",
        (__bridge void*) self);
    self.buffer = [GTKTextBuffer new];
    gtk_text_view_set_buffer (GTK_TEXT_VIEW (self.widget), self.buffer.bufferHandle);
    _widgetDestroyedHandlerID = g_signal_connect(G_OBJECT (self.widget), "destroy",
      G_CALLBACK (widget_destroyed_handler), (__bridge void*) self);
    return self;
}

- (void)moveCursorToVisibleArea
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_text_view_place_cursor_onscreen(GTK_TEXT_VIEW(self.widget));
}

- (GtkWrapMode)wrapMode
{
    if (self.widget == NULL) {
      @throw([GTKDestroyedWidgetException new]);
    }
    return gtk_text_view_get_wrap_mode(GTK_TEXT_VIEW(self.widget));
}

- (void)setWrapMode:(GtkWrapMode)mode
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_text_view_set_wrap_mode(GTK_TEXT_VIEW(self.widget), mode);
}

- (bool)editable
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_text_view_get_editable(GTK_TEXT_VIEW(self.widget));
}

- (void)setEditable:(bool)editable
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_text_view_set_editable(GTK_TEXT_VIEW(self.widget), editable);
}

- (bool)cursorVisible
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_text_view_get_cursor_visible(GTK_TEXT_VIEW(self.widget));
}

- (void)setCursorVisible:(bool)visible
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_text_view_set_cursor_visible(GTK_TEXT_VIEW(self.widget), visible);
}

- (bool)overwriteMode
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_text_view_get_overwrite(GTK_TEXT_VIEW(self.widget));
}

- (void)setOverwriteMode:(bool)mode
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_text_view_set_overwrite(GTK_TEXT_VIEW(self.widget), mode);
}

// implement <GTKScrollable>
- (GtkAdjustment*)horizontalAdjustment
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_scrollable_get_hadjustment(GTK_SCROLLABLE(self.widget));
}

- (void)setHorizontalAdjustment:(GtkAdjustment*)adjustment
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_scrollable_set_hadjustment(GTK_SCROLLABLE(self.widget), adjustment);
}

- (GtkAdjustment*)verticalAdjustment
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_scrollable_get_vadjustment(GTK_SCROLLABLE(self.widget));
}

- (void)setVerticalAdjustment:(GtkAdjustment*)adjustment
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_scrollable_set_vadjustment(GTK_SCROLLABLE(self.widget), adjustment);
}

- (GtkScrollablePolicy)horizontalScrollingPolicy
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_scrollable_get_hscroll_policy(GTK_SCROLLABLE(self.widget));
}

- (void)setHorizontalScrollingPolicy:(GtkScrollablePolicy)policy
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_scrollable_set_hscroll_policy(GTK_SCROLLABLE(self.widget), policy);
}

- (GtkScrollablePolicy)verticalScrollingPolicy
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_scrollable_get_vscroll_policy(GTK_SCROLLABLE(self.widget));
}

- (void)setVerticalScrollingPolicy:(GtkScrollablePolicy)policy
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_scrollable_set_vscroll_policy(GTK_SCROLLABLE(self.widget), policy);
}
@end
