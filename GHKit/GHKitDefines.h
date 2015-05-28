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

#define GHDict(...) [NSDictionary gh_dictionaryWithKeysAndObjectsMaybeNil:__VA_ARGS__, nil]

#define GHCGRectToString(rect) NSStringFromRect(NSRectFromCGRect(rect))
#define GHCGSizeToString(size) NSStringFromSize(NSSizeFromCGSize(size))
#define GHCGPointToString(point) NSStringFromPoint(NSPointFromCGPoint(point))

#define XCTAssertMainThread() NSAssert([NSThread isMainThread], @"Should be on main thread")

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

/*!
 Macro defaults.
 */
#undef GHDebug
#define GHDebug(fmt, ...) do {} while(0)
#undef GHErr
#define GHErr(fmt, ...) do {} while(0)

/*!
 Logging macros.
 */
#if DEBUG
#undef GHDebug
#define GHDebug(fmt, ...) NSLog((@"%s:%d: " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#undef GHErr
#define GHErr(fmt, ...) NSLog((@"%s:%d: " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#endif

/*!
 Time.
 */
#define GHTimeIntervalMinute (60)
#define GHTimeIntervalHour (GHTimeIntervalMinute * 60)
#define GHTimeIntervalDay (GHTimeIntervalHour * 24)
#define GHTimeIntervalWeek (GHTimeIntervalDay * 7)
#define GHTimeIntervalYear (GHTimeIntervalDay * 365.242199)
#define GHTimeIntervalMax (DBL_MAX)

/*!
 For when you need a weak reference of an object, example: `GHWeakObject(obj) wobj = obj;`
 */
#define GHWeakObject(o) __typeof__(o) __weak

/*!
 For when you need a weak reference to self, example: `GHWeakSelf wself = self;`
 */
#define GHWeakSelf GHWeakObject(self)

typedef void (^GHTargetBlock)(id sender);

#define GHNSError(CODE, MESSAGE) [NSError errorWithDomain:NSStringFromClass([self class]) code:CODE userInfo:@{NSLocalizedDescriptionKey:MESSAGE}]

#define GHMakeError(CODE, fmt, ...) [NSError errorWithDomain:NSStringFromClass(self.class) code:CODE userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:fmt, ##__VA_ARGS__]}]

#define GHOrNull(obj) (obj ? obj : NSNull.null)

#define GHIfNull(obj, val) ([obj isEqual:NSNull.null] ? val : obj)

#define GHEquals(obj1, obj2) ((!obj1 && !obj2) || [obj1 isEqual:obj2])

#define GHNSStringFromNSData(data) ([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding])
#define GHNSDataFromNSString(str) ([str dataUsingEncoding:NSUTF8StringEncoding])

#define GHNSDataFromBase64String(str) ([[NSData alloc] initWithBase64EncodedString:str options:0])
#define GHBase64StringFromNSData(data) ([data base64EncodedStringWithOptions:0])

