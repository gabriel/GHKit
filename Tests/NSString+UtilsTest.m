//
//  NSStringUtilsTest.m
//  S3Share
//
//  Created by Gabe on 3/30/08.
//  Copyright 2008 rel.me. All rights reserved.
//

#import "GHNSString+Utils.h"
#import "GHNSString+Validation.h"

@interface NSStringUtilsTest : GHTestCase { }
@end

@implementation NSStringUtilsTest

- (void)testMimeTypes {
  NSString *mimeType = [@"pdf" gh_mimeTypeForExtension];
  GHAssertEqualObjects(@"application/pdf", mimeType, @"Should be pdf mime type");
}

- (void)testValidateEmail {
  NSString *valid = @"gabrielh@gmail.com";  
  GHAssertTrue([valid gh_isEmailAddress], @"Should be valid email");
  
  NSString *invalid = @"foo";
  GHAssertFalse([invalid gh_isEmailAddress], @"Should be invalid email");
  
  NSString *invalid2 = @"~gabrielh@gmail.com";  
  GHAssertFalse([invalid2 gh_isEmailAddress], @"Should be invalid email");
  
  NSString *valid3 = @"gabrielh@gmail.commmmmmm";  
  GHAssertTrue([valid3 gh_isEmailAddress], @"Should be valid email");
}

- (void)testLastSplitWithString {
	GHAssertEqualObjects(@"bar", [@"foo:bar" gh_lastSplitWithString:@":" options:NSCaseInsensitiveSearch], @"Split is invalid");	
	GHAssertEqualObjects(@"foobar", [@"foobar" gh_lastSplitWithString:@":" options:NSCaseInsensitiveSearch], @"Split is invalid");
	
	GHAssertEqualObjects(@"foobar", [@"foobar" gh_lastSplitWithString:@"" options:NSCaseInsensitiveSearch], @"Split is invalid");
	GHAssertEqualObjects(@"ar", [@"foobar" gh_lastSplitWithString:@"oob" options:NSCaseInsensitiveSearch], @"Split is invalid");
}

- (void)testCutWithString {
	NSArray *expected = [NSArray arrayWithObjects:@"foo:", @"bar", nil];
	NSArray *cuts = [@"foo:bar" gh_cutWithString:@":" options:0];
	GHAssertEqualObjects(expected, cuts, @"Cut is invalid");	

	NSArray *expected2 = [NSArray arrayWithObjects:@"foobar", nil];
	NSArray *cuts2 = [@"foobar" gh_cutWithString:@":" options:0];
	GHAssertEqualObjects(expected2, cuts2, @"Cut is invalid");	
	
	NSArray *expected3 = [NSArray arrayWithObjects:@"foo:", nil];
	NSArray *cuts3 = [@"foo:" gh_cutWithString:@":" options:0];
	GHAssertEqualObjects(expected3, cuts3, @"Cut is invalid");	

	NSArray *expected4 = [NSArray arrayWithObjects:@"", nil];
	NSArray *cuts4 = [@"" gh_cutWithString:@":" options:0];
	GHAssertEqualObjects(expected4, cuts4, @"Cut is invalid");	
	
	NSArray *expected5 = [NSArray arrayWithObjects:@":", nil];
	NSArray *cuts5 = [@":" gh_cutWithString:@":" options:0];
	GHAssertEqualObjects(expected5, cuts5, @"Cut is invalid");	
	
	NSArray *expected6 = [NSArray arrayWithObjects:@":", @":", nil];
	NSArray *cuts6 = [@"::" gh_cutWithString:@":" options:0];
	GHAssertEqualObjects(expected6, cuts6, @"Cut is invalid");	
	
	NSArray *expected7 = [NSArray arrayWithObjects:@":", @"foo:", nil];
	NSArray *cuts7 = [@":foo:" gh_cutWithString:@":" options:0];
	GHAssertEqualObjects(expected7, cuts7, @"Cut is invalid");	
	
	NSArray *expected8 = [NSArray arrayWithObjects:@"foo---", @"bar", nil];
	NSArray *cuts8 = [@"foo---bar" gh_cutWithString:@"---" options:0];
	GHAssertEqualObjects(expected8, cuts8, @"Cut is invalid");	
}

- (void)testCut {	
	NSString *text = @"Lorem ipsum dolor sit amet";
	NSArray *cuts = [text gh_cutWithString:@" " options:0 cutAfter:YES];
	NSArray *expected = [NSArray arrayWithObjects:@"Lorem ", @"ipsum ", @"dolor ", @"sit ", @"amet", nil];
	GHAssertEqualObjects(cuts, expected, nil);
}

- (void)testCutEndInSpace {	
	NSString *text = @"Lorem ";
	NSArray *cuts = [text gh_cutWithString:@" " options:0 cutAfter:NO];
	NSArray *expected = [NSArray arrayWithObjects:@"Lorem", @" ", nil];
	GHAssertEqualObjects(cuts, expected, nil);
}

- (void)testCutBefore {	
	NSString *text = @"Lorem ipsum dolor sit amet";
	NSArray *cuts = [text gh_cutWithString:@" " options:0 cutAfter:NO];
	NSArray *expected = [NSArray arrayWithObjects:@"Lorem", @" ipsum", @" dolor", @" sit", @" amet", nil];	
	GHAssertEqualObjects(cuts, expected, nil);
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
	
@end
