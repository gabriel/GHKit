//
//  NSStringUtilsTest.m
//  GHKit
//
//  Created by Gabe on 3/30/08.
//  Copyright 2008 rel.me. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

@import GHKit;

@interface NSStringUtilsTest : XCTestCase { }
@end

@implementation NSStringUtilsTest

- (void)testContainsAny {
	NSString *s = @"TestUppercase";
	XCTAssertTrue([s gh_containsAny:[NSCharacterSet uppercaseLetterCharacterSet]]);
}

- (void)testLastSplitWithString {
	XCTAssertEqualObjects(@"bar", [@"foo:bar" gh_lastSplitWithString:@":" options:NSCaseInsensitiveSearch]);
	XCTAssertEqualObjects(@"foobar", [@"foobar" gh_lastSplitWithString:@":" options:NSCaseInsensitiveSearch]);
	
	XCTAssertEqualObjects(@"foobar", [@"foobar" gh_lastSplitWithString:@"" options:NSCaseInsensitiveSearch]);
	XCTAssertEqualObjects(@"ar", [@"foobar" gh_lastSplitWithString:@"oob" options:NSCaseInsensitiveSearch]);
  
  XCTAssertEqualObjects(@"bar:baz", [@"foo:bar:baz" gh_lastSplitWithString:@":" options:NSCaseInsensitiveSearch]);
}

- (void)testSeparate1 {	
	NSArray *expected = [NSArray arrayWithObjects:@"foo", @":", @":", @"bar", nil];	
	NSArray *separated = [@"foo::bar" gh_componentsSeparatedByString:@":" include:YES];
	XCTAssertEqualObjects(separated, expected);
}

- (void)testSeparate2 {	
	NSArray *expected = [NSArray arrayWithObjects:@"foo", @"\n", @"bar", nil];	
	NSArray *separated = [@"foo\nbar" gh_componentsSeparatedByString:@"\n" include:YES];
	XCTAssertEqualObjects(separated, expected);
}

- (void)testSeparate3 {	
	NSArray *expected = [NSArray arrayWithObjects:@"foo", @"\n", @"\n", @"bar", @"\n", nil];	
	NSArray *separated = [@"foo\n\nbar\n" gh_componentsSeparatedByString:@"\n" include:YES];
	XCTAssertEqualObjects(separated, expected);
}

- (void)testReverse {
	XCTAssertEqualObjects([@"reversetest" gh_reverse], @"tsetesrever"); // odd # of letters
	XCTAssertEqualObjects([@"reverseit!" gh_reverse], @"!tiesrever"); // even # of letters
}

- (void)testStartsWith {
  XCTAssertTrue([@"www.test.com" gh_startsWith:@"www." options:0]);
  XCTAssertTrue([@"www.test.com" gh_startsWith:@"www.test.com" options:0]);
  XCTAssertFalse([@"www.test.com" gh_startsWith:@"" options:0]);
  
  XCTAssertTrue([@"www.test.com" gh_startsWith:@"WWW." options:NSCaseInsensitiveSearch]);
  XCTAssertTrue([@"WWW.test.com" gh_startsWith:@"www." options:NSCaseInsensitiveSearch]);
  XCTAssertTrue([@"www.test.com" gh_startsWith:@"WWW.test.com" options:NSCaseInsensitiveSearch]);
  XCTAssertFalse([@"www.test.com" gh_startsWith:@"" options:NSCaseInsensitiveSearch]);
}

- (void)testEndsWith {
  XCTAssertTrue([@"path/" gh_endsWith:@"/" options:0]);
  XCTAssertFalse([@"path" gh_endsWith:@"/" options:0]);  
  XCTAssertTrue([@"path-" gh_endsWith:@"-" options:NSLiteralSearch]);

  XCTAssertTrue([@"www.test.com" gh_endsWith:@".com" options:0]);
  XCTAssertTrue([@"www.test.com" gh_endsWith:@"www.test.com" options:0]);
  XCTAssertFalse([@"www.test.com" gh_endsWith:@"" options:0]);
  
  XCTAssertTrue([@"www.test.com" gh_endsWith:@".COM" options:NSCaseInsensitiveSearch]);
  XCTAssertTrue([@"www.test.com" gh_endsWith:@"www.test.COM" options:NSCaseInsensitiveSearch]);
  XCTAssertFalse([@"www.test.com" gh_endsWith:@"" options:NSCaseInsensitiveSearch]);
}

- (void)testCount {
	XCTAssertTrue([@"\n \n\n   \n" gh_count:@"\n"] == 4);
  XCTAssertTrue([@"ababababcde" gh_count:@"ab"] == 4);
	XCTAssertTrue([@"\n" gh_count:@"\n"] == 1);
	XCTAssertTrue([@"" gh_count:@"\n"] == 0);
	XCTAssertTrue([@" " gh_count:@"\n"] == 0);
}

- (void)testPresent {
  XCTAssertNil([@" " gh_present]);
  XCTAssertEqualObjects([@"s" gh_present], @"s");
  
  XCTAssertTrue([@"s" gh_isPresent]);
  XCTAssertFalse([@" " gh_isPresent]);
  XCTAssertFalse([@"" gh_isPresent]);
}

