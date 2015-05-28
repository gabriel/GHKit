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

#import <Foundation/Foundation.h>

/*!
 Utilities for strings, for example, stripping, reversing, counting, UUID, MD5 and more.
 */
@interface NSString(GHUtils)

/*!
 Check if equals ignoring case.
 
 @param s String
 @result True if equal regardless of case
 */
- (BOOL)gh_isEqualIgnoreCase:(NSString *)s;

/*!
 Strip whitespace from left and right side of string.
 
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
 
 @param s String
 @result Number of times it appears
 */
- (NSInteger)gh_count:(NSString *)s;

/*!
 Check if string is blank.
 
 @param s String
 @result YES if string is nil, empty or whitespace characters
 */
+ (BOOL)gh_isBlank:(NSString *)s;

/*!
 Check if string is not blank. Not blank means not nil and not just whitespace.
 */
- (BOOL)gh_isPresent;

/*!
 Returns self if not empty or whitespace. (If empty or whitespace returns nil)
 @" ", @"" returns nil.
 */
- (NSString *)gh_present;

/*!
 Returns self if not empty or whitespace, otherwise value.

 @param value
 @return self or value
 */
- (NSString *)gh_present:(NSString *)value;

/*!
 Get characters as an array of single length strings.
 */
- (NSArray *)gh_characters;

/*!
 Remove accents.
 */
- (NSString *)gh_removeAccents;

#if !TARGET_OS_IPHONE
/*!
 Get mime type for extension.
 
 @result Mime type for extension
 */
- (NSString *)gh_mimeTypeForExtension;
#endif

/*!
 Check if string contains ANY characters from a string.
 
 @param characters String representing characters to check for
 @result YES If string contains characters
 */
- (BOOL)gh_containsCharacters:(NSString *)characters;

/*!
 Check if string contains ANY characters from a set.
 
 @param charSet Char set
 @result YES If string contains any characters
 */
- (BOOL)gh_containsAny:(NSCharacterSet *)charSet;

/*!
 Check if string contains only characters from a set.
 
 @param charSet Character set
 @result YES If string contains only these characters
 */
- (BOOL)gh_only:(NSCharacterSet *)charSet;

/*!
 Check if string starts with any of the character set.
 
 @param charSet Character set.
 */
- (BOOL)gh_startsWithAny:(NSCharacterSet *)charSet;

/*!
 Check if string starts with a string.
 
 Returns NO if startsWith is empty.
 
 @param startsWith String to check
 @result YES if string starts with string
 */
- (BOOL)gh_startsWith:(NSString *)startsWith;

/*!
 Check if string starts with a string.

 Returns NO if startsWith is empty.

 @param startsWith String to check
 @param options Compare options
 @result YES if string starts with string
 */
- (BOOL)gh_startsWith:(NSString *)startsWith options:(NSStringCompareOptions)options;

/*!
 Check if string ends with a string.
 
 Returns NO if endsWith is empty.
 
 @param endsWith String to check
 @param options Compare options
 @result YES if string ends with string
 */
- (BOOL)gh_endsWith:(NSString *)endsWith options:(NSStringCompareOptions)options;

/*!
 Check if self contains the specified string with options
 
 @param contains String to look for
 @param options Options
 @result YES if string has the substring
 */
- (BOOL)gh_contains:(NSString *)contains options:(NSStringCompareOptions)options;

/*!
 Turn string into attribute.
 
 @result With first letter lower-cased
 */
- (NSString *)gh_attributize;

/*!
 Path extension with . or "" as before.
 
     "spliff.tiff" => ".tiff"
     "spliff" => ""
 
 @result Full path extension with . 
 */
- (NSString *)gh_fullPathExtension;

/*!
 Combine character sets.
 
 @param characterSets Character sets to union
 @result Combined character sets
 */
+ (NSMutableCharacterSet *)gh_characterSetsUnion:(NSArray *)characterSets;

/*!
 Get last part of string separated by the (first occurence of the) specified string.
 
     [@"foo:bar" gh_lastSplitWithString:@":" options:0] => bar
     [@"foo:bar:bar" gh_lastSplitWithString:@":" options:0] => bar:bar

 @param s String to split on
 @param options Options
 @result Split by string. If no string is found, returns self.
*/
- (NSString *)gh_lastSplitWithString:(NSString *)s options:(NSStringCompareOptions)options;

- (NSString *)gh_firstSplitWithString:(NSString *)s options:(NSStringCompareOptions)options;

/*!
*/
- (NSString *)gh_splitReverseWithString:(NSString *)s;

/*!
 Components separated by string with option to include separator.
 
     [@"foo::bar" gh_componentsSeparatedByString:@":" include:YES] => [@"foo", @":", @":", @"bar"];
 
 @param s String to separate
 @param include Whether to include separator
 @result Components
 */
- (NSArray *)gh_componentsSeparatedByString:(NSString *)s include:(BOOL)include;

/*!
 Break string into segments based on start and end token.
 
 Use a regex engine if you can. 
 Note: This exists because regex.h is posix only and does not support non-greedy expressions.
 Why Apple must you not give us objc regex library?
 
 Get string segments, within start and end tokens.
 For example,

     [@"This is <START>a test<END> string" subStringSegmentsWithinStart:@"<START>" end:@"<END>"] => [@"This is ", @"a test", @" string"]

 
 @param start Start token
 @param end End token
 @result Array of GHNSStringSegment's 
 */
- (NSArray *)gh_substringSegmentsWithinStart:(NSString *)start end:(NSString *)end;

/*!
 Rot13.
 
 Based on code by powidl.
 http://www.codecollector.net/view/4900E3BB-032E-4E89-81C7-34097E98C286
 */
- (NSString *)gh_rot13;

@end

//! @cond DEV

/*
 Class used by gh_substringSegmentsWithinStart:end:
 */
@interface GHNSStringSegment : NSObject

@property (readonly) NSString *string;
@property (readonly, getter=isMatch) BOOL match;

- (id)initWithString:(NSString *)string match:(BOOL)match;

+ (GHNSStringSegment *)string:(NSString *)string match:(BOOL)match;

@end

//! @endcond
