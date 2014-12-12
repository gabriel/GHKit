//
//  NSStringUtilsTest.m
//  GHKit
//
//  Created by Gabe on 3/30/08.
//  Copyright 2008 rel.me. All rights reserved.
//

#import <GRUnit/GRUnit.h>
#import "GHNSString+Utils.h"

@interface NSStringUtilsTest : GRTestCase { }
@end

@implementation NSStringUtilsTest

#if !TARGET_OS_IPHONE
- (void)testMimeTypes {
  NSString *mimeType = [@"pdf" gh_mimeTypeForExtension];
  GRAssertEqualObjects(@"application/pdf", mimeType, @"Should be pdf mime type");
}
#endif

- (void)testContainsAny {
	NSString *s = @"TestUppercase";
	GRAssertTrue([s gh_containsAny:[NSCharacterSet uppercaseLetterCharacterSet]]);
}

- (void)testLastSplitWithString {
	GRAssertEqualObjects(@"bar", [@"foo:bar" gh_lastSplitWithString:@":" options:NSCaseInsensitiveSearch]);
	GRAssertEqualObjects(@"foobar", [@"foobar" gh_lastSplitWithString:@":" options:NSCaseInsensitiveSearch]);
	
	GRAssertEqualObjects(@"foobar", [@"foobar" gh_lastSplitWithString:@"" options:NSCaseInsensitiveSearch]);
	GRAssertEqualObjects(@"ar", [@"foobar" gh_lastSplitWithString:@"oob" options:NSCaseInsensitiveSearch]);
  
  GRAssertEqualObjects(@"bar:baz", [@"foo:bar:baz" gh_lastSplitWithString:@":" options:NSCaseInsensitiveSearch]);
}

- (void)testSeparate1 {	
	NSArray *expected = [NSArray arrayWithObjects:@"foo", @":", @":", @"bar", nil];	
	NSArray *separated = [@"foo::bar" gh_componentsSeparatedByString:@":" include:YES];
	GRAssertEqualObjects(separated, expected);
}

- (void)testSeparate2 {	
	NSArray *expected = [NSArray arrayWithObjects:@"foo", @"\n", @"bar", nil];	
	NSArray *separated = [@"foo\nbar" gh_componentsSeparatedByString:@"\n" include:YES];
	GRAssertEqualObjects(separated, expected);
}

- (void)testSeparate3 {	
	NSArray *expected = [NSArray arrayWithObjects:@"foo", @"\n", @"\n", @"bar", @"\n", nil];	
	NSArray *separated = [@"foo\n\nbar\n" gh_componentsSeparatedByString:@"\n" include:YES];
	GRAssertEqualObjects(separated, expected);
}

- (void)testReverse {
	GRAssertEqualStrings([@"reversetest" gh_reverse], @"tsetesrever"); // odd # of letters
	GRAssertEqualStrings([@"reverseit!" gh_reverse], @"!tiesrever"); // even # of letters
}

- (void)testStartsWith {
  GRAssertTrue([@"www.test.com" gh_startsWith:@"www." options:0]);
  GRAssertTrue([@"www.test.com" gh_startsWith:@"www.test.com" options:0]);
  GRAssertFalse([@"www.test.com" gh_startsWith:@"" options:0]);
  
  GRAssertTrue([@"www.test.com" gh_startsWith:@"WWW." options:NSCaseInsensitiveSearch]);
  GRAssertTrue([@"WWW.test.com" gh_startsWith:@"www." options:NSCaseInsensitiveSearch]);
  GRAssertTrue([@"www.test.com" gh_startsWith:@"WWW.test.com" options:NSCaseInsensitiveSearch]);
  GRAssertFalse([@"www.test.com" gh_startsWith:@"" options:NSCaseInsensitiveSearch]);
}

- (void)testEndsWith {
  GRAssertTrue([@"path/" gh_endsWith:@"/" options:0]);
  GRAssertFalse([@"path" gh_endsWith:@"/" options:0]);  
  GRAssertTrue([@"path-" gh_endsWith:@"-" options:NSLiteralSearch]);

  GRAssertTrue([@"www.test.com" gh_endsWith:@".com" options:0]);
  GRAssertTrue([@"www.test.com" gh_endsWith:@"www.test.com" options:0]);
  GRAssertFalse([@"www.test.com" gh_endsWith:@"" options:0]);
  
  GRAssertTrue([@"www.test.com" gh_endsWith:@".COM" options:NSCaseInsensitiveSearch]);
  GRAssertTrue([@"www.test.com" gh_endsWith:@"www.test.COM" options:NSCaseInsensitiveSearch]);
  GRAssertFalse([@"www.test.com" gh_endsWith:@"" options:NSCaseInsensitiveSearch]);
}

- (void)testCount {
	GRAssertTrue([@"\n \n\n   \n" gh_count:@"\n"] == 4);
  GRAssertTrue([@"ababababcde" gh_count:@"ab"] == 4);
	GRAssertTrue([@"\n" gh_count:@"\n"] == 1);
	GRAssertTrue([@"" gh_count:@"\n"] == 0);
	GRAssertTrue([@" " gh_count:@"\n"] == 0);
}

