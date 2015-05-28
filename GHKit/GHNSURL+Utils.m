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

#if TARGET_OS_OSX
#import <AppKit/AppKit.h>
#endif

#import "GHNSURL+Utils.h"


@implementation NSURL(GHUtils)

- (NSMutableDictionary *)gh_queryDictionary {
	return [NSURL gh_queryStringToDictionary:[self query]];
}

+ (NSString *)gh_dictionaryToQueryString:(NSDictionary *)queryDictionary {
	return [self gh_dictionaryToQueryString:queryDictionary sort:NO];
}

+ (NSArray *)gh_dictionaryToQueryArray:(NSDictionary *)queryDictionary sort:(BOOL)sort encoded:(BOOL)encoded {
  if (!queryDictionary) return nil;
	if ([queryDictionary count] == 0) return [NSArray array];
  
  NSMutableArray *queryStrings = [NSMutableArray arrayWithCapacity:[queryDictionary count]];
	id enumerator = queryDictionary;
	if (sort) enumerator = [[queryDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)];
	
  for(NSString *key in enumerator) {
    id value = [queryDictionary valueForKey:key];
    NSString *valueDescription = nil;
    
    if ([value respondsToSelector:@selector(objectEnumerator)]) {
      NSEnumerator *enumerator = [value objectEnumerator];
      valueDescription = [[enumerator allObjects] componentsJoinedByString:@","];
    } else if ([value isEqual:[NSNull null]]) {
      continue;
    } else {
      valueDescription = [value description];
    }
    
    if (!valueDescription) continue;
    
    NSString *keyToEncode = key;
    if (encoded) keyToEncode = [self gh_encodeComponent:key];
    if (encoded) valueDescription = [self gh_encodeComponent:valueDescription];
    [queryStrings addObject:[NSString stringWithFormat:@"%@=%@", keyToEncode, valueDescription]];
  }
  return queryStrings;
}

+ (NSString *)gh_dictionaryToQueryString:(NSDictionary *)queryDictionary sort:(BOOL)sort {
  return [[self gh_dictionaryToQueryArray:queryDictionary sort:sort encoded:YES] componentsJoinedByString:@"&"];
}

+ (NSMutableDictionary *)gh_queryStringToDictionary:(NSString *)string {
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

- (NSString *)gh_sortedQuery {
	return [NSURL gh_dictionaryToQueryString:[self gh_queryDictionary] sort:YES];
}

- (NSURL *)gh_deriveWithQuery:(NSString *)query {
	NSMutableString *URLString = [NSMutableString stringWithFormat:@"%@://", [self scheme]];
	if ([self user] && [self password]) [URLString appendFormat:@"%@:%@@", [self user], [self password]];
  if ([self host]) {
    [URLString appendString:[self host]];
  }
	if ([self port]) {
    [URLString appendFormat:@":%ld", [[self port] longValue]];
  }
  if ([self path]) {
    [URLString appendString:[self path]];
  }
	if (query) {
    [URLString appendFormat:@"?%@", query];
  }
	if ([self fragment]) {
    [URLString appendFormat:@"#%@", [self fragment]];
  }
	return [NSURL URLWithString:URLString];
}

- (NSURL *)gh_canonical {
	return [self gh_canonicalWithIgnore:nil];
}

- (NSURL *)gh_canonicalWithIgnore:(NSArray *)ignore {
	return [self gh_filterQueryParams:ignore sort:YES];
}

- (NSURL *)gh_filterQueryParams:(NSArray *)filterQueryParams sort:(BOOL)sort {
  NSString *query = nil;
	if ([self query]) {
		NSMutableDictionary *queryParams = [self gh_queryDictionary];
		for(NSString *key in filterQueryParams) [queryParams removeObjectForKey:key];
		query = [NSURL gh_dictionaryToQueryString:queryParams sort:sort];
	}
	return [self gh_deriveWithQuery:query];
}

+ (NSString *)gh_encode:(NSString *)s {	
	// Characters to maybe leave unescaped? CFSTR("~!@#$&*()=:/,;?+'")
  return CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)s, CFSTR("#"), CFSTR("%^{}[]\"\\"), kCFStringEncodingUTF8));
}

+ (NSString *)gh_encodeComponent:(NSString *)s {  
	// Characters to maybe leave unescaped? CFSTR("~!*()'")
  return CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)s, NULL, CFSTR("@#$%^&{}[]=:/,;?+\"\\"), kCFStringEncodingUTF8));
}

+ (NSString *)gh_escapeAll:(NSString *)s {
	// Characters to escape: @#$%^&{}[]=:/,;?+"\~!*()'
  return CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)s, NULL, CFSTR("@#$%^&{}[]=:/,;?+\"\\~!*()'"), kCFStringEncodingUTF8));
}

+ (NSString *)gh_decode:(NSString *)s {
	if (!s) return nil;
  return CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapes(NULL, (CFStringRef)s, CFSTR("")));
}

#if TARGET_OS_OSX

- (void)gh_copyLinkToPasteboard {  
  NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
  [pasteboard declareTypes:[NSArray arrayWithObjects:NSURLPboardType, NSStringPboardType, nil] owner:self];
  [self writeToPasteboard:pasteboard]; // For NSURLPBoardType
  [pasteboard setString:[self absoluteString] forType:NSStringPboardType];
}

+ (BOOL)gh_openFile:(NSString *)path {
  NSString *fileURL = [NSString stringWithFormat:@"file://%@", [self gh_encode:path]];
  NSURL *URL = [NSURL URLWithString:fileURL];
  return [[NSWorkspace sharedWorkspace] openURL:URL];
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
