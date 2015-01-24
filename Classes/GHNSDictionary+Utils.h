//
//  GHNSDictionary+Utils.h
//  GHKit
//
//  Created by Gabriel Handford on 3/12/09.
//  Copyright 2009. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import <Foundation/Foundation.h>

/*!
 Utilities for dictionaries.
 */
@interface NSDictionary(GHUtils)

/*! 
 Get double value for key.

 @param key Key
 @param withDefault If value for key is nil or [NSNull null] this default is returned.
 @result Double value
 */
- (double)gh_doubleForKey:(id)key withDefault:(double)withDefault;

/*! 
 Get double value for key.

 @param key Key
 @result Double value
 */
- (double)gh_doubleForKey:(id)key;

/*! 
 Integer for key.

 @param key Key
 @param withDefault If value for key is nil or [NSNull null] this default is returned.
 @result Integer value
 */
- (NSInteger)gh_integerForKey:(id)key withDefault:(NSInteger)withDefault;

/*! 
 Integer for key.
 If value for key is nil or [NSNull null], 0 is returned.

 @param key Key
 @result Integer value
 */
- (NSInteger)gh_integerForKey:(id)key;

/*! 
 Unsigned integer for key.

 @param key Key
 @param withDefault If value for key is nil or [NSNull null] this default is returned.
 @result Unsigned integer
 */
- (NSUInteger)gh_unsignedIntegerForKey:(id)key withDefault:(NSUInteger)withDefault;

/*! 
 Unsigned integer for key.
 If value for key is nil or [NSNull null], 0 is returned.
 
 @param key Key
 @result Unsigned integer
 */
- (NSUInteger)gh_unsignedIntegerForKey:(id)key;

/*!
 Number for key.
 @param key
 @result Number
 */
- (NSNumber *)gh_numberForKey:(id)key;

/*!
 Number for key with default integer value.
 
 @param key Key
 @param withDefaultInteger If value for key is nil or [NSNull null] this default is returned.
 @result Number
 */
- (NSNumber *)gh_numberForKey:(id)key withDefaultInteger:(NSInteger)withDefaultInteger;

/*!
 Number for key with default double value.

 @param key Key
 @param withDefaultDouble If value for key is nil or [NSNull null] this default is returned.
 @result Number
 */
- (NSNumber *)gh_numberForKey:(id)key withDefaultDouble:(double)withDefaultDouble;

/*!
 Get BOOL value for key.

 @param key Key
 @param withDefault If value for key is nil or [NSNull null] this default is returned.
 @result BOOL value
 */
- (BOOL)gh_boolForKey:(id)key withDefault:(BOOL)withDefault;

/*!
 Get BOOL value for key.

 @param key Key
 @result YES if boolValue; If key not found or is NSNull, returns NO.
 */
- (BOOL)gh_boolForKey:(id)key;

/*!
 Get date for key. Value should respond to doubleValue, which should be seconds since epoch GMT.
 @param key
 */
- (NSDate *)gh_dateForKey:(id)key;

/*!
 Get date for key. Value should respond to doubleValue, which should be seconds since epoch GMT.
 @param key
 @param withDefaultDate
 */
- (NSDate *)gh_dateForKey:(id)key withDefaultDate:(NSDate *)withDefaultDate;

/*!
 Object for key with default value, if entry is NSNull or entry does not exist.

 @param key Key
 @param withDefault If value for key is nil or [NSNull null] this default is returned.
 @result Value for key with default value, if entry is NSNull or entry does not exist
 */
- (id)gh_objectForKey:(id)key withDefault:(id)withDefault;

/*!
 Object for key or NSNull.
 Helpful when used with key/value coding.

 @param key Key
 @result Value or NSNull#null if not set
 */
- (id)gh_objectForKeyOrNSNull:(id)key;

/*!
 Get boolean value (represented by NSNumber).
 Usefuly for coercing any object that responds to boolValue into an object for use with Key Value coding.

 @param key Key
 @param withDefault Default if value is missing or [NSNull null]
 @result Number
 */ 
- (NSNumber *)gh_boolValueForKey:(id)key withDefault:(BOOL)withDefault;

/*!
 Get boolean value (represented by NSNumber).
 Usefuly for coercing any object that responds to boolValue into an object for use with Key Value coding.

 @param key Key
 @result Number
 */ 
- (NSNumber *)gh_boolValueForKey:(id)key;

/*!
 Get data from base64 string.
 @result NSData
 */
- (NSData *)gh_dataAsBase64ForKey:(NSString *)key options:(NSDataBase64DecodingOptions)options;

/*!
 Check if dictionary has all keys.
 
 @param firstKey First key
 @param ... Argument list
 @result YES if dictionary has all the keys
 */
- (BOOL)gh_hasAllKeys:(NSString *)firstKey, ... NS_REQUIRES_NIL_TERMINATION;

/*!
 Return dictionary with subset of keys.

 @param keys Keys
 */
- (NSDictionary *)gh_dictionarySubsetWithKeys:(NSArray *)keys;

/*!
 @result Dictionary without entries for keys with NSNull values
 */
- (NSDictionary *)gh_compactDictionary;

/*!
 Query string from dictionary.
 
 Calls [NSURL gh_dictionaryToQueryString:self];
 */
- (NSString *)gh_queryString;

/*!
 Create JSON string for dictionary.
 */
- (NSString *)gh_toJSON:(NSJSONWritingOptions)options error:(NSError **)error;

@end
