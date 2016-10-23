/*! @file GTKDispatchQueue.h
 *
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

/*!
 * @brief A block of code to be run as a work item by a GTKDispatchQueue. Takes
 * no parameters, returns no value.
 */
typedef void (^DispatchWorkItem)();

/*!
 * @brief A class representing objects which dispatch work items (blocks) to
 * a pool of threads managed by the system. GTKDispatchQueue is the public
 * interface to a class cluster implementing specific types of dispatch
 * queues; the public interfaces it defines are the only ones needed to use
 * any type of queue, and your code need not be aware of any specific subclass.
 *
 * GTKDispatchQueue represents the public interface to multithreaded programming
 * in GTKKit. It allows you to run code in multiple threads, synchronously or
 * asynchronously, optionally repeating, with an optional delay in seconds.
 */
@interface GTKDispatchQueue: OFObject

/*!
 * @brief A string label applied to the queue.
 */
@property (nonnull, copy) OFString *label;

+ (nonnull instancetype)main;
+ (nonnull instancetype)background;
+ (nonnull instancetype)gtk;

/*!
 * @brief Create and return a new dispatch queue with its own thread.
 */
+ (nonnull GTKDispatchQueue *)queueWithLabel:(nonnull OFString *)label
                                    priority:(float)priority;

/*!
 * @brief Create and return a new dispatch queue with its own thread.
 */
+ (nonnull GTKDispatchQueue *)queueWithLabel:(nonnull OFString *)label;

/*!
 * @brief Run a work item, waiting for it to complete before returning.
 */
- (void)sync:(_Nonnull DispatchWorkItem)block;

/*!
 * @brief Run a work item without waiting for it to complete before returning.
 */
- (void)async:(_Nonnull DispatchWorkItem)block;

/*!
 * @brief Run a work item once, after a given delay in seconds, without waiting
 * for the work item to run or complete before returning.
 */
- (void)asyncAfter:(unsigned int)seconds
           execute:(_Nonnull DispatchWorkItem)block;

/*!
 * @brief Run a work item, repeating after a given delay in seconds, without waiting
 * for the work item to run or complete before returning.
 */
- (void)asyncRepeatAfter:(unsigned int)seconds
                 execute:(_Nonnull DispatchWorkItem)block;
@end
