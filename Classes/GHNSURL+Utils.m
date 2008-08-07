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

/*!
 @method paramsToString
 @abstract Dictionary to params string. Escapes any url specific characters.
 @param params Dictionary of key value params
 @result Param string, ?key1=value1&key2=value2
*/
+ (NSString *)paramsToString:(NSDictionary *)params {
  if (!params || [params count] == 0) return nil;
  
  NSMutableArray *paramStrings = [NSMutableArray arrayWithCapacity:[params count]];
  for(NSString *key in params) {
    NSString *value = [params valueForKey:key];
    NSString *newKey = [self escapeAll:key];
    NSString *newValue = [self escapeAll:value];
    [paramStrings addObject:[NSString stringWithFormat:@"%@=%@", newKey, newValue]];
  }
  return [paramStrings componentsJoinedByString:@"&"];
}

/*!
 @method escape
 @param s String to escape
 @abstract Escape url characters (all except /)
 @result Escaped string
*/
+ (NSString *)escape:(NSString *)s {
  return [(NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)s, NULL, CFSTR(",+?&="), kCFStringEncodingUTF8) autorelease];
}

/*!
 @method escapeAll
 @param s String to escape
 @abstract Escape all url characters
 @result Escaped string
 */
+ (NSString *)escapeAll:(NSString *)s {  
  return [(NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)s, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8) autorelease];
}


#ifndef TARGET_OS_IPHONE

/*!
 @method copyLinkToPasteboard
 @abstract Copy url to pasteboard
 */
- (void)copyLinkToPasteboard {  
  NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
  [pasteboard declareTypes:[NSArray arrayWithObjects:NSURLPboardType, NSStringPboardType, nil] owner:self];
  [self writeToPasteboard:pasteboard]; // For NSURLPBoardType
  [pasteboard setString:[self absoluteString] forType:NSStringPboardType];
}

/*!
 @method openFile
 @param path Path to open
 @abstract Open file path
 */
+ (void)openFile:(NSString *)path {
  NSString *fileURL = [NSString stringWithFormat:@"file://%@", [self escape:path]];
  NSURL *url = [NSURL URLWithString:fileURL];
  [[NSWorkspace sharedWorkspace] openURL:url];
}


/*!
 @method openContaingFolder
 @param path
 @abstract Open folder (in Finder probably) for file path.
 */
+ (void)openContainingFolder:(NSString *)path {
  BOOL isDir;
  if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir] && isDir)
    [self openFile:path];
  else
    [self openFile:[path stringByDeletingLastPathComponent]];
}

#endif

@end
