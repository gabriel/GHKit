//
//  GHNSString+Utils.m
//
//  Created by Gabe on 3/30/08.
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

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#endif

#import "GHNSString+Utils.h"
#import "GHNSArray+Utils.h"

@implementation NSString(GHUtils)

- (NSString *)gh_strip {
  return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)gh_rightStrip {
  static NSRegularExpression *gRegexRightStrip = nil;
  if (!gRegexRightStrip) gRegexRightStrip = [NSRegularExpression regularExpressionWithPattern:@"[ \t]+$" options:0 error:nil];
  return [gRegexRightStrip stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:@""];
}

- (NSString *)gh_leftStrip {
  static NSRegularExpression *gRegexLeftStrip = nil;
  if (!gRegexLeftStrip) gRegexLeftStrip = [NSRegularExpression regularExpressionWithPattern:@"^[ \t]+" options:0 error:nil];
  return [gRegexLeftStrip stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:@""];
}

+ (BOOL)gh_isBlank:(NSString *)s {
  if (!s) return YES;
  return ([@"" isEqualToString:[s gh_strip]]);
}

- (BOOL)gh_isPresent {
  return ![NSString gh_isBlank:self];
}

- (NSString *)gh_present {
  if ([self gh_isPresent]) return self;
  return nil;
}

- (BOOL)gh_isEqualIgnoreCase:(NSString *)s {
	return [self compare:s options:NSCaseInsensitiveSearch] == NSOrderedSame;
}

#if !TARGET_OS_IPHONE
- (NSString *)gh_mimeTypeForExtension {
	// TODO(gabe): Doesn't look like css extension gets the mime type?
  CFStringRef uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)self, NULL);
  NSString *mime = (__bridge NSString *)UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType);
  CFRelease(uti);
  return mime;
}
#endif

- (BOOL)gh_contains:(NSString *)contains options:(NSStringCompareOptions)options {
  NSRange range = [self rangeOfString:contains options:options];
  return (range.location != NSNotFound);
}

- (NSString *)gh_firstSplitWithString:(NSString *)s options:(NSStringCompareOptions)options {
  NSRange range = [self rangeOfString:s options:options];
  if (range.location != NSNotFound) {
    if (range.location == 0) return @"";
    return [self substringWithRange:NSMakeRange(0, self.length - range.location - 1)];
  }
  return self;
}

- (NSString *)gh_lastSplitWithString:(NSString *)s options:(NSStringCompareOptions)options {
  NSRange range = [self rangeOfString:s options:options];
  if (range.location != NSNotFound) {
    return [self substringWithRange:NSMakeRange(range.location + [s length], [self length] - range.location - [s length])];
  }
  return self;
}

- (NSString *)gh_splitReverseWithString:(NSString *)s {
  return [[self componentsSeparatedByString:s] lastObject];
}

- (NSArray *)gh_componentsSeparatedByString:(NSString *)separator include:(BOOL)include {
	if (!include) return [self componentsSeparatedByString:separator];
	NSArray *strings = [self componentsSeparatedByString:separator];
	NSMutableArray *components = [NSMutableArray arrayWithCapacity:[strings count] * 2];
	NSInteger i = -1;
	NSInteger count = [strings count];
	for(NSString *s in strings) {
		i++;
		if (![s isEqualToString:@""]) [components addObject:s];
		if ((i+1) < count) [components addObject:separator];
	}
	return components;
}

- (BOOL)gh_containsCharacters:(NSString *)characters {
  return [self gh_containsAny:[NSCharacterSet characterSetWithCharactersInString:characters]];
}

- (BOOL)gh_containsAny:(NSCharacterSet *)charSet {
  NSRange range = [self rangeOfCharacterFromSet:charSet];
  return (range.location != NSNotFound);
}

- (BOOL)gh_only:(NSCharacterSet *)charSet {
  return ![self gh_containsAny:[charSet invertedSet]];
}

- (BOOL)gh_startsWithAny:(NSCharacterSet *)charSet {
  NSString *firstChar = [self substringToIndex:1];
  return [firstChar gh_containsAny:charSet];
}

- (BOOL)gh_startsWith:(NSString *)startsWith {
  return [self hasPrefix:startsWith];
}

- (BOOL)gh_startsWith:(NSString *)startsWith options:(NSStringCompareOptions)options {
  if (!startsWith || [startsWith isEqual:@""]) return NO;
  if ([self length] < [startsWith length]) return NO;
  NSString *beginning = [self substringToIndex:[startsWith length]];
  return ([beginning compare:startsWith options:options] == NSOrderedSame);  
}

- (BOOL)gh_endsWith:(NSString *)endsWith options:(NSStringCompareOptions)options {
  if (!endsWith || [endsWith isEqual:@""]) return NO;
  if ([self length] < [endsWith length]) return NO;
  NSString *lastString = [self substringFromIndex:[self length] - [endsWith length]];
  return ([lastString compare:endsWith options:options] == NSOrderedSame);
}

