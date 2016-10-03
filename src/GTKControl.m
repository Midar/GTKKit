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

#import "GTKControl.h"

@implementation GTKControl
- (void)sendActionToTargetWithEvent:(nonnull GTKEvent*)event
{
    if (NULL == self.action) {
        return;
    }

    if (nil == self.target) {
        //FIXME: Get the current first responder and send it the action message.
    } else {
        IMP imp = [self methodForSelector: self.action];
        void (*func)(id, SEL) = (void *)(imp);
        func(self, self.action);
    }
}

- (void)takeStringValueFrom:(nonnull id)target
{
    if ([target respondsToSelector: @selector(stringValue)]) {
        self.stringValue = [target stringValue];
    }
}

- (void)takeIntValueFrom:(nonnull id)target
{
    if ([target respondsToSelector: @selector(intValue)]) {
        self.intValue = [target intValue];
    }
}

- (void)takeDoubleValueFrom:(nonnull id)target
{
    if ([target respondsToSelector: @selector(doubleValue)]) {
        self.doubleValue = [target doubleValue];
    }
}

- (void)takeFloatValueFrom:(nonnull id)target
{
    if ([target respondsToSelector: @selector(floatValue)]) {
        self.floatValue = [target floatValue];
    }
}

- (void)takeObjectValueFrom:(nonnull id)target
{
    if ([target respondsToSelector: @selector(objectValue)]) {
        self.objectValue = [target objectValue];
    }
}
@end
