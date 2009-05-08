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

#import "GHNSString+Utils.h"

#import "GTMRegex.h"

@implementation NSString (GHUtils)

- (NSString *)gh_strip {
  return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)gh_rightStrip {
	return [self gtm_stringByReplacingMatchesOfPattern:@"[ \t]+$" withReplacement:@""];
}

- (NSString *)gh_leftStrip {
	return [self gtm_stringByReplacingMatchesOfPattern:@"^[ \t]+" withReplacement:@""];
}


- (BOOL)gh_isBlank {
  return ([@"" isEqualToString:[self gh_strip]]);
}

+ (BOOL)gh_isBlank:(NSString *)s {
  if (!s) return YES;
  return [s gh_isBlank];
}

#ifndef TARGET_OS_IPHONE
static NSDictionary *gh_gTruncateMiddle = nil;

/*!
 @method gh_truncateMiddle
 @result Attributed string to ellipsis in the middle
*/
- (NSAttributedString *)gh_truncateMiddle {
  if (!gh_gTruncateMiddle) {
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setLineBreakMode:NSLineBreakByTruncatingMiddle];
    gh_gTruncateMiddle = [[NSDictionary alloc] initWithObjectsAndKeys:style, NSParagraphStyleAttributeName, nil];
		[style release];
  }
 
  return [[[NSAttributedString alloc] initWithString:self attributes:gh_gTruncateMiddle] autorelease];
}

/*!
 @method gh_mimeTypeForExtension
 @abstract Mime type for extension (e.g. pdf, png, txt)
 @result Mime type
*/
- (NSString *)gh_mimeTypeForExtension {
  CFStringRef uti = UTTypeCreatePreferredIdentifierForTag (kUTTagClassFilenameExtension, (CFStringRef)self, NULL);    
  NSString *mime = (NSString *)UTTypeCopyPreferredTagWithClass (uti, kUTTagClassMIMEType);
  CFRelease(uti);
  return [mime autorelease];
}
#endif

/*!
 @method gh_contains
 @abstract Check if self contains the specified string with options
 @param contains String to look for
 @param options Options
 @result YES if string has the substring
*/
- (BOOL)gh_contains:(NSString *)contains options:(NSStringCompareOptions)options {
  NSRange range = [self rangeOfString:contains options:options];
  return (range.location != NSNotFound);
}

/*!
 @method gh_lastSplitWithString
 @abstract 
   Get last part of string separated by the specified string. For example, [@"foo:bar" gh_splitWithString:@":"] => bar
   If no string is found, returns self.
 
 @param s String to split on
 @param options Options
 @result Last part of string split by string. 
*/
- (NSString *)gh_lastSplitWithString:(NSString *)s options:(NSStringCompareOptions)options {
  NSRange range = [self rangeOfString:s options:options];
  if (range.location != NSNotFound) {
    return [self substringWithRange:NSMakeRange(range.location + [s length], [self length] - range.location - [s length])];
  }
  return self;
}

- (NSArray *)gh_cutWithString:(NSString *)cutWith options:(NSStringCompareOptions)options {
	return [self gh_cutWithString:cutWith options:options cutAfter:YES];
}

- (NSArray *)_gh_cutWithString:(NSString *)cutWith characterSet:(NSCharacterSet *)characterSet options:(NSStringCompareOptions)options cutAfter:(BOOL)cutAfter {	
	NSMutableArray *words = [NSMutableArray array];
	NSInteger location = 0;
	
	while(location <= [self length]) {
		NSRange previousRange = NSMakeRange(location, [self length] - location);
		NSRange range;
		if (cutWith) range = [self rangeOfString:cutWith options:options range:previousRange];
		if (characterSet) range = [self rangeOfCharacterFromSet:characterSet options:options range:previousRange];
		
		NSInteger foundLocation = 0;
		if (range.location == NSNotFound) {
			foundLocation = [self length];
		} else {
			foundLocation = range.location;
			if (cutAfter) {
				if (cutWith) foundLocation += [cutWith length];
				else foundLocation += 1;
			}			
		}
		if (!cutAfter && location != 0) {
			if (cutWith) location -= [cutWith length];
			else location -= 1;
		}
		
		NSInteger length = foundLocation - location;
		
		NSRange substringRange = NSMakeRange(location, length);		
		NSString *word = [self substringWithRange:substringRange];
		[words addObject:word];
		location = foundLocation;
		//NSLog(@"self=%@, word=%@, range=%@, substringRange=%@, location=%d", self, word, NSStringFromRange(range), NSStringFromRange(substringRange), location);
		if (!cutAfter) {
			if (cutWith) location += [cutWith length];
			else location += 1;
		}
  }
	if ([words count] == 0) [words addObject:@""]; // If we fell through with nothing, was empty string
	return words;	
}

- (NSArray *)gh_cutWithString:(NSString *)cutWith options:(NSStringCompareOptions)options cutAfter:(BOOL)cutAfter {
	return [self _gh_cutWithString:cutWith characterSet:nil options:options cutAfter:cutAfter];
}

