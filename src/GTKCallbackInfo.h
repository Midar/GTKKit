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


/*!
 * @brief A union of data types which can be passed back and forth between
 * the main and GTK+ threads inside a GTKCallBackInfo.
 */
typedef union GTKCallBackData {
	int         intValue;
	long        longValue;
	float       floatValue;
	double      doubleValue;
	gpointer    pointerValue;
	char       *stringValue;
	GtkWidget  *widgetValue;
} GTKCallBackData;

/*!
 * @brief A structure used to mediate the relationship between the main thread
 * and the GTK+ thread.
 */
typedef struct GTKCallBackInfo {
	GtkWidget       *widget;
	GTKCallBackData  data;
	GMutex          *mutex;
	GCond           *cond;
	gboolean         flag;
} GTKCallBackInfo;

/*!
 * @brief Create a new GTKCallBackInfo.
 *
 * If is your responsibiltiy to free the returned struct with
 * freeGTKCallbackInfo().
 *
 * @returns An allocated GTKCallBackInfo.
 */
GTKCallBackInfo *
makeGTKCallbackInfo();

/*!
 * @brief Free an allocated GTKCallBackInfo.
 *
 * This frees the memory used by the GTKCallBackInfo passed to it, including
 * the allocated variables it contains.
 *
 * @param info The GTKCallBackInfo to free.
 */
void
freeGTKCallbackInfo(GTKCallBackInfo *info);
