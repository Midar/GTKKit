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
	    (__bridge void*)self);

	self.buffer = [GTKTextBuffer new];

	_widgetDestroyedHandlerID = g_signal_connect(G_OBJECT(self.widget),
	    "destroy", G_CALLBACK(gtkkit_widget_destroyed_handler),
	    (__bridge void*)self);

	return self;
}

- (GTKTextBuffer*)buffer
{
	return _buffer;
}

- (void)setBuffer: (GTKTextBuffer*)buffer
{
	_buffer = buffer;
	gtk_text_view_set_buffer(GTK_TEXT_VIEW(self.widget),
	    buffer.bufferHandle);
}

- (void)moveCursorToVisibleArea
{
	gtk_text_view_place_cursor_onscreen(GTK_TEXT_VIEW(self.widget));
}

- (GtkWrapMode)wrapMode
{
	return gtk_text_view_get_wrap_mode(GTK_TEXT_VIEW(self.widget));
}

- (void)setWrapMode: (GtkWrapMode)mode
{
	gtk_text_view_set_wrap_mode(GTK_TEXT_VIEW(self.widget), mode);
}

- (bool)editable
{
	return gtk_text_view_get_editable(GTK_TEXT_VIEW(self.widget));
}

- (void)setEditable: (bool)editable
{
	gtk_text_view_set_editable(GTK_TEXT_VIEW(self.widget), editable);
}

- (bool)cursorVisible
{
	return gtk_text_view_get_cursor_visible(GTK_TEXT_VIEW(self.widget));
}

- (void)setCursorVisible: (bool)visible
{
	gtk_text_view_set_cursor_visible(GTK_TEXT_VIEW(self.widget), visible);
}

- (bool)overwriteMode
{
	return gtk_text_view_get_overwrite(GTK_TEXT_VIEW(self.widget));
}

- (void)setOverwriteMode: (bool)mode
{
	gtk_text_view_set_overwrite(GTK_TEXT_VIEW(self.widget), mode);
}

- (int)pixelsAboveParagraphs
{
	return gtk_text_view_get_pixels_above_lines(GTK_TEXT_VIEW(self.widget));
}

- (void)setPixelsAboveParagraphs: (int)pixels
{
	gtk_text_view_set_pixels_above_lines(
	    GTK_TEXT_VIEW(self.widget), pixels);
}

- (int)pixelsBelowParagraphs
{
	return gtk_text_view_get_pixels_below_lines(GTK_TEXT_VIEW(self.widget));
}

- (void)setPixelsBelowParagraphs: (int)pixels
{
	gtk_text_view_set_pixels_below_lines(
	    GTK_TEXT_VIEW(self.widget), pixels);
}

- (int)pixelsBetweenWrappedLines
{
	return gtk_text_view_get_pixels_inside_wrap(GTK_TEXT_VIEW(self.widget));
}

- (void)setPixelsBetweenWrappedLines: (int)pixels
{
	gtk_text_view_set_pixels_inside_wrap(
	    GTK_TEXT_VIEW(self.widget), pixels);
}

- (GtkJustification)justification
{
	return gtk_text_view_get_justification(GTK_TEXT_VIEW(self.widget));
}

- (void)setJustification: (GtkJustification)justify
{
	gtk_text_view_set_justification(GTK_TEXT_VIEW(self.widget), justify);
}

- (int)paddingLeft
{
	return gtk_text_view_get_left_margin(GTK_TEXT_VIEW(self.widget));
}

- (void)setPaddingLeft: (int)pixels
{
	gtk_text_view_set_left_margin(GTK_TEXT_VIEW(self.widget), pixels);
}

- (int)paddingRight
{
	return gtk_text_view_get_right_margin(GTK_TEXT_VIEW(self.widget));
}

- (void)setPaddingRight: (int)pixels
{
	gtk_text_view_set_right_margin(GTK_TEXT_VIEW(self.widget), pixels);
}

- (int)paddingTop
{
	return gtk_text_view_get_top_margin(GTK_TEXT_VIEW(self.widget));
}

- (void)setPaddingTop: (int)pixels
{
	gtk_text_view_set_top_margin(GTK_TEXT_VIEW(self.widget), pixels);
}

- (int)paddingBottom
{
	return gtk_text_view_get_bottom_margin(GTK_TEXT_VIEW(self.widget));
}

- (void)setPaddingBottom: (int)pixels
{
	gtk_text_view_set_bottom_margin(GTK_TEXT_VIEW(self.widget), pixels);
}

- (int)indent
{
	return gtk_text_view_get_indent(GTK_TEXT_VIEW(self.widget));
}

- (void)setIndent: (int)pixels
{
	gtk_text_view_set_indent(GTK_TEXT_VIEW(self.widget), pixels);
}

- (bool)acceptTab
{
	return gtk_text_view_get_accepts_tab(GTK_TEXT_VIEW(self.widget));
}

- (void)setAcceptTab: (bool)mode
{
	gtk_text_view_set_accepts_tab(GTK_TEXT_VIEW(self.widget), mode);
}

- (GtkInputPurpose)purpose
{
	return gtk_text_view_get_input_purpose(GTK_TEXT_VIEW(self.widget));
}

- (void)setPurpose: (GtkInputPurpose)purpose
{
	gtk_text_view_set_input_purpose(GTK_TEXT_VIEW(self.widget), purpose);
}

- (bool)monospace
{
	return gtk_text_view_get_monospace(GTK_TEXT_VIEW(self.widget));
}

- (void)setMonospace: (bool)monospace
{
	gtk_text_view_set_monospace(GTK_TEXT_VIEW(self.widget), monospace);
}

/* implement GTKScrollable */
- (GtkAdjustment*)horizontalAdjustment
{
	return gtk_scrollable_get_hadjustment(GTK_SCROLLABLE(self.widget));
}

- (void)setHorizontalAdjustment: (GtkAdjustment*)adjustment
{
	gtk_scrollable_set_hadjustment(GTK_SCROLLABLE(self.widget), adjustment);
}

- (GtkAdjustment*)verticalAdjustment
{
	return gtk_scrollable_get_vadjustment(GTK_SCROLLABLE(self.widget));
}

- (void)setVerticalAdjustment: (GtkAdjustment*)adjustment
{
	gtk_scrollable_set_vadjustment(GTK_SCROLLABLE(self.widget), adjustment);
}

- (GtkScrollablePolicy)horizontalScrollingPolicy
{
	return gtk_scrollable_get_hscroll_policy(GTK_SCROLLABLE(self.widget));
}

- (void)setHorizontalScrollingPolicy: (GtkScrollablePolicy)policy
{
	return gtk_scrollable_set_hscroll_policy(
	    GTK_SCROLLABLE(self.widget), policy);
}

- (GtkScrollablePolicy)verticalScrollingPolicy
{
	return gtk_scrollable_get_vscroll_policy(GTK_SCROLLABLE(self.widget));
}

- (void)setVerticalScrollingPolicy: (GtkScrollablePolicy)policy
{
	return gtk_scrollable_set_vscroll_policy(
	    GTK_SCROLLABLE(self.widget), policy);
}
@end
