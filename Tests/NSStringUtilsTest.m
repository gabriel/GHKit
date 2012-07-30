//
//  NSStringUtilsTest.m
//  GHKit
//
//  Created by Gabe on 3/30/08.
//  Copyright 2008 rel.me. All rights reserved.
//

#import "GHNSString+Utils.h"

@interface NSStringUtilsTest : GHTestCase { }
@end

@implementation NSStringUtilsTest

#if !TARGET_OS_IPHONE
- (void)testMimeTypes {
  NSString *mimeType = [@"pdf" gh_mimeTypeForExtension];
  GHAssertEqualObjects(@"application/pdf", mimeType, @"Should be pdf mime type");
}
#endif

- (void)testContainsAny {
	NSString *s = @"TestUppercase";
	GHAssertTrue([s gh_containsAny:[NSCharacterSet uppercaseLetterCharacterSet]], nil);
}

- (void)testLastSplitWithString {
	GHAssertEqualObjects(@"bar", [@"foo:bar" gh_lastSplitWithString:@":" options:NSCaseInsensitiveSearch], @"Split is invalid");
	GHAssertEqualObjects(@"foobar", [@"foobar" gh_lastSplitWithString:@":" options:NSCaseInsensitiveSearch], @"Split is invalid");
	
	GHAssertEqualObjects(@"foobar", [@"foobar" gh_lastSplitWithString:@"" options:NSCaseInsensitiveSearch], @"Split is invalid");
	GHAssertEqualObjects(@"ar", [@"foobar" gh_lastSplitWithString:@"oob" options:NSCaseInsensitiveSearch], @"Split is invalid");
  
  GHAssertEqualObjects(@"bar:baz", [@"foo:bar:baz" gh_lastSplitWithString:@":" options:NSCaseInsensitiveSearch], @"Split is invalid");	
}

- (void)testSeparate1 {	
	NSArray *expected = [NSArray arrayWithObjects:@"foo", @":", @":", @"bar", nil];	
	NSArray *separated = [@"foo::bar" gh_componentsSeparatedByString:@":" include:YES];
	GHAssertEqualObjects(separated, expected, nil);
}

- (void)testSeparate2 {	
	NSArray *expected = [NSArray arrayWithObjects:@"foo", @"\n", @"bar", nil];	
	NSArray *separated = [@"foo\nbar" gh_componentsSeparatedByString:@"\n" include:YES];
	GHAssertEqualObjects(separated, expected, nil);
}

- (void)testSeparate3 {	
	NSArray *expected = [NSArray arrayWithObjects:@"foo", @"\n", @"\n", @"bar", @"\n", nil];	
	NSArray *separated = [@"foo\n\nbar\n" gh_componentsSeparatedByString:@"\n" include:YES];
	GHAssertEqualObjects(separated, expected, nil);
}

- (void)testUUID {
	GHTestLog([NSString gh_uuid]);
	// TODO(gabe): Test
}

- (void)testReverse {
	GHAssertEqualStrings([@"reversetest" gh_reverse], @"tsetesrever", nil); // odd # of letters
	GHAssertEqualStrings([@"reverseit!" gh_reverse], @"!tiesrever", nil); // even # of letters
}

- (void)testStartsWith {
  GHAssertTrue([@"www.test.com" gh_startsWith:@"www." options:0], nil);
  GHAssertTrue([@"www.test.com" gh_startsWith:@"www.test.com" options:0], nil);
  GHAssertFalse([@"www.test.com" gh_startsWith:@"" options:0], nil);
  
  GHAssertTrue([@"www.test.com" gh_startsWith:@"WWW." options:NSCaseInsensitiveSearch], nil);
  GHAssertTrue([@"www.test.com" gh_startsWith:@"WWW.test.com" options:NSCaseInsensitiveSearch], nil);
  GHAssertFalse([@"www.test.com" gh_startsWith:@"" options:NSCaseInsensitiveSearch], nil);
}

- (void)testEndsWith {
  GHAssertTrue([@"path/" gh_endsWith:@"/" options:0], nil);
  GHAssertFalse([@"path" gh_endsWith:@"/" options:0], nil);  
  GHAssertTrue([@"path-" gh_endsWith:@"-" options:NSLiteralSearch], nil);

  GHAssertTrue([@"www.test.com" gh_endsWith:@".com" options:0], nil);
  GHAssertTrue([@"www.test.com" gh_endsWith:@"www.test.com" options:0], nil);
  GHAssertFalse([@"www.test.com" gh_endsWith:@"" options:0], nil);
  
  GHAssertTrue([@"www.test.com" gh_endsWith:@".COM" options:NSCaseInsensitiveSearch], nil);
  GHAssertTrue([@"www.test.com" gh_endsWith:@"www.test.COM" options:NSCaseInsensitiveSearch], nil);
  GHAssertFalse([@"www.test.com" gh_endsWith:@"" options:NSCaseInsensitiveSearch], nil);
}