- (NSString *)gh_attributize {
  NSString *end = [self substringFromIndex:1];
  NSString *start = [[self substringToIndex:1] lowercaseString];
  return [start stringByAppendingString:end];
}

- (NSString *)gh_fullPathExtension {
  NSString *extension = [self pathExtension];
  if (![extension isEqualToString:@""]) extension = [NSString stringWithFormat:@".%@", extension];
  return extension;
}

- (NSString *)gh_reverse {
	NSInteger length = [self length];
	unichar *buffer = calloc(length, sizeof(unichar));
	
	// TODO(gabe): Apparently getCharacters: is really slow
	[self getCharacters:buffer range:NSMakeRange(0, length)];
	
	for(int i = 0, mid = ceil(length/2.0); i < mid; i++) {
		unichar c = buffer[i];
		buffer[i] = buffer[length-i-1];
		buffer[length-i-1] = c;
	}
	
	NSString *s = [[NSString alloc] initWithCharacters:buffer length:length];
	free(buffer);
  return s;
}

- (NSInteger)gh_count:(NSString *)s {
	NSRange inRange = NSMakeRange(0, [self length]);
	NSInteger count = 0;
	while (YES) {
		NSRange range = [self rangeOfString:s options:0 range:inRange];
		if (range.location == NSNotFound) break;
		inRange.location = range.location + range.length;
		inRange.length = [self length] - range.location - range.length;
		count++;
	}
	return count;
}

+ (NSMutableCharacterSet *)gh_characterSetsUnion:(NSArray *)characterSets {
  NSMutableCharacterSet *charSet = [NSMutableCharacterSet characterSetWithCharactersInString:@""];
  for(NSCharacterSet *set in characterSets)
    [charSet formUnionWithCharacterSet:set];
  
  return charSet;
}

- (NSArray *)gh_substringSegmentsWithinStart:(NSString *)start end:(NSString *)end {
	NSMutableArray *segments = [NSMutableArray array];
	BOOL within = NO;

	NSScanner *scanner = [NSScanner scannerWithString:self];
	[scanner setCharactersToBeSkipped:nil];

	// If we start with start token, the scanner ignores it... 
	if ([self gh_startsWith:start]) {
		[scanner scanString:start intoString:nil];
		within = YES;
	}
	
	NSString *scanned = nil;
	
	while([scanner scanUpToString:(within ? end : start) intoString:&scanned]) {
		if (scanned && [scanned length] > 0)
			[segments addObject:[GHNSStringSegment string:scanned match:within]];
		
		[scanner scanString:(within ? end : start) intoString:&scanned]; // Eat start or end token
		scanned = nil;
		within = !within;
	}
	NSUInteger length = [self length] - [scanner scanLocation];
	if (length > 0)
		[segments addObject:[GHNSStringSegment string:[self substringWithRange:NSMakeRange([scanner scanLocation], length)] match:NO]];
	return segments;
}

// Based on code by powidl
// http://www.codecollector.net/view/4900E3BB-032E-4E89-81C7-34097E98C286
- (NSString *)gh_rot13 {
  const char *cString = [self cStringUsingEncoding:NSASCIIStringEncoding];
  NSInteger stringLength = [self length];
  char newString[stringLength + 1];
  
  NSInteger i;
  for (i = 0; i < stringLength; i++) {
    unsigned char character = cString[i];
    // Check if character is A - Z
    if(0x40 < character && character < 0x5B)
      newString[i] = (((character - 0x41) + 0x0D) % 0x1A) + 0x41;
    // Check if character is a - z
    else if( 0x60 < character && character < 0x7B )
      newString[i] = (((character - 0x61) + 0x0D) % 0x1A) + 0x61;
    else
      newString[i] = character;
  }
  
  newString[i] = '\0';
  
  return [NSString stringWithCString:newString encoding:NSASCIIStringEncoding];
}

// From http://stackoverflow.com/questions/4158646/most-efficient-way-to-iterate-over-all-the-chars-in-an-nsstring
- (NSArray *)gh_characters {
  NSMutableArray  *chars = [NSMutableArray array];
  [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock: ^(NSString *inSubstring, NSRange inSubstringRange, NSRange inEnclosingRange, BOOL *outStop) {
    [chars addObject:inSubstring];
  }];
  return chars;
}

- (NSString *)gh_removeAccents {
  return [self stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
}

@end

@implementation GHNSStringSegment

- (id)initWithString:(NSString *)string match:(BOOL)match {
	if ((self = [super init])) {
		_string = string;
		_match = match;
	}
	return self;	
}

+ (GHNSStringSegment *)string:(NSString *)string match:(BOOL)match {
  return [[self alloc] initWithString:string match:match];
}

- (BOOL)isEqual:(id)obj {
	return ([[obj string] isEqual:_string] && [obj isMatch] == _match);
}

- (NSString *)description {
	return [NSString stringWithFormat:@"string=%@, isMatch=%d", _string, _match];
}

@end
