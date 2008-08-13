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

- (BOOL)gh_isBlank;
- (NSString *)gh_strip;

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

@end
