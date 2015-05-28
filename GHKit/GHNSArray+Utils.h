//
//  GHNSArray+Utils.h
//  Created by Gabriel Handford on 12/11/08.
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
 Utilities for arrays.
 */
@interface NSArray(GHUtils)

/*!
 First object or nil if array is empty.

 @result Object at index 0
 */
- (id)gh_firstObject;

/*!
 Random object in the array.
 Uses arc4random_uniform.

 @result Random object
 */
- (id)gh_randomObject;

/*!
 Return new reversed array.
 Use reverseObjectEnumerator if you want to enumerate values in reverse.

 @result Reversed array
 */
- (NSArray *)gh_arrayByReversingArray;

/*!
 Safe subarrayWithRange that checks range.
 If the length is out of bounds will return all elements from location to the end.
 If the location is out of bounds will return nil.

 @param range Range
 @result Sub-array
 */
- (NSArray *)gh_subarrayWithRange:(NSRange)range;

/*!
 Get sub-array from location to end.

 @param location Index
 @result Sub-array
 */
- (NSArray *)gh_subarrayFromLocation:(NSInteger)location;

/*!
 Remove all instances of NSNull.

 @result New array with NSNull instances removed. Returns self if no NSNull's were found.
 */
- (NSArray *)gh_compact;

/*!
 Safe array with object.

 @param obj Object
 @result Array with object. Returns empty if obj is nil.
 */
+ (NSArray *)gh_arrayWithObject:(id)obj;

/*!
 Safe object at index.

 @param index Index
 @result Object at index, or nil if index < 0 or >= count
 */
- (id)gh_objectAtIndex:(NSInteger)index;

/*!
 Safe object at index with default.
 
 @param index Index
 @param withDefault Default if not found
 @result Object at index, or default value if index < 0 or >= count
 */
- (id)gh_objectAtIndex:(NSInteger)index withDefault:(id)withDefault;

/*!
 Filter array.
 @param filterBlock Filter block
 */
- (NSArray *)gh_filter:(BOOL(^)(id obj, NSInteger index))filterBlock;

/*!
 Convert array to JSON string.
 */
- (NSString *)gh_toJSON:(NSJSONWritingOptions)options error:(NSError **)error;

/*!
 Except last object.
 */
- (NSArray *)gh_exceptLast;

/*!
  Uniqify (de-dupe) an array.
 */
- (NSArray *)gh_uniq;

/*!
 New array with object removed.
 */
- (NSArray *)gh_arrayByRemovingObject:(id)obj;

/*!
 Array from arrays.
 */
+ (NSArray *)gh_arrayWithArrays:(NSArray *)arrays;

@end
