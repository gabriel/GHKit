//
//  GHNSArray+Utils.m
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

#import "GHNSArray+Utils.h"

@implementation NSArray(GHUtils)

- (id)gh_firstObject {
	if ([self count] > 0)
		return [self objectAtIndex:0];
	return nil;
}

+ (NSArray *)gh_arrayWithObject:(id)obj {
  if (!obj) return [NSArray array];
  return [NSArray arrayWithObject:obj];
}

- (id)gh_objectAtIndex:(NSInteger)index {
  return [self gh_objectAtIndex:index withDefault:nil];
}

- (id)gh_objectAtIndex:(NSInteger)index withDefault:(id)defaultValue {
  if (index >= 0 && index < [self count]) return [self objectAtIndex:index];
  return defaultValue;
}

- (id)gh_randomObject {
	if ([self count] == 0) return nil;
  NSUInteger count = [self count];
  NSAssert(count <= UINT32_MAX, @"Array size is greater than rand supports");
	NSUInteger index = arc4random_uniform((int32_t)count);
	return [self objectAtIndex:index];
}

- (NSArray *)gh_arrayByReversingArray {
	NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
	for(id obj in [self reverseObjectEnumerator]) {
		[array addObject:obj];
	}
	return array;
}

- (NSArray *)gh_subarrayWithRange:(NSRange)range {
	if (range.location >= [self count]) return nil;
	NSInteger length = range.length;
	if ((range.location + length) >= [self count]) length = [self count] - range.location;
	
	return [self subarrayWithRange:NSMakeRange(range.location, length)];
}

- (NSArray *)gh_subarrayFromLocation:(NSInteger)location {
  if (location == 0) return self;
  if (location >= [self count]) return [NSArray array];
  return [self subarrayWithRange:NSMakeRange(location, [self count]-location)];
}

- (NSArray *)gh_compact {
  if ([self count] == 0) return self;
  NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:[self count]];
  BOOL found = NO;
  for(id obj in self) {
    if (![obj isEqual:[NSNull null]]) [array addObject:obj];
    else found = YES;
  }
  if (found) {
    return array;
  } else {
    // No NSNulls were found so release array copy and return self
    return self;
  }  
}

- (NSArray *)gh_uniq {
  return [[NSOrderedSet orderedSetWithArray:self] array];
}

- (NSArray *)gh_filter:(BOOL(^)(id obj, NSInteger index))filterBlock { 
  id filteredArray = [NSMutableArray arrayWithCapacity:[self count]];
  NSInteger i = 0;
  for (id obj in self) {
    if (filterBlock(obj, i))	{
      [filteredArray addObject:obj];
    }
    i++;
  }
  return filteredArray; 
}

- (NSString *)gh_toJSON:(NSJSONWritingOptions)options error:(NSError **)error {
  NSData *data = [NSJSONSerialization dataWithJSONObject:self options:options error:error];
  if (data) return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
  return nil;
}

- (NSArray *)gh_exceptLast {
  if (self.count == 0) return self;
  if (self.count == 1) return @[];
  return [self subarrayWithRange:NSMakeRange(0, self.count - 1)];
}

- (NSArray *)gh_arrayByRemovingObject:(id)obj {
  NSMutableArray *array = [self mutableCopy];
  [array removeObject:obj];
  return array;
}

+ (NSArray *)gh_arrayWithArrays:(NSArray *)arrays {
  NSMutableArray *array = [NSMutableArray array];
  for (NSArray *a in arrays) {
    [array addObjectsFromArray:a];
  }
  return array;
}

@end
