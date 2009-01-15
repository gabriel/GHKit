//
//  GHNSURL+Utils.m
//
//  Created by Gabe on 3/19/08.
//  Copyright 2008 Gabriel Handford
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


#import "GHNSURL+Utils.h"


@implementation NSURL (GHUtils)

- (NSDictionary *)gh_parameters {
	return [NSURL gh_stringToParams:[self parameterString]];
}

+ (NSString *)gh_paramsToString:(NSDictionary *)params {
  if (!params) return nil;
	if ([params count] == 0) return @"";
  
  NSMutableArray *paramStrings = [NSMutableArray arrayWithCapacity:[params count]];
  for(NSString *key in params) {
    NSString *value = [params valueForKey:key];
    NSString *newKey = [self gh_encodeAll:key];
    NSString *newValue = [self gh_encodeAll:value];
    [paramStrings addObject:[NSString stringWithFormat:@"%@=%@", newKey, newValue]];
  }
  return [paramStrings componentsJoinedByString:@"&"];
}

+ (NSDictionary *)gh_stringToParams:(NSString *)string {
	NSArray *paramsList = [string componentsSeparatedByString:@"&"];
	
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:[paramsList count]];
	for(NSString *paramString in paramsList) {
		NSRange range = [paramString rangeOfString:@"="];
		if (range.location == NSNotFound) {
			
		} else {
			NSString *key = [paramString substringToIndex:range.location];
			NSString *value = [paramString substringFromIndex:range.location + 1];
			[params setObject:value forKey:key];
		}
	}
	return params;
}

+ (NSString *)gh_encode:(NSString *)s {	
	return [(NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)s, CFSTR("~!@#$&*()=:/,;?+'"), CFSTR("%^{}[]\"\\"), kCFStringEncodingUTF8) autorelease];
}

+ (NSString *)gh_encodeAll:(NSString *)s {  
  return [(NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)s, CFSTR("~!*()'"), CFSTR("@#$%^&{}[]=:/,;?+\"\\"), kCFStringEncodingUTF8) autorelease];
}

+ (NSString *)gh_decode:(NSString *)url {
	return [(NSString *)CFURLCreateStringByReplacingPercentEscapes(NULL, (CFStringRef) self, CFSTR("")) autorelease];
}

#ifndef TARGET_OS_IPHONE

- (void)gh_copyLinkToPasteboard {  
  NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
  [pasteboard declareTypes:[NSArray arrayWithObjects:NSURLPboardType, NSStringPboardType, nil] owner:self];
  [self writeToPasteboard:pasteboard]; // For NSURLPBoardType
  [pasteboard setString:[self absoluteString] forType:NSStringPboardType];
}

+ (void)gh_openFile:(NSString *)path {
  NSString *fileURL = [NSString stringWithFormat:@"file://%@", [self gh_encode:path]];
  NSURL *url = [NSURL URLWithString:fileURL];
  [[NSWorkspace sharedWorkspace] openURL:url];
}

+ (void)gh_openContainingFolder:(NSString *)path {
  BOOL isDir;
  if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir] && isDir)
    [self gh_openFile:path];
  else
    [self gh_openFile:[path stringByDeletingLastPathComponent]];
}

#endif

@end