- (NSArray *)gh_cutWithCharacterFromSet:(NSCharacterSet *)characterSet options:(NSStringCompareOptions)options cutAfter:(BOOL)cutAfter {
	return [self _gh_cutWithString:nil characterSet:characterSet options:options cutAfter:cutAfter];
}

/*!
 @method gh_containsCharacters
 @abstract Check if self contains any of the characters in the specified string
 @param characters Characters to look for
 @result YES if string has any of the characters
*/
- (BOOL)gh_containsCharacters:(NSString *)characters {
  return [self gh_containsAny:[NSCharacterSet characterSetWithCharactersInString:characters]];
}

/*!
 @method gh_containsAny
 @param charSet Character set
 @result YES if string contains any characters from the set
*/
- (BOOL)gh_containsAny:(NSCharacterSet *)charSet {
  NSRange range = [self rangeOfCharacterFromSet:charSet];
  return (range.location != NSNotFound);
}

/*!
 @method gh_only
 @abstract Check if string has only characters from set
 @param charSet Character set
 @result YES if string has only characters from the specified set.
*/
- (BOOL)gh_only:(NSCharacterSet *)charSet {
  return ![self gh_containsAny:[charSet invertedSet]];
}

/*!
 @method gh_startsWithAny
 @param charSet Character set
 @result YES if the first character is in the set
*/
- (BOOL)gh_startsWithAny:(NSCharacterSet *)charSet {
  NSString *firstChar = [self substringToIndex:1];
  return [firstChar gh_containsAny:charSet];
}

/*!
 @method gh_startsWith
 @param startsWith
 @abstract Check if string starts with string
 @result YES if string starts with string
*/
- (BOOL)gh_startsWith:(NSString *)startsWith {
  return [self gh_startsWith:startsWith options:0];
}

/*!
 @method gh_startsWith
 @param startsWith
 @param options
 @abstract Check if string starts with string
 @result YES if string starts with string
 */
- (BOOL)gh_startsWith:(NSString *)startsWith options:(NSStringCompareOptions)options {
  if ([self length] < [startsWith length]) return NO;
  NSString *beginning = [self substringToIndex:[startsWith length]];
  return ([beginning compare:startsWith options:options] == NSOrderedSame);  
}

/*!
 @method gh_endsWith
 @param endsWith
 @abstract Check if string ends with string
 @result YES if string ends with string
 */
- (BOOL)gh_endsWith:(NSString *)endsWith options:(NSStringCompareOptions)options {
  if ([self length] < [endsWith length]) return NO;
  NSString *lastString = [self substringFromIndex:[self length] - 1];
  return ([lastString compare:endsWith options:options] == NSOrderedSame);
}

/*!
 @method gh_attributize
 @abstract Turn string into attribute
 @result With first letter lower-cased
*/
- (NSString *)gh_attributize {
  NSString *end = [self substringFromIndex:1];
  NSString *start = [[self substringToIndex:1] lowercaseString];
  return [start stringByAppendingString:end];
}

/*!
 @method gh_fullPathExtension
 @abstract Path extension with . or "" as before
 
 "spliff.tiff" => ".tiff"
 "spliff" => ""
 
*/
- (NSString *)gh_fullPathExtension {
  NSString *extension = [self pathExtension];
  if (![extension isEqualToString:@""]) extension = [NSString stringWithFormat:@".%@", extension];
  return extension;
}

/*!
 @method gh_uuid
 @abstract Create UUID
*/
+ (NSString *)gh_uuid {
  CFUUIDRef	uuidRef = CFUUIDCreate(nil);
  
  NSString *uuid = (NSString *)CFUUIDCreateString(nil, uuidRef);
  CFRelease(uuidRef);
  
  return [uuid autorelease];
}

/*!
  @method gh_characterSetsUnion
  @abstract Combined character sets.
*/
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
			[segments addObject:[GHNSStringSegment string:scanned isMatch:within]];
		
		[scanner scanString:(within ? end : start) intoString:&scanned]; // Eat start or end token
		scanned = nil;
		within = !within;
	}
	NSUInteger length = [self length] - [scanner scanLocation];
	if (length > 0)
		[segments addObject:[GHNSStringSegment string:[self substringWithRange:NSMakeRange([scanner scanLocation], length)] isMatch:NO]];
	return segments;
}

@end

@implementation GHNSStringSegment

@synthesize string=string_, match=isMatch_;

- (id)initWithString:(NSString *)string isMatch:(BOOL)isMatch {
	if ((self = [super init])) {
		string_ = [string retain];
		isMatch_ = isMatch;
	}
	return self;	
}

+ (GHNSStringSegment *)string:(NSString *)string isMatch:(BOOL)isMatch {
	return [[[self alloc] initWithString:string isMatch:isMatch] autorelease];
}

- (BOOL)isEqual:(id)obj {
	return ([[obj string] isEqual:string_] && [obj isMatch] == isMatch_);
}

- (NSString *)description {
	return [NSString stringWithFormat:@"string=%@, isMatch=%d", string_, isMatch_];
}

- (void)dealloc {
	[string_ release];
	[super dealloc];
}

@end
