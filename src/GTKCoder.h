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

@interface GTKCoderKeyedCodingNotAllowedException: OFException
@end

@interface GTKCoderInvalidKeyException: OFException
@end

@interface GTKCodingKeyReference: OFObject <GTKCoding>
@property OFString *key;
@end

/*!
 * @brief An abstract parent class for classes which transfer data between
 * memory and other storage.
 */
@interface GTKCoder: OFXMLElement

/*!
 * @brief A boolean value dependent on whether or not the coder allows keyed
 * encoding and decoding.
 */
@property (readonly) bool allowsKeyedCoding;

/*!
 * @brief Returns true if the coder has a value for the supplied key.
 */
- (bool)containsValueForKey:(OFString *)key;

/*!
 * @brief Returns the class specified for the given key.
 */
- (Class)classForKey:(OFString *)key;

/*!
 * @brief Sets the class specified for the given key.
 */
- (void)setClass:(Class)class forKey:(OFString *)key;

 /*!
  * @brief Encode the supplied bool value for the supplied key.
  */
- (void)encodeBool:(bool)value
            forKey:(OFString *)key;

/*!
 * @brief Encode the supplied double value for the supplied key.
 */
- (void)encodeDouble:(double)value
              forKey:(OFString *)key;

/*!
 * @brief Encode the supplied float value for the supplied key.
 */
- (void)encodeFloat:(float)value
             forKey:(OFString *)key;

/*!
 * @brief Encode the supplied int value for the supplied key.
 */
- (void)encodeInt:(int)value
           forKey:(OFString *)key;

/*!
 * @brief Encode the supplied int value for the supplied key.
 */
- (void)encodeString:(OFString *)value
              forKey:(OFString *)key;

/*!
 * @brief Encode the supplied object for the supplied key.
 */
- (void)encodeObject:(OFObject<GTKCoding> *)object
              forKey:(OFString *)key;

/*!
 * @brief Encode the supplied selector for the supplied key.
 */
- (void)encodeSelector:(SEL)selector
               forKey:(OFString *)key;

/*!
 * @brief Decode the bool value for the supplied key.
 */
- (bool)decodeBoolForKey:(OFString *)key;

/*!
* @brief Decode the double value for the supplied key.
*/
- (double)decodeDoubleForKey:(OFString *)key;

/*!
* @brief Decode the float value for the supplied key.
*/
- (float)decodeFloatForKey:(OFString *)key;

/*!
* @brief Decode the int value for the supplied key.
*/
- (int)decodeIntForKey:(OFString *)key;

/*!
* @brief Decode the int value for the supplied key.
*/
- (OFString *)decodeStringForKey:(OFString *)key;

/*!
* @brief Decode the object for the supplied key.
*/
- (id)decodeObjectForKey:(OFString *)key;

/*!
 * @brief Decode the selector for the supplied key.
 */
- (SEL)decodeSelectorforKey:(OFString *)key;
@end
