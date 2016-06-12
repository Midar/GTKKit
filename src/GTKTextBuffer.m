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

#import "GTKTextBuffer.h"

@implementation GTKTextBuffer
- init
{
  self = [super init];
  self.bufferHandle = gtk_text_buffer_new(NULL);
  return self;
}

- (int)lineCount
{
  return gtk_text_buffer_get_line_count(GTK_TEXT_BUFFER(self.bufferHandle));
}

- (int)characterCount
{
  return gtk_text_buffer_get_char_count(GTK_TEXT_BUFFER(self.bufferHandle));
}

- (void)insertString:(OFString*)string
          atPosition:(int)position
{
  GtkTextIter iter;
  gtk_text_buffer_get_iter_at_offset(GTK_TEXT_BUFFER(self.bufferHandle),
      &iter, position);
  gtk_text_buffer_insert(GTK_TEXT_BUFFER(self.bufferHandle), &iter,
      [string UTF8String], -1);
}

- (void)insertStringAtCursorPosition:(OFString*)string
{
  gtk_text_buffer_insert_at_cursor(GTK_TEXT_BUFFER(self.bufferHandle),
      [string UTF8String], [string UTF8StringLength]);
}
@end