- (void)testPresent {
  GRAssertNil([@" " gh_present]);
  GRAssertEqualStrings([@"s" gh_present], @"s");
  
  GRAssertTrue([@"s" gh_isPresent]);
  GRAssertFalse([@" " gh_isPresent]);
  GRAssertFalse([@"" gh_isPresent]);
}

- (void)testSubStringSegmentsWithin {
	
	NSString *test1 = @"This <START>is a<END> test.";
	NSArray *segments1 = [test1 gh_substringSegmentsWithinStart:@"<START>" end:@"<END>"];
	NSArray *expected1 = [NSArray arrayWithObjects:
												[GHNSStringSegment string:@"This " match:NO],
												[GHNSStringSegment string:@"is a" match:YES],
                         [GHNSStringSegment string:@" test." match:NO], nil];
	GRAssertEqualObjects(segments1, expected1);		
	
	NSString *test2 = @"This is a test.";
	NSArray *segments2 = [test2 gh_substringSegmentsWithinStart:@"<START>" end:@"<END>"];
	NSArray *expected2 = [NSArray arrayWithObjects:[GHNSStringSegment string:@"This is a test." match:NO], nil];
	GRAssertEqualObjects(segments2, expected2);	
	
	NSString *test3 = @"<START>This is a test.<END>";
	NSArray *segments3 = [test3 gh_substringSegmentsWithinStart:@"<START>" end:@"<END>"];
	NSArray *expected3 = [NSArray arrayWithObjects:[GHNSStringSegment string:@"This is a test." match:YES], nil];
	GRAssertEqualObjects(segments3, expected3);	

	NSString *test4 = @"<START>This is a test.<END> ";
	NSArray *segments4 = [test4 gh_substringSegmentsWithinStart:@"<START>" end:@"<END>"];
	NSArray *expected4 = [NSArray arrayWithObjects:
												[GHNSStringSegment string:@"This is a test." match:YES],
												[GHNSStringSegment string:@" " match:NO], nil];
	GRAssertEqualObjects(segments4, expected4);	
	
	NSString *test5 = @" <START>This is a test.<END> <END>";
	NSArray *segments5 = [test5 gh_substringSegmentsWithinStart:@"<START>" end:@"<END>"];
	NSArray *expected5 = [NSArray arrayWithObjects:
												[GHNSStringSegment string:@" " match:NO],
												[GHNSStringSegment string:@"This is a test." match:YES],
												[GHNSStringSegment string:@" <END>" match:NO], nil];
	GRAssertEqualObjects(segments5, expected5);	
	
	// TODO: Ok to kill the start token?
	NSString *test6 = @"<START>This is a test.";
	NSArray *segments6 = [test6 gh_substringSegmentsWithinStart:@"<START>" end:@"<END>"];
	NSArray *expected6 = [NSArray arrayWithObjects:[GHNSStringSegment string:@"This is a test." match:YES], nil];
	GRAssertEqualObjects(segments6, expected6);	
	
	// TODO: Return nil on empty string input?
	NSString *test7 = @"";
	NSArray *segments7 = [test7 gh_substringSegmentsWithinStart:@"<START>" end:@"<END>"];
	NSArray *expected7 = [NSArray arrayWithObjects:nil];
	GRAssertEqualObjects(segments7, expected7);	
}

- (void)testRightStrip {
	NSString *text = @"this is a string to right strip   \t";
	NSString *expected = @"this is a string to right strip";
	GRAssertEqualStrings([text gh_rightStrip], expected);
}

- (void)testLeftStrip {
	NSString *text = @"\t   this is a string to left strip";
	NSString *expected = @"this is a string to left strip";
	GRAssertEqualStrings([text gh_leftStrip], expected);
}

- (void)testIsEqualIgnoreCase {
	GRAssertTrue([@"FOoO" gh_isEqualIgnoreCase:@"fooO"]);
}

- (void)testFloatValue {
  GRAssertEquals(5.0f, [@"5.0.1" floatValue]);
}

- (void)testSplit {
  GRAssertEqualStrings(@"", [@"" gh_splitReverseWithString:@""]);
  GRAssertEqualStrings(@"", [@"<<<g@foo.com>" gh_firstSplitWithString:@"<" options:0]);
  GRAssertEqualStrings(@"Test Blah <<", [@"Test Blah <<<g@foo.com>" gh_firstSplitWithString:@"<" options:0]);
  GRAssertEqualStrings(@"<<g@foo.com>", [@"Test Blah <<<g@foo.com>" gh_lastSplitWithString:@"<" options:0]);
  GRAssertEqualStrings(@"g@foo.com>", [@"Test Blah <<<g@foo.com>" gh_splitReverseWithString:@"<"]);
}

- (void)testCharacters {
  NSArray *characters = [@"e̊gâds" gh_characters];
  NSArray *expected = @[@"e̊", @"g", @"â", @"d", @"s"];
  GRAssertEqualObjects(characters, expected);
}

- (void)testRemoveAccents {
  NSString *str = [@"e̊â" gh_removeAccents];
  GRAssertEqualObjects(str, @"ea");
}

#if !TARGET_OS_IPHONE
- (void)testTruncateMiddle {
  NSAttributedString *attributedString = [@"This is a test" gh_truncateMiddle];
  GRTestLog(@"attributedString=%@", attributedString);
}
#endif
	
@end
