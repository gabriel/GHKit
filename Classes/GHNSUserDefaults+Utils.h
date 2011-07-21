//
//  GHNSUserDefaults+Utils.h
//  GHKitIOS
//
//  Created by Gabriel Handford on 7/21/11.
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

/*!
 Utilities for URLs, for example, encoding, escaping, parsing, splitting out or sorting query params, and more.
 */
@interface NSUserDefaults(GHUtils)

/*!
 Check if user defaults contains key.
 @param key Key
 @result YES if defaults contains key
 */
- (BOOL)gh_containsKey:(NSString *)key;

/*!
 BOOL for key.
 @param key Key
 @result BOOL for key
 */
- (BOOL)gh_boolForKey:(id)key withDefault:(BOOL)defaultValue;

/*!
 Set BOOL for key.
 @param b Bool
 @param key Key
 */
- (void)gh_setBool:(BOOL)b forKey:(NSString *)key;

/*!
 double for key.
 @param key Key
 @param defaultValue Value if not in defaults
 @result double for key
 */
- (double)gh_doubleForKey:(NSString *)key withDefault:(double)defaultValue;

/*!
 Set double for key.
 @param d Double
 @param key Key
 */
- (void)gh_setDouble:(double)d forKey:(NSString *)key;

/*!
 Integer for key.
 @param key Key
 @param defaultValue Value if not in defaults
 @result Integer for key
 */
- (NSInteger)gh_integerForKey:(NSString *)key withDefault:(NSInteger)defaultValue;

/*!
 Set integer for key.
 @param integer Integer
 @param key Key
 */
- (void)gh_setInteger:(NSInteger)integer forKey:(NSString *)key;

/*!
 Object for key.
 @param key Key
 @param defaultValue Value if not in defaults
 */
- (id)gh_objectForKey:(NSString *)key withDefault:(id)defaultValue;

/*!
 Set object (stored as NSData) for key.
 @param obj Object (should be NSCoding)
 @param key Key
 @result Object from data for key
 */
- (void)gh_setObjectAsData:(id)obj forKey:(NSString *)key;

/*!
 Object from data for key.
 @param key Key
 @result Object from data for key
 */
- (id)gh_objectFromDataForKey:(NSString *)key;

@end
