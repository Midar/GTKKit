/*! @file defines.h
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
 * @brief A structure representing a rectangle, with x, y, width and height integer
 * values.
 */
typedef GdkRectangle GTKRect;

/*!
 * @brief This macro sets the class used as the app delegate, and provides the
 * main() function.
 */
#define GTK_APPLICATION_DELEGATE(cls)                                          \
int                                                                            \
main(int argc, char *argv[])                                                   \
{                                                                              \
    GTKApp = [GTKApplication sharedApplication];                               \
	GTKApp.delegateClass = [cls class];                                        \
    GTKApp.argc = &argc;                                                       \
    GTKApp.argv = &argv;                                                       \
    [GTKApp startup];                                                          \
    [GTKApp run];                                                              \
    return 0;                                                                  \
}                                                                              \
