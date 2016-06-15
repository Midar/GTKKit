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

#import "GTKActionBar.h"

OF_ASSUME_NONNULL_BEGIN

@implementation GTKActionBar
- init
{
  self = [super init];
  self.widget = gtk_action_bar_new ();
  g_object_ref_sink(G_OBJECT(self.widget));
  g_object_set_data(G_OBJECT(self.widget), "_GTKKIT_WRAPPER_WIDGET_",
      (__bridge void*) self);
  _widgetDestroyedHandlerID = g_signal_connect(G_OBJECT (self.widget),
      "destroy", G_CALLBACK (widget_destroyed_handler), (__bridge void*) self);
  return self;
}

- (void)addWidget:(GTKWidget*)childWidget
{
  OF_UNRECOGNIZED_SELECTOR
}

- (GTKWidget *)childWidget
{
  OF_UNRECOGNIZED_SELECTOR
}

- (GTKWidget*)centerWidget
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  GtkWidget *childWidget = \
      gtk_action_bar_get_center_widget(GTK_ACTION_BAR(self.widget));
  return [GTKWidget wrapperForGtkWidget: childWidget];
}

- (void)setCenterWidget:(GTKWidget*)childWidget
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  if (childWidget.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_action_bar_set_center_widget(GTK_ACTION_BAR(self.widget),
      childWidget.widget);
}

- (void)addWidgetAtStart:(GTKWidget*)childWidget
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  if (childWidget.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_action_bar_pack_start(GTK_ACTION_BAR(self.widget), childWidget.widget);
}

- (void)addWidgetAtEnd:(GTKWidget*)childWidget
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  if (childWidget.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_action_bar_pack_end(GTK_ACTION_BAR(self.widget), childWidget.widget);
}
@end

OF_ASSUME_NONNULL_END
