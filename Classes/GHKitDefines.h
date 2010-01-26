//
//  GHKitDefines.h
//  GHKit
//
//  Created by Gabriel Handford on 1/28/09.
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

#define GHInteger(n) [NSNumber numberWithInteger:n]

#define GHStr(fmt, ...) \
[NSString stringWithFormat:(fmt), ## __VA_ARGS__]

#define GHDict(key, ...) \
[NSDictionary dictionaryWithKeysAndObjectsMaybeNil: key, ## __VA_ARGS__, nil]

#define GHCGRectToString(rect) NSStringFromRect(NSRectFromCGRect(rect))
#define GHCGSizeToString(size) NSStringFromSize(NSSizeFromCGSize(size))
#define GHCGPointToString(point) NSStringFromPoint(NSPointFromCGPoint(point))

#define GHAssertMainThread() NSAssert([NSThread isMainThread], @"Should be on main thread")

// Default epsilon for float comparisons
#define GH_EPSILON 1.0E-5

#define GHProperties(obj, ...) [[obj dictionaryWithValuesForKeys:[NSArray arrayWithObjects:__VA_ARGS__, nil]] description]

// Makes it easier to generate descriptions
// - (NSString *)description {
//   return GHDescription(@"prop1", @"prop2", @"prop3");
// }
#define GHDescription(...) \
[NSString stringWithFormat:@"%@ %@", \
  [super description], \
  [[self dictionaryWithValuesForKeys:[NSArray arrayWithObjects:__VA_ARGS__, nil]] description] \
]
  
//
// Creates arguments NSArray from var args, with first object named 'object'
// - (void)methodName:(id)arg1 withObjects:object, ...
//
#define GHConvertVarArgs(object) \
NSMutableArray *arguments = [NSMutableArray array]; \
do { \
id arg; \
va_list args; \
if (object) { \
[arguments addObject:object]; \
va_start(args, object); \
while ((arg = va_arg(args, id))) \
[arguments addObject:arg]; \
va_end(args); \
} \
} while(0); 
