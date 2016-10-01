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


/*!
 * @brief A union of data types which can be passed back and forth between
 * the main and GTK+ threads inside a GTKCallBackInfo.
 */
typedef union GTKCallbackData {
	/*!
	 * @brief An interger value.
	 */
	int         intValue;
	/*!
	 * @brief A long value.
	 */
	long        longValue;
	/*!
	 * @brief A float value.
	 */
	float       floatValue;
	/*!
	 * @brief A double value.
	 */
	double      doubleValue;
	/*!
	 * @brief A generic pointer value.
	 */
	gpointer    pointerValue;
	/*!
	 * @brief A string value.
	 */
	char       *stringValue;
	/*!
	 * @brief A GTK+ widget value.
	 */
	GtkWidget  *widgetValue;
} GTKCallbackData;

/*!
 * @brief A structure used to mediate the relationship between the main thread
 * and the GTK+ thread. You create and free these structures with makeGTKCallbackInfo()
 * and freeGTKCallbackInfo().
 */
typedef struct GTKCallbackInfo {
	/*!
	 * @brief The GTK+ widget for the callback.
	 */
	GtkWidget       *widget;
	/*!
	 * @brief The GTKCallBackData union which manages the parameter and return
	 * value of the callback.
	 */
	GTKCallbackData  data;
	/*!
	 * @brief The mutex used by the callback.
	 */
	GMutex          *mutex;
	/*!
	 * @brief The cond used by the callback.
	 */
	GCond           *cond;
	/*!
	 * @brief The flag used by the callback.
	 */
	gboolean         flag;
} GTKCallbackInfo;

/*!
 * @brief Create a new GTKCallBackInfo.
 *
 * If is your responsibiltiy to free the returned struct with
 * freeGTKCallbackInfo().
 *
 * @returns An allocated GTKCallBackInfo.
 */
GTKCallbackInfo *
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
freeGTKCallbackInfo(GTKCallbackInfo *info);
