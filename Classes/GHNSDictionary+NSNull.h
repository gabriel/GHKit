//
//  GHNSDictionary+NSNull.h
//  Created by Jae Kwon on 5/12/08.
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
 For supporting dictionaries with nil values.
 */
@interface NSDictionary(GHNSNull)

/*!
 Create dictionary which supports nil values.
 Key is first (instead of value then key). If the value is nil it is stored internally as NSNull,
 and when calling objectMaybeNilForKey will return nil.
 
 For example,

    [NSDictionary gh_dictionaryWithKeysAndObjectsMaybeNil:@"key1", nil, @"key2", @"value2", @"key3", nil, nil];
 
 @param firstObject Alternating key, value pairs. Terminated when _key_ is nil. 
 @param ... Keys and objects
 @result Dictionary
 */
+ (id)gh_dictionaryWithKeysAndObjectsMaybeNil:(id)firstObject, ... NS_REQUIRES_NIL_TERMINATION;

/*!
 Create dictionary which supports nil values.
 Key is first (instead of value then key). If the value is nil it is stored internally as NSNull,
 and when calling objectMaybeNilForKey will return nil.
 
 For example,

     - (void)setDictionary:(id)key, ... {
       va_list args;
       va_start(args, key);
       [NSDictionary gh_dictionaryWithKeysAndObjectsMaybeNilWithKey:key args:args ignoreNilValues:NO];
       va_end(args);
     }
 
 @param firstKey First key
 @param args Args va_list via va_start
 @param ignoreNil If YES, will not store key, value paries where the value is nil
 @result Dictionary
 */
+ (id)gh_dictionaryWithKeysAndObjectsMaybeNilWithKey:(id)firstKey args:(va_list)args ignoreNil:(BOOL)ignoreNil;

/*!
 Create dictionary which supports nil values.
 Key is first (instead of value then key). If the value is nil it is stored internally as NSNull,
 and when calling objectMaybeNilForKey will return nil.
 
 For example,

    [NSDictionary gh_dictionaryWithKeysAndObjectsMaybeNil:@"key1", nil, @"key2", @"value2", @"key3", nil, nil];
 
 @param firstObject... Alternating key, value pairs. Terminated when _key_ is nil. 
 */

/*!
 Returns objectForKey if you want nil instead of NSNull objects.

 @param key Key
 @result Object for key. If object is NSNull, then nil is returned.
 */
- (id)gh_objectMaybeNilForKey:(id)key;

/*!
 Same as gh_objectMaybeNilForKey, but checks the class type and if a mismatch returns nil.
 */
- (id)gh_objectMaybeNilForKey:(id)key ofClass:(Class)aClass;

@end
