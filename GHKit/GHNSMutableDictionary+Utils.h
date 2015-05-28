//
//  GHNSMutableDictionary+Utils.h
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
 Utilities for NSMutableDictionary.
 */
@interface NSMutableDictionary(GHUtils)

/*!
 Set double value.
 
 @param d Double
 @param forKey Key
 */
- (void)gh_setDouble:(double)d forKey:(id)forKey;

/*!
 Set integer value.
 
 @param n Integer
 @param forKey Key
 */
- (void)gh_setInteger:(NSInteger)n forKey:(id)forKey;

/*!
 Set bool.
 
 @param b Bool
 @param forKey Key
 */
- (void)gh_setBool:(BOOL)b forKey:(id)forKey;

/*!
 Set object or [NSNull null] if nil.
 
 @param object Object
 @param forKey Key
 */
- (void)gh_setObjectMaybeNil:(id)object forKey:(id)forKey;

/*!
 Compact.
 Remove all value with instances NSNull.
 */
- (void)gh_mutableCompact;

@end
