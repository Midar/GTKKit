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

 // of_thread_new(of_thread_t *thread, void (*function)(id), id object, const of_thread_attr_t *attr);

 #define GTK_APPLICATION_DELEGATE(cls)                          \
of_thread_t objfw_thread;                                       \
const of_thread_attr_t objfw_thread_attr;                       \
static int *_argc;                                              \
static char ***_argv;                                           \
                                                                \
void                                                            \
gtkkit_application_main(id param)                               \
{                                                               \
    of_application_main(_argc, _argv, [cls class]);             \
}                                                               \
                                                                \
int                                                             \
main(int argc, char *argv[])                                    \
{                                                               \
    _argc = &argc;                                              \
    _argv = &argv;                                              \
    gtk_init(&argc, &argv);                                     \
    of_thread_new(&objfw_thread, &gtkkit_application_main,      \
                  nil, &objfw_thread_attr);                     \
    gtk_main();                                                 \
}                                                               \



#import "Exceptions.h"
#import "GTKCallBackInfo.h"

#import "GTKWidget.h"
#import "GTKOverlay.h"
#import "GTKInvisible.h"

#import "GTKApplicationDelegate.h"
#import "GTKResponder.h"
#import	"GTKEvent.h"
#import	"GTKLayoutConstraints.h"
#import	"GTKView.h"
#import	"GTKControl.h"
#import	"GTKViewController.h"
