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

- (NSDictionary *)gh_queryDictionary {
	return [NSURL gh_queryStringToDictionary:[self query]];
}

+ (NSString *)gh_dictionaryToQueryString:(NSDictionary *)queryDictionary {
	return [self gh_dictionaryToQueryString:queryDictionary sort:NO];
}

+ (NSString *)gh_dictionaryToQueryString:(NSDictionary *)queryDictionary sort:(BOOL)sort {
  if (!queryDictionary) return nil;
	if ([queryDictionary count] == 0) return @"";
  
  NSMutableArray *queryStrings = [NSMutableArray arrayWithCapacity:[queryDictionary count]];
	id enumerator = queryDictionary;
	if (sort) enumerator = [[queryDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)];
	
  for(NSString *key in enumerator) {
    NSString *value = [queryDictionary valueForKey:key];
    NSString *encodedKey = [self gh_encodeComponent:key];
    NSString *encodedValue = [self gh_encodeComponent:value];
    [queryStrings addObject:[NSString stringWithFormat:@"%@=%@", encodedKey, encodedValue]];
  }
  return [queryStrings componentsJoinedByString:@"&"];
}

+ (NSDictionary *)gh_queryStringToDictionary:(NSString *)string {
	NSArray *queryItemStrings = [string componentsSeparatedByString:@"&"];
	
	NSMutableDictionary *queryDictionary = [NSMutableDictionary dictionaryWithCapacity:[queryItemStrings count]];
	for(NSString *queryItemString in queryItemStrings) {
		NSRange range = [queryItemString rangeOfString:@"="];
		if (range.location != NSNotFound) {
			NSString *key = [NSURL gh_decode:[queryItemString substringToIndex:range.location]];
			NSString *value = [NSURL gh_decode:[queryItemString substringFromIndex:range.location + 1]];
			[queryDictionary setObject:value forKey:key];
		}
	}
	return queryDictionary;
}

+ (NSString *)gh_encode:(NSString *)s {	
	// Characters to maybe leave unescaped? CFSTR("~!@#$&*()=:/,;?+'")
	return [(NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)s, CFSTR("#"), CFSTR("%^{}[]\"\\"), kCFStringEncodingUTF8) autorelease];
}

+ (NSString *)gh_encodeComponent:(NSString *)s {  
	// Characters to maybe leave unescaped? CFSTR("~!*()'")
  return [(NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)s, NULL, CFSTR("@#$%^&{}[]=:/,;?+\"\\"), kCFStringEncodingUTF8) autorelease];
}

+ (NSString *)gh_escapeAll:(NSString *)s {
	// Characters to escape: @#$%^&{}[]=:/,;?+"\~!*()'
  return [(NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)s, NULL, CFSTR("@#$%^&{}[]=:/,;?+\"\\~!*()'"), kCFStringEncodingUTF8) autorelease];	
}

+ (NSString *)gh_decode:(NSString *)s {
	if (!s) return nil;
	return [(NSString *)CFURLCreateStringByReplacingPercentEscapes(NULL, (CFStringRef)s, CFSTR("")) autorelease];
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
