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

/*!
 Utilities for arrays, for example, first object, reversed, subarray, compact
 and safe \c objectAtIndex:.
 */
@interface NSArray(GHUtils)

/*!
 First object.
 @result Object at index 0
 */
- (id)gh_firstObject;

/*!
 Random object in the array.
 @param seed Seed, if 0, will use the current time to seed
 @result Random object
 */
- (id)gh_randomObject:(unsigned int)seed;

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
 @param range
 @result Sub-array
 */
- (NSArray *)gh_subarrayWithRange:(NSRange)range;

/*!
 Get sub-array from location to end.
 @param location
 @result Sub-array
 */
- (NSArray *)gh_subarrayFromLocation:(NSInteger)location;

/*!
 Remove all instances of NSNull.
 @result New array with instances removed; Or self if no NSNull's were found
 */
- (NSArray *)gh_compact;

/*!
 Safe array with object.
 Returns empty if obj is null.
 */
+ (NSArray *)gh_arrayWithObject:(id)obj;

/*!
 Safe object at index.
 @param index
 @result Object at index, or nil if index < 0 or >= count
 */
- (id)gh_objectAtIndex:(NSInteger)index;

/*!
 Safe object at index with default.
 @param index
 @param withDefault
 @result Object at index, or default value if index < 0 or >= count
 */
- (id)gh_objectAtIndex:(NSInteger)index withDefault:(id)defaultValue;

@end
