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

#import "defines.h"

@class GTKCallback;

typedef void (^GTKCallbackBlock)(GTKCallback *callback);
typedef void (*GTKCallbackFunction)(GTKCallback *callback);

@interface GTKCallback: OFObject
@property GtkWidget *widget;
@property (weak) id sender;
@property GMutex *mutex;
@property GCond *cond;
@property gboolean flag;
@property int  intValue;
@property long longValue;
@property float floatValue;
@property double doubleValue;
@property gpointer pointerValue;
@property char *stringValue;
@property GtkWidget *widgetValue;
@property (copy) GTKCallbackBlock blockValue;
@property (copy) GTKCallbackBlock privateBlockValue;
@property GTKCallbackFunction functionValue;
@property id objectValue;
- (void)lock;
- (void)unlock;
- (void)wait;
- (void)signal;
- (void)waitForBlock:(GTKCallbackBlock)block;
@end
