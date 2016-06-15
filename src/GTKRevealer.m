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

#import "GTKRevealer.h"

OF_ASSUME_NONNULL_BEGIN

/*!
 * @brief A container that can show an hide its child using animation.
 */
@implementation GTKRevealer: GTKBin
- (bool)revealed
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_revealer_get_child_revealed(GTK_REVEALER(self.widget));
}

- (unsigned int)transitionDuration
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_revealer_get_transition_duration(GTK_REVEALER(self.widget));
}

- (void)setTransitionDuration:(unsigned int)duration
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_revealer_set_transition_duration(GTK_REVEALER(self.widget), duration);
}

- (GtkRevealerTransitionType)transitionType
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  return gtk_revealer_get_transition_type(GTK_REVEALER(self.widget));
}

- (void)setTransitionType:(GtkRevealerTransitionType)transitionType
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_revealer_set_transition_type(GTK_REVEALER(self.widget), transitionType);
}

- (void)revealChild
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_revealer_set_reveal_child(GTK_REVEALER(self.widget), true);
}

- (void)concealChild
{
  if (self.widget == NULL) {
    @throw([GTKDestroyedWidgetException new]);
  }
  gtk_revealer_set_reveal_child(GTK_REVEALER(self.widget), false);
}
@end

OF_ASSUME_NONNULL_END
