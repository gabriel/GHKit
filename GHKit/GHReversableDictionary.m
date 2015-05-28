//
//  GHReversableDictionary.m
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

#import "GHReversableDictionary.h"
#import "GHKitDefines.h"


@implementation GHReversableDictionary

- (id)init {
  return [self initWithCapacity:10];
}

- (id)initWithCapacity:(NSInteger)capacity {
  if ((self = [super init])) {
    _dict = [[NSMutableDictionary alloc] initWithCapacity:capacity];
    _reversedDict = [[NSMutableDictionary alloc] initWithCapacity:capacity];
  }
  return self;  
}

- (id)initWithObjectsAndKeys:(id)firstObject, ... {
	GHConvertVarArgs(firstObject);
  self = [self init];  
  for(NSInteger i = 0, count = [arguments count]; i < count; i += 2) {
    if ((i + 1) >= [arguments count]) break;
    [self setObject:[arguments objectAtIndex:i] forKey:[arguments objectAtIndex:i+1]];
  }
  return self;
}

- (void)setObject:(id)obj forKey:(id)key {
  [_dict setObject:obj forKey:key];
  [_reversedDict setObject:key forKey:obj];
}

- (id)objectForKey:(id)key {
  return [_dict objectForKey:key];
}

- (id)keyForObject:(id)obj {
  return [_reversedDict objectForKey:obj];
}

@end
