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

#import "GTKExpander.h"

@implementation GTKExpander
- init
{
  self = [super init];
  self.widget = gtk_expander_new ("");
  g_object_ref_sink(G_OBJECT(self.widget));
  g_object_set_data(G_OBJECT(self.widget), "_GTKKIT_WRAPPER_WIDGET_",
      (__bridge void*) self);
  _widgetDestroyedHandlerID = g_signal_connect(G_OBJECT (self.widget), "destroy",
      G_CALLBACK (widget_destroyed_handler), (__bridge void*) self);
  return self;
}

- (OFString *)label
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return [OFString stringWithUTF8String:
      gtk_expander_get_label (GTK_EXPANDER (self.widget))];
}

- (void)setLabel:(OFString *)label
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_expander_set_label (GTK_EXPANDER (self.widget), [label UTF8String]);
}

+ (instancetype)expanderWithLabel:(OFString *)label
{
  return [[self alloc] initWithLabel: label];
}

- initWithLabel:(OFString *)label {
  self = [self init];
  self.label = label;
  return self;
}

- (bool)expanded
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_expander_get_expanded (GTK_EXPANDER (self.widget));
}

- (void)setExpanded:(bool)newValue
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_expander_set_expanded (GTK_EXPANDER (self.widget), newValue);
}

- (bool)resizeToplevel
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_expander_get_resize_toplevel (GTK_EXPANDER (self.widget));
}

- (void)setResizeToplevel:(bool)newValue
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_expander_set_resize_toplevel (GTK_EXPANDER (self.widget), newValue);
}
@end
