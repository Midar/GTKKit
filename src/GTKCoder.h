/*! @file GTKCoder.h
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
#import <gtk/gtk.h>

#import "GTKCoding.h"
#import "OFString+GTKCoding.h"

typedef GdkRectangle GTKRect;

#define KEYED_CODING_EXCEPTION_CHECK                                           \
	if (!self.allowsKeyedCoding) {                                         \
		@throw [GTKCoderKeyedCodingNotAllowedException exception];     \
	}                                                                      \

#define INVALID_KEY_EXCEPTION_CHECK                                            \
	if (![key isKindOfClass: OFString.class]) {                            \
		@throw [GTKCoderInvalidKeyException exception];                \
	}                                                                      \

@interface GTKCoderKeyedCodingNotAllowedException: OFException
@end

@interface GTKCoderInvalidKeyException: OFException
@end

/*!
 * @brief An abstract parent class for classes which transfer data between
 * memory and other storage.
 */
@interface GTKCoder: OFObject
/*!
 * @brief The OFXMLElement which is used by the coder to store its data.
 */
@property OFXMLElement *data;
@end

@interface GTKCoder (OFCopying) <OFCopying>
@end

@interface GTKCoder (OFSerialization) <OFSerialization>
/*!
 * @brief An OFString containing an XML representation of this coder.
 */
- (OFString *)XMLString;
@end

@interface GTKCoder (KeyedCoding)
/*!
 * @brief A boolean value dependent on whether or not the coder allows keyed
 * encoding and decoding.
 */
@property (readonly) bool allowsKeyedCoding;

/*!
 * @brief Returns true if the coder has a value for the supplied key.
 */
- (bool)containsValueForKey: (OFString *)key;

 /*!
  * @brief Encode the supplied bool value for the supplied key.
  */
- (void)encodeBool: (bool)value
	    forKey: (OFString *)key;

/*!
 * @brief Encode the supplied double value for the supplied key.
 */
- (void)encodeDouble: (double)value
	      forKey: (OFString *)key;

/*!
 * @brief Encode the supplied float value for the supplied key.
 */
- (void)encodeFloat: (float)value
	     forKey: (OFString *)key;

/*!
 * @brief Encode the supplied int value for the supplied key.
 */
- (void)encodeInt: (int)value
	   forKey: (OFString *)key;

/*!
* @brief Encode the supplied GTKRect struct for the supplied key.
*/
- (void)encodeRect: (GTKRect)value
	    forKey: (OFString *)key;

/*!
 * @brief Encode the supplied int value for the supplied key.
 */
- (void)encodeString: (OFString *)value
	      forKey: (OFString *)key;

/*!
 * @brief Encode the supplied object for the supplied key.
 */
- (void)encodeObject: (OFObject<GTKCoding> *)object
	      forKey: (OFString *)key;

/*!
 * @brief Encode the supplied selector for the supplied key.
 */
- (void)encodeSelector: (SEL)selector
		forKey: (OFString *)key;

/*!
 * @brief Decode the bool value for the supplied key.
 */
- (bool)decodeBoolForKey: (OFString *)key;

/*!
* @brief Decode the double value for the supplied key.
*/
- (double)decodeDoubleForKey: (OFString *)key;

/*!
* @brief Decode the float value for the supplied key.
*/
- (float)decodeFloatForKey: (OFString *)key;

/*!
* @brief Decode the int value for the supplied key.
*/
- (int)decodeIntForKey: (OFString *)key;

/*!
* @brief Decode the GTKRect value for the supplied key.
*/
- (GTKRect)decodeRectForKey: (OFString *)key;

/*!
* @brief Decode the int value for the supplied key.
*/
- (OFString *)decodeStringForKey: (OFString *)key;

/*!
* @brief Decode the object for the supplied key.
*/
- (id)decodeObjectForKey: (OFString *)key;

/*!
 * @brief Decode the selector for the supplied key.
 */
- (SEL)decodeSelectorforKey: (OFString *)key;
@end
