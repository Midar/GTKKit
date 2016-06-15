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

#import "GTKComboBox.h"

static void
comboBoxActiveItemChanged(GtkWidget *combobox, GTKComboBox *sender)
{
  if (sender.target && sender.action) {
    void (*methodImplementation)(id, SEL, id) = \
        (void(*)(id, SEL, id))[sender.target methodForSelector: sender.action];
    methodImplementation(sender.target, sender.action, sender);
  }
}

@implementation GTKComboBox
- init
{
  self = [super init];
  self.widget = gtk_combo_box_text_new ();
  g_object_ref_sink(G_OBJECT(self.widget));
  g_object_set_data(G_OBJECT(self.widget), "_GTKKIT_WRAPPER_WIDGET_",
      (__bridge void*) self);
  _changedHandlerID = g_signal_connect(GTK_WIDGET (self.widget), "changed",
      G_CALLBACK (comboBoxActiveItemChanged), (__bridge void*) self);
  _widgetDestroyedHandlerID = g_signal_connect(G_OBJECT (self.widget),
      "destroy", G_CALLBACK (widget_destroyed_handler), (__bridge void*) self);
  return self;
}

- (void)dealloc
{
  if (self.widget != NULL)
    g_signal_handler_disconnect(G_OBJECT(self.widget), _changedHandlerID);
}

- (void)    appendString: (OFString*)string
    withIdentifierString: (OFString*)ID
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_combo_box_text_append(GTK_COMBO_BOX_TEXT(self.widget),
      [string UTF8String], [ID UTF8String]);
}

- (void)   prependString: (OFString*)string
    withIdentifierString: (OFString *)ID
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_combo_box_text_prepend(GTK_COMBO_BOX_TEXT(self.widget),
      [string UTF8String], [ID UTF8String]);
}

- (void)  insertString: (OFString*)string
  withIdentifierString: (OFString*)ID
            atPosition:(int)position
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_combo_box_text_insert(GTK_COMBO_BOX_TEXT(self.widget), position,
      [string UTF8String], [ID UTF8String]);
}

- (int)activeItem
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_combo_box_get_active(GTK_COMBO_BOX(self.widget));
}

- (void)setActiveItem:(int)index
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_combo_box_set_active(GTK_COMBO_BOX(self.widget), index);
}
@end
