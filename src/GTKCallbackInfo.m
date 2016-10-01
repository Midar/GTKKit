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

#import "GTKCallBackInfo.h"

GTKCallbackInfo *
makeGTKCallbackInfo()
{
    GTKCallbackInfo *info = (GTKCallbackInfo *)calloc(1, sizeof(GTKCallbackInfo));
    info->mutex = (GMutex *)calloc(1, sizeof(GMutex));
    info->cond = (GCond *)calloc(1, sizeof(GCond));
	g_mutex_init(info->mutex);
	g_cond_init(info->cond);
	info->flag = false;
	return info;
}

void
freeGTKCallbackInfo(GTKCallbackInfo *info)
{
	g_mutex_clear(info->mutex);
	g_cond_clear(info->cond);
	free(info->mutex);
	free(info->cond);
	free(info);
}
