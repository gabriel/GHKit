//
//  GHNSDictionary+NSNull.m
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

#import "GHNSDictionary+NSNull.h"

@implementation NSDictionary(GHNSNull)

+ (id)gh_dictionaryWithKeysAndObjectsMaybeNilWithKey:(id)firstKey args:(va_list)args ignoreNil:(BOOL)ignoreNil {
	if (!firstKey) return [self dictionary];
	
	NSMutableArray *keys = [[NSMutableArray alloc] init];
	NSMutableArray *values = [[NSMutableArray alloc] init];
	id key = firstKey;	
	do {
		id value = va_arg(args, id);
    if (!value && ignoreNil) {
      key = va_arg(args, id);
      continue;
    }
		if (!value) value = [NSNull null];
		[keys addObject:key];
		[values addObject:value];
		key = va_arg(args, id);
	} while(key);
	NSDictionary *dict = [self dictionaryWithObjects:values forKeys:keys];
	return dict;
}

+ (id)gh_dictionaryWithKeysAndObjectsMaybeNil:(id)firstKey, ... {	
	va_list args;
  va_start(args, firstKey);
	NSDictionary *dict = [self gh_dictionaryWithKeysAndObjectsMaybeNilWithKey:firstKey args:args ignoreNil:NO];
	va_end(args);
	return dict;
}

- (id)gh_objectMaybeNilForKey:(id)key {
	id object = [self objectForKey:key];
	if (object == [NSNull null] || [object isEqual:[NSNull null]])
		return nil;

	return object;
}

- (id)gh_objectMaybeNilForKey:(id)key ofClass:(Class)aClass {
  id obj = [self gh_objectMaybeNilForKey:key];
  if (![obj isKindOfClass:aClass]) return nil;
  return obj;
}

@end
