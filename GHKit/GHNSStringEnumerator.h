//
//  GHNSStringEnumerator.h
//  GHKit
//
//  Created by Gabriel Handford on 6/12/09.
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

#import <Foundation/Foundation.h>

/*!
 For scanning, and enumerating strings.
 
     NSString *string = @"matz can't\n patch blues";
     GHNSStringEnumerator *enumerator = [[GHNSStringEnumerator alloc] initWithString:string separatorCharacterSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
     
     NSArray *results = [enumerator allObjects];
     NSArray *expected = [NSArray arrayWithObjects:@"matz", @" ", @"can't", @"\n ", @"patch", @" ", @"blues", nil];
     XCTAssertEqualObjects(results, expected, nil);

 */
@interface GHNSStringEnumerator : NSEnumerator {
	NSScanner *_scanner;
	
	NSCharacterSet *_separatorCharacterSet;
	NSString *_separatorString;
	
	BOOL _inSeparator;
}

@property (readonly, nonatomic, getter=isInSeparator) BOOL inSeparator;

/*!
 Create string enumerator with string and separator character set.

 @param string String
 @param separatorCharacterSet Separator characters
 */
- (id)initWithString:(NSString *)string separatorCharacterSet:(NSCharacterSet *)separatorCharacterSet;

/*!
 Create string enumerator with string and separator character set.

 @param string String
 @param separatorString Separator characters
 */
- (id)initWithString:(NSString *)string separatorString:(NSString *)separatorString;

/*!
 Next string.

 @result Next string
 */
- (NSString *)nextString;

@end
