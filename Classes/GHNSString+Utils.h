//
//  GHNSString+Utils.h
//
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

@interface NSString (GHUtils)

/*!
 Create string with format from array of arguments.
 Arguments must be objective-c objects.
 WARNING: This assumption seems totally dangerous.
 @param format
 @param arguments
 */
+ (id)gh_stringWithFormat:(NSString *)format arguments:(NSArray *)arguments;

/*!
 @method gh_isBlank
 @result YES if string is empty (after stripping)
 */
- (BOOL)gh_isBlank;

/*!
 Check if equals ignoring case.
 @param s
 @result True if equal regardless of case
 */
- (BOOL)gh_isEqualIgnoreCase:(NSString *)s;

/*!
 @method gh_strip
 @result String with characters trimmed
 */
- (NSString *)gh_strip;

/*!
 Trim whitespace from right side only.
 */
- (NSString *)gh_rightStrip;

/*!
 Trim white space from left side only.
 */
- (NSString *)gh_leftStrip;

/*!
 Reverse the string.
 @result Reversed
 */
- (NSString *)gh_reverse;

/*!
 Count the number of times a string appears.
 @param s
 @result Number of times it appears
 */
- (NSInteger)gh_count:(NSString *)s;

/*!
 @method gh_isBlank
 @param s
 @result YES if string is nil, empty or whitespace characters
 */
+ (BOOL)gh_isBlank:(NSString *)s;

#ifndef TARGET_OS_IPHONE
- (NSAttributedString *)gh_truncateMiddle;
- (NSString *)gh_mimeTypeForExtension;
#endif

- (BOOL)gh_containsCharacters:(NSString *)characters;
- (BOOL)gh_containsAny:(NSCharacterSet *)charSet;
- (BOOL)gh_only:(NSCharacterSet *)charSet;
- (BOOL)gh_startsWithAny:(NSCharacterSet *)charSet;
- (BOOL)gh_startsWith:(NSString *)startsWith;
- (BOOL)gh_startsWith:(NSString *)startsWith options:(NSStringCompareOptions)options;
- (BOOL)gh_endsWith:(NSString *)endsWith options:(NSStringCompareOptions)options;
- (BOOL)gh_contains:(NSString *)contains options:(NSStringCompareOptions)options;

- (NSString *)gh_attributize;

- (NSString *)gh_fullPathExtension;

+ (NSMutableCharacterSet *)gh_characterSetsUnion:(NSArray *)characterSets;
+ (NSString *)gh_uuid;

/*!
 Get last part of string separated by the specified string. 
 
 @code
 [@"foo:bar" gh_lastSplitWithString:@":" options:0] => bar
 @endcode
  
 @param s String to split on
 @param options Options
 @result Last part of string split by string. If no string is found, returns self.
*/
- (NSString *)gh_lastSplitWithString:(NSString *)s options:(NSStringCompareOptions)options;

/*!
 Components separated by string with option to include separator.
 
 @code
 [@"foo::bar" gh_componentsSeparatedByString:@":" include:YES] => [@"foo", @":", @":", @"bar"];
 @endcode
 
 @param s String to separate
 @param include Whether to include separator
 @result Components
 */
- (NSArray *)gh_componentsSeparatedByString:(NSString *)s include:(BOOL)include;

/*!
 @method gh_subStringSegmentsWithinStart
 @param start Start token
 @param end End token
 @result Array of GHNSStringSegment's
 
 Use a regex engine if you can. 
 Note: This exists because regex.h is posix only and does not support non-greedy expressions.
 Why Apple must you not give us objc regex library?
 
 Get string segments, within start and end tokens.
 For example,
	[@"This is <START>a test<END> string" subStringSegmentsWithinStart:@"<START>" end:@"<END>"] => [@"This is ", @"a test", @" string"]
 
 */
- (NSArray *)gh_substringSegmentsWithinStart:(NSString *)start end:(NSString *)end;

/*!
 Rot13.
 Based on code by powidl
 http://www.codecollector.net/view/4900E3BB-032E-4E89-81C7-34097E98C286
 @param input
 */
+ (NSString *)gh_rot13:(NSString *)input;

@end

/*!
 Class used by gh_substringSegmentsWithinStart:end:
 */
@interface GHNSStringSegment : NSObject {
	NSString *string_;
	BOOL isMatch_;
}


@property (readonly) NSString *string;
@property (readonly, getter=isMatch) BOOL match;

- (id)initWithString:(NSString *)string isMatch:(BOOL)isMatch;

+ (GHNSStringSegment *)string:(NSString *)string isMatch:(BOOL)isMatch;

@end