- (void)testSubStringSegmentsWithin {
	
	NSString *test1 = @"This <START>is a<END> test.";
	NSArray *segments1 = [test1 gh_substringSegmentsWithinStart:@"<START>" end:@"<END>"];
	NSArray *expected1 = [NSArray arrayWithObjects:
												[GHNSStringSegment string:@"This " match:NO],
												[GHNSStringSegment string:@"is a" match:YES],
                         [GHNSStringSegment string:@" test." match:NO], nil];
	XCTAssertEqualObjects(segments1, expected1);		
	
	NSString *test2 = @"This is a test.";
	NSArray *segments2 = [test2 gh_substringSegmentsWithinStart:@"<START>" end:@"<END>"];
	NSArray *expected2 = [NSArray arrayWithObjects:[GHNSStringSegment string:@"This is a test." match:NO], nil];
	XCTAssertEqualObjects(segments2, expected2);	
	
	NSString *test3 = @"<START>This is a test.<END>";
	NSArray *segments3 = [test3 gh_substringSegmentsWithinStart:@"<START>" end:@"<END>"];
	NSArray *expected3 = [NSArray arrayWithObjects:[GHNSStringSegment string:@"This is a test." match:YES], nil];
	XCTAssertEqualObjects(segments3, expected3);	

	NSString *test4 = @"<START>This is a test.<END> ";
	NSArray *segments4 = [test4 gh_substringSegmentsWithinStart:@"<START>" end:@"<END>"];
	NSArray *expected4 = [NSArray arrayWithObjects:
												[GHNSStringSegment string:@"This is a test." match:YES],
												[GHNSStringSegment string:@" " match:NO], nil];
	XCTAssertEqualObjects(segments4, expected4);	
	
	NSString *test5 = @" <START>This is a test.<END> <END>";
	NSArray *segments5 = [test5 gh_substringSegmentsWithinStart:@"<START>" end:@"<END>"];
	NSArray *expected5 = [NSArray arrayWithObjects:
												[GHNSStringSegment string:@" " match:NO],
												[GHNSStringSegment string:@"This is a test." match:YES],
												[GHNSStringSegment string:@" <END>" match:NO], nil];
	XCTAssertEqualObjects(segments5, expected5);	
	
	// TODO: Ok to kill the start token?
	NSString *test6 = @"<START>This is a test.";
	NSArray *segments6 = [test6 gh_substringSegmentsWithinStart:@"<START>" end:@"<END>"];
	NSArray *expected6 = [NSArray arrayWithObjects:[GHNSStringSegment string:@"This is a test." match:YES], nil];
	XCTAssertEqualObjects(segments6, expected6);	
	
	// TODO: Return nil on empty string input?
	NSString *test7 = @"";
	NSArray *segments7 = [test7 gh_substringSegmentsWithinStart:@"<START>" end:@"<END>"];
	NSArray *expected7 = [NSArray arrayWithObjects:nil];
	XCTAssertEqualObjects(segments7, expected7);	
}

- (void)testRightStrip {
	NSString *text = @"this is a string to right strip   \t";
	NSString *expected = @"this is a string to right strip";
	XCTAssertEqualObjects([text gh_rightStrip], expected);
}

- (void)testLeftStrip {
	NSString *text = @"\t   this is a string to left strip";
	NSString *expected = @"this is a string to left strip";
	XCTAssertEqualObjects([text gh_leftStrip], expected);
}

- (void)testIsEqualIgnoreCase {
	XCTAssertTrue([@"FOoO" gh_isEqualIgnoreCase:@"fooO"]);
}

- (void)testFloatValue {
  XCTAssertEqual(5.0f, [@"5.0.1" floatValue]);
}

- (void)testSplit {
  XCTAssertEqualObjects(@"", [@"" gh_splitReverseWithString:@""]);
  XCTAssertEqualObjects(@"", [@"<<<g@foo.com>" gh_firstSplitWithString:@"<" options:0]);
  XCTAssertEqualObjects(@"Test Blah <<", [@"Test Blah <<<g@foo.com>" gh_firstSplitWithString:@"<" options:0]);
  XCTAssertEqualObjects(@"<<g@foo.com>", [@"Test Blah <<<g@foo.com>" gh_lastSplitWithString:@"<" options:0]);
  XCTAssertEqualObjects(@"g@foo.com>", [@"Test Blah <<<g@foo.com>" gh_splitReverseWithString:@"<"]);
}

- (void)testCharacters {
  NSArray *characters = [@"e̊gâds" gh_characters];
  NSArray *expected = @[@"e̊", @"g", @"â", @"d", @"s"];
  XCTAssertEqualObjects(characters, expected);
}

- (void)testRemoveAccents {
  NSString *str = [@"e̊â" gh_removeAccents];
  XCTAssertEqualObjects(str, @"ea");
}

#ifdef __MAC_OS_X_VERSION_MAX_ALLOWED

- (void)testMimeTypes {
  NSString *mimeType = [@"pdf" gh_mimeTypeForExtension];
  XCTAssertEqualObjects(@"application/pdf", mimeType, @"Should be pdf mime type");
}

#endif
	
@end
