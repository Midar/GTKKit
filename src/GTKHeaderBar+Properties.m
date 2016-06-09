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

#import "GTKHeaderBar+Properties.h"

@implementation GTKHeaderBar (Properties)
- (OFString *)title
{
  return @(gtk_header_bar_get_title(GTK_HEADER_BAR(self.widget)));
}

- (void)setTitle:(OFString *)title
{
  gtk_header_bar_set_title(GTK_HEADER_BAR(self.widget), [title UTF8String]);
}

- (OFString *)subtitle
{
  return @(gtk_header_bar_get_subtitle(GTK_HEADER_BAR(self.widget)));
}

- (void)setSubtitle:(OFString *)subtitle
{
  gtk_header_bar_set_subtitle(GTK_HEADER_BAR(self.widget),
      [subtitle UTF8String]);
}

- (bool)hasSubtitle
{
  return gtk_header_bar_get_has_subtitle(GTK_HEADER_BAR(self.widget));
}

- (void)setHasSubtitle:(bool)subtitle
{
  gtk_header_bar_set_has_subtitle(GTK_HEADER_BAR(self.widget), subtitle);
}

- (bool)showCloseButton
{
  return gtk_header_bar_get_show_close_button(GTK_HEADER_BAR(self.widget));
}

- (void)setShowCloseButton:(bool)show
{
  gtk_header_bar_set_show_close_button(GTK_HEADER_BAR(self.widget), show);
}

- (OFString *)decorationLayout
{
  return @(gtk_header_bar_get_decoration_layout(GTK_HEADER_BAR(self.widget)));
}

- (void)setDecorationLayout:(OFString *)layout
{
  gtk_header_bar_set_decoration_layout(GTK_HEADER_BAR(self.widget),
      [layout UTF8String]);
}
@end
