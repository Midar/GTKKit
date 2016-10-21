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
#import "GTKCallback.h"
#import "GTKApplication.h"

@implementation GTKControl
- init
{
    self = [super init];
    self.tag = -1;
    return self;
}

- (void)sendActionToTarget
{
    ObjFWCallback(^{
        if (NULL == self.action) {
            return;
        }

        if (nil == self.target) {
            GTKResponder *target = GTKApplication.sharedApplication.firstResponder;
            if (nil == target) {
                return;
            }
            IMP imp = [target methodForSelector: self.action];
            void (*func)(id, SEL, id) = (void *)(imp);
            func(target, self.action, self);
        } else {
            IMP imp = [self.target methodForSelector: self.action];
            void (*func)(id, SEL, id) = (void *)(imp);
            func(self.target, self.action, self);
        }
    });
}

- (void)takeStringValueFrom:(nonnull id)target
{
    ObjFWCallback(^{
        if ([target respondsToSelector: @selector(stringValue)]) {
            self.stringValue = [target stringValue];
        }
    });
}

- (void)takeIntValueFrom:(nonnull id)target
{
    ObjFWCallback(^{
        if ([target respondsToSelector: @selector(intValue)]) {
            self.intValue = [target intValue];
        }
    });
}

- (void)takeDoubleValueFrom:(nonnull id)target
{
    ObjFWCallback(^{
        if ([target respondsToSelector: @selector(doubleValue)]) {
            self.doubleValue = [target doubleValue];
        }
    });
}

- (void)takeFloatValueFrom:(nonnull id)target
{
    ObjFWCallback(^{
        if ([target respondsToSelector: @selector(floatValue)]) {
            self.floatValue = [target floatValue];
        }
    });
}

- (void)takeObjectValueFrom:(nonnull id)target
{
    ObjFWCallback(^{
        if ([target respondsToSelector: @selector(objectValue)]) {
            self.objectValue = [target objectValue];
        }
    });
}
@end
