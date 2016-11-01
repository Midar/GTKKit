/*! @file enums.h
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
 * @brief The state of an active button. Equal to true.
 */
extern const bool GTKOnState;

/*!
 * @brief The state of an inactive button. Equal to false.
 */
extern const bool GTKOffState;

/*!
 * @brief An enumeration of positions.
 */
typedef enum GTKPositionType {

    /*!
     * @brief The top position.
     */
    GTKPositionTypeTop = GTK_POS_TOP,

    /*!
     * @brief The bottom position.
     */
    GTKPositionTypeBottom = GTK_POS_BOTTOM,

    /*!
     * @brief The left position.
     */
    GTKPositionTypeLeft = GTK_POS_LEFT,

    /*!
     * @brief The right position.
     */
    GTKPositionTypeRight = GTK_POS_RIGHT
} GTKPositionType;

/*!
 * @brief An enumeratin of built-in response types for dialogs in GTKKit.
 */
typedef enum GTKResponseType {
    /*!
     * @brief No response.
     */
     GTKResponseTypeNone = GTK_RESPONSE_NONE,

     /*!
      * @brief Generic "rejected" response.
      */
     GTKResponseTypeReject = GTK_RESPONSE_REJECT,

    /*!
     * @brief Generic "accepted" response.
     */
     GTKResponseTypeAccept = GTK_RESPONSE_ACCEPT,

    /*!
     * @brief "Deleted" response used if the dialog was deleted.
     */
     GTKResponseTypeDelete = GTK_RESPONSE_DELETE_EVENT,

    /*!
     * @brief "OK" response
     */
    GTKResponseTypeOK = GTK_RESPONSE_OK,

    /*!
     * @brief "Cancel" response
     */
    GTKResponseTypeCancel = GTK_RESPONSE_CANCEL,

    /*!
     * @brief "Close" response returned if the dialog was closed.
     */
    GTKResponseTypeClose = GTK_RESPONSE_CLOSE,

    /*!
     * @brief "Yes" response.
     */
    GTKResponseTypeYes = GTK_RESPONSE_YES,

    /*!
     * @brief "No" response.
     */
    GTKResponseTypeNo = GTK_RESPONSE_NO,

    /*!
     * @brief "Apply" response.
     */
    GTKResponseTypeApply = GTK_RESPONSE_APPLY,

    /*!
     * @brief "Help" response.
     */
    GTKResponseTypeHelp = GTK_RESPONSE_HELP
} GTKResponseType;
