//
//  GHNSMutableArray+Utils.h
//  GHKit
//
//  Created by Gabriel Handford on 7/1/09.
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
 Utilities for mutable arrays, for example, inserting, replacing at index, and more.
 */
@interface NSMutableArray(GHUtils)

/*!
 Insert objects at index.
 
 @param objects Objects to insert
 @param index Index to insert at
 */
- (void)gh_insertObjects:(NSArray *)objects atIndex:(NSInteger)index;

/*!
 Replace object with another object.
 
 @param objectToReplace Object to replace
 @param object Object that will replace
 @result Index object was set; NSNotFound if objectToReplace was not found
 */
- (NSUInteger)gh_replaceObject:(id)objectToReplace withObject:(id)object;

/*!
 Compact.
 Remove all instances NSNull.
 */
- (void)gh_mutableCompact;

/*!
 Add object. If object is nil, this is a no op.
 
 @param obj Object to add
 */
- (void)gh_addObject:(id)obj;

/*!
 Remove last object.
 
 @result Last object removed
 */
- (id)gh_removeLastObject;

@end
