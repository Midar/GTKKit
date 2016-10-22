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

 #import "GTKViewController.h"
 #import "GTKApplication.h"
 #import "GTKWindowViewControllerDelegate.h"

 @implementation GTKViewController
- init
{
    self = [super init];
    self.contentView = [GTKView new];
    self.contentView.nextResponder = self;
    self.nextResponder = GTKApp;
    return self;
}

- (void)addViewController:(nonnull GTKViewController *)viewController
{
    [self addSubview: viewController.contentView];
    viewController.nextResponder = self.contentView;
}

- (void)addSubview:(nonnull GTKView *)subview
{
    [self.contentView addSubview: subview];
    subview.viewController = self;
}
 @end
