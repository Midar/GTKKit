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

#import "GTKKit.h"

@interface MainWindow: GTKWindow
@property (nonnull) GTKTabView   *tabView;
@property (nonnull) GTKTab       *tab1;
@property (nonnull) GTKTab       *tab2;
@property (nonnull) GTKTab       *tab3;
@property (nonnull) GTKTab       *tab4;
@property (nonnull) GTKTextField *label1;
@property (nonnull) GTKTextField *label2;
@property (nonnull) GTKTextField *label3;
@property (nonnull) GTKTextField *label4;
@end
