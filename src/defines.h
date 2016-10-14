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

typedef GdkRectangle GTKRect;

// Our version of NS_ENUM.
#ifndef OF_ENUM
#define OF_ENUM(_type, _name) enum _name : _type _name; enum _name : _type
#endif

// This macro sets the class used as the app delegate, and provides the
// main() function.
#define GTK_APPLICATION_DELEGATE(cls)                           \
static int *_argc;                                              \
static char ***_argv;                                           \
                                                                \
void                                                            \
gtkkit_application_main(id param)                               \
{                                                               \
   of_application_main(_argc, _argv, [cls class]);              \
}                                                               \
                                                                \
int                                                             \
main(int argc, char *argv[])                                    \
{                                                               \
   _argc = &argc;                                               \
   _argv = &argv;                                               \
   gtk_init(&argc, &argv);                                      \
   of_thread_new(&gtkkit_objfw_thread, &gtkkit_application_main,\
                 nil, &gtkkit_objfw_thread_attr);               \
   gtkkit_gtk_thread = of_thread_current();                     \
   gtk_main();                                                  \
   return 0;                                                    \
}                                                               \
