//
//  GHReversableDictionary.h
//  GHKit
//
//  Created by Gabriel Handford on 1/25/10.
//  Copyright 2010. All rights reserved.
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
 Reversable dictionary, where keys and values point to each other.
 */
@interface GHReversableDictionary : NSObject {
  NSMutableDictionary *_dict;
  NSMutableDictionary *_reversedDict;
}

/*!
 Create with capacity.
 
 @param capacity Capacity
 */
- (id)initWithCapacity:(NSInteger)capacity;

/*!
 Create with objects and keys.
 
 @param firstObject Objects
 @param ... Objects and keys
 */
- (id)initWithObjectsAndKeys:(id)firstObject, ... NS_REQUIRES_NIL_TERMINATION;

/*!
 Key for object.
 
 @param obj Object
 @result Key
 */
- (id)keyForObject:(id)obj;

/*!
 Set object for key.
 
 @param obj Object
 @param key Key
 */
- (void)setObject:(id)obj forKey:(id)key;

/*!
 Get object for key.
 
 @param key Key
 @result Object for key
 */
- (id)objectForKey:(id)key;

@end
