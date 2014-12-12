//
//  GHNSBundle+Utils.m
//  GHKit
//
//  Created by Gabriel Handford on 4/27/09.
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

#import "GHNSBundle+Utils.h"

@implementation NSBundle(GHUtils)

- (NSData *)gh_loadDataFromResource:(NSString *)resource {
	NSParameterAssert(resource);
	NSString *resourcePath = [self pathForResource:[resource stringByDeletingPathExtension] ofType:[resource pathExtension]];	
	if (!resourcePath) [NSException raise:NSInvalidArgumentException format:@"Resource not found: %@", resource];	
	NSError *error = nil;
	NSData *data = [NSData dataWithContentsOfFile:resourcePath options:0 error:&error];
	if (error) [NSException raise:NSInvalidArgumentException format:@"Error loading resource at path (%@): %@", resourcePath, error];
	return data;
}

- (NSString *)gh_loadStringDataFromResource:(NSString *)resource {
	return [[NSString alloc] initWithData:[self gh_loadDataFromResource:resource] encoding:NSUTF8StringEncoding];
}

- (NSURL *)gh_URLForResource:(NSString *)resource {
  NSParameterAssert(resource);
  NSString *resourcePath = [self pathForResource:[resource stringByDeletingPathExtension] ofType:[resource pathExtension]];	
  return resourcePath ? [NSURL fileURLWithPath:resourcePath] : nil;
}

@end
