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

@implementation NSDictionary (GHNSNull)

+ (id)gh_dictionaryWithKeysAndObjectsMaybeNil:(id)firstObject, ... {
	va_list vl;
	va_start(vl,firstObject);
	NSMutableArray *keys = [[[NSMutableArray alloc] init] autorelease];
	NSMutableArray *values = [[[NSMutableArray alloc] init] autorelease];
	id key = firstObject;
	id value = va_arg(vl, id);
	do {
		if (value == nil)
			value = [NSNull null];
		[keys addObject:key];
		[values addObject:value];
		key = va_arg(vl,id);
		if (key == nil)
			break;
		value = va_arg(vl, id);
	} while (YES);
	va_end(vl);
	return [NSDictionary dictionaryWithObjects:values forKeys:keys];
}

- (id)gh_objectMaybeNilForKey:(id)key {
	id object = [self objectForKey:key];
	if (object == [NSNull null]) {
		return nil;
	}
	return object;
}

@end

@implementation NSMutableDictionary (GHNSNull)

- (void)gh_setObjectMaybeNil:(id)object forKey:(id)key {
	if (object == nil)
		object = [NSNull null];
	[self setObject:object forKey:key];
}

@end