- (void)testCount {
	GHAssertTrue([@"\n \n\n   \n" gh_count:@"\n"] == 4, @"1");
	GHAssertTrue([@"\n" gh_count:@"\n"] == 1, @"2");
	GHAssertTrue([@"" gh_count:@"\n"] == 0, @"3");
	GHAssertTrue([@" " gh_count:@"\n"] == 0, @"4");
}

- (void)testSubStringSegmentsWithin {
	
	NSString *test1 = @"This <START>is a<END> test.";
	NSArray *segments1 = [test1 gh_substringSegmentsWithinStart:@"<START>" end:@"<END>"];
	NSArray *expected1 = [NSArray arrayWithObjects:
												[GHNSStringSegment string:@"This " isMatch:NO], 
												[GHNSStringSegment string:@"is a" isMatch:YES], 
												[GHNSStringSegment string:@" test." isMatch:NO], nil];
	GHAssertEqualObjects(segments1, expected1, @"Segments is invalid");		
	
	NSString *test2 = @"This is a test.";
	NSArray *segments2 = [test2 gh_substringSegmentsWithinStart:@"<START>" end:@"<END>"];
	NSArray *expected2 = [NSArray arrayWithObjects:[GHNSStringSegment string:@"This is a test." isMatch:NO], nil];
	GHAssertEqualObjects(segments2, expected2, @"Segments is invalid");	
	
	NSString *test3 = @"<START>This is a test.<END>";
	NSArray *segments3 = [test3 gh_substringSegmentsWithinStart:@"<START>" end:@"<END>"];
	NSArray *expected3 = [NSArray arrayWithObjects:[GHNSStringSegment string:@"This is a test." isMatch:YES], nil];
	GHAssertEqualObjects(segments3, expected3, @"Segments is invalid");	

	NSString *test4 = @"<START>This is a test.<END> ";
	NSArray *segments4 = [test4 gh_substringSegmentsWithinStart:@"<START>" end:@"<END>"];
	NSArray *expected4 = [NSArray arrayWithObjects:
												[GHNSStringSegment string:@"This is a test." isMatch:YES], 
												[GHNSStringSegment string:@" " isMatch:NO], nil];
	GHAssertEqualObjects(segments4, expected4, @"Segments is invalid");	
	
	NSString *test5 = @" <START>This is a test.<END> <END>";
	NSArray *segments5 = [test5 gh_substringSegmentsWithinStart:@"<START>" end:@"<END>"];
	NSArray *expected5 = [NSArray arrayWithObjects:
												[GHNSStringSegment string:@" " isMatch:NO], 
												[GHNSStringSegment string:@"This is a test." isMatch:YES], 
												[GHNSStringSegment string:@" <END>" isMatch:NO], nil];
	GHAssertEqualObjects(segments5, expected5, @"Segments is invalid");	
	
	// TODO: Ok to kill the start token?
	NSString *test6 = @"<START>This is a test.";
	NSArray *segments6 = [test6 gh_substringSegmentsWithinStart:@"<START>" end:@"<END>"];
	NSArray *expected6 = [NSArray arrayWithObjects:[GHNSStringSegment string:@"This is a test." isMatch:YES], nil];
	GHAssertEqualObjects(segments6, expected6, @"Segments is invalid");	
	
	// TODO: Return nil on empty string input?
	NSString *test7 = @"";
	NSArray *segments7 = [test7 gh_substringSegmentsWithinStart:@"<START>" end:@"<END>"];
	NSArray *expected7 = [NSArray arrayWithObjects:nil];
	GHAssertEqualObjects(segments7, expected7, @"Segments is invalid");	
}

- (void)testRightStrip {
	NSString *text = @"this is a string to right strip   ";
	NSString *expected = @"this is a string to right strip";
	GHAssertEqualStrings([text gh_rightStrip], expected, nil);
}

- (void)testLeftStrip {
	NSString *text = @"   this is a string to left strip";
	NSString *expected = @"this is a string to left strip";
	GHAssertEqualStrings([text gh_leftStrip], expected, nil);
}

- (void)testIsEqualIgnoreCase {
	GHAssertTrue([@"FOoO" gh_isEqualIgnoreCase:@"fooO"], nil);
}

- (void)testFloatValue {
  GHAssertEquals(5.0f, [@"5.0.1" floatValue], nil);
}

#if !TARGET_OS_IPHONE
- (void)testTruncateMiddle {
  NSAttributedString *attributedString = [@"This is a test" gh_truncateMiddle];
  GHTestLog(@"attributedString=%@", attributedString);
}
#endif
	
@end
