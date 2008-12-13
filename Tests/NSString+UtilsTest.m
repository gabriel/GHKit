//
//  NSStringUtilsTest.m
//  S3Share
//
//  Created by Gabe on 3/30/08.
//  Copyright 2008 ducktyper.com. All rights reserved.
//

#import "NSString+UtilsTest.h"

#import "GHNSString+Utils.h"
#import "GHNSString+Validation.h"

@implementation NSStringUtilsTest

- (void)testMimeTypes {
  NSString *mimeType = [@"pdf" gh_mimeTypeForExtension];
  STAssertEqualObjects(@"application/pdf", mimeType, @"Should be pdf mime type");
}

- (void)testValidateEmail {
  NSString *valid = @"gabrielh@gmail.com";  
  STAssertTrue([valid gh_isEmailAddress], @"Should be valid email");
  
  NSString *invalid = @"foo";
  STAssertFalse([invalid gh_isEmailAddress], @"Should be invalid email");
  
  NSString *invalid2 = @"~gabrielh@gmail.com";  
  STAssertFalse([invalid2 gh_isEmailAddress], @"Should be invalid email");
  
  NSString *valid3 = @"gabrielh@gmail.commmmmmm";  
  STAssertTrue([valid3 gh_isEmailAddress], @"Should be valid email");
}

- (void)testLastSplitWithString {
	STAssertEqualObjects(@"bar", [@"foo:bar" gh_lastSplitWithString:@":" options:NSCaseInsensitiveSearch], @"Split is invalid");	
	STAssertEqualObjects(@"foobar", [@"foobar" gh_lastSplitWithString:@":" options:NSCaseInsensitiveSearch], @"Split is invalid");
	
	STAssertEqualObjects(@"foobar", [@"foobar" gh_lastSplitWithString:@"" options:NSCaseInsensitiveSearch], @"Split is invalid");
	STAssertEqualObjects(@"ar", [@"foobar" gh_lastSplitWithString:@"oob" options:NSCaseInsensitiveSearch], @"Split is invalid");
}

- (void)testCutWithString {
	NSArray *expected = [NSArray arrayWithObjects:@"foo:", @"bar", nil];
	NSArray *cuts = [@"foo:bar" gh_cutWithString:@":" options:0];
	STAssertEqualObjects(expected, cuts, @"Cut is invalid");	

	NSArray *expected2 = [NSArray arrayWithObjects:@"foobar", nil];
	NSArray *cuts2 = [@"foobar" gh_cutWithString:@":" options:0];
	STAssertEqualObjects(expected2, cuts2, @"Cut is invalid");	
	
	NSArray *expected3 = [NSArray arrayWithObjects:@"foo:", nil];
	NSArray *cuts3 = [@"foo:" gh_cutWithString:@":" options:0];
	STAssertEqualObjects(expected3, cuts3, @"Cut is invalid");	

	NSArray *expected4 = [NSArray arrayWithObjects:@"", nil];
	NSArray *cuts4 = [@"" gh_cutWithString:@":" options:0];
	STAssertEqualObjects(expected4, cuts4, @"Cut is invalid");	
	
	NSArray *expected5 = [NSArray arrayWithObjects:@":", nil];
	NSArray *cuts5 = [@":" gh_cutWithString:@":" options:0];
	STAssertEqualObjects(expected5, cuts5, @"Cut is invalid");	
	
	NSArray *expected6 = [NSArray arrayWithObjects:@":", @":", nil];
	NSArray *cuts6 = [@"::" gh_cutWithString:@":" options:0];
	STAssertEqualObjects(expected6, cuts6, @"Cut is invalid");	
	
	NSArray *expected7 = [NSArray arrayWithObjects:@":", @"foo:", nil];
	NSArray *cuts7 = [@":foo:" gh_cutWithString:@":" options:0];
	STAssertEqualObjects(expected7, cuts7, @"Cut is invalid");	
	
	NSArray *expected8 = [NSArray arrayWithObjects:@"foo---", @"bar", nil];
	NSArray *cuts8 = [@"foo---bar" gh_cutWithString:@"---" options:0];
	STAssertEqualObjects(expected8, cuts8, @"Cut is invalid");	
}

- (void)testSubStringSegmentsWithin {
	
	NSString *test1 = @"This <START>is a<END> test.";
	NSArray *segments1 = [test1 gh_substringSegmentsWithinStart:@"<START>" end:@"<END>"];
	NSArray *expected1 = [NSArray arrayWithObjects:[GHStringSegment string:@"This " isMatch:NO], [GHStringSegment string:@"is a" isMatch:YES], [GHStringSegment string:@" test." isMatch:NO], nil];
	STAssertEqualObjects(segments1, expected1, @"Segments is invalid");		
	
	NSString *test2 = @"This is a test.";
	NSArray *segments2 = [test2 gh_substringSegmentsWithinStart:@"<START>" end:@"<END>"];
	NSArray *expected2 = [NSArray arrayWithObjects:[GHStringSegment string:@"This is a test." isMatch:NO], nil];
	STAssertEqualObjects(segments2, expected2, @"Segments is invalid");	
	
	NSString *test3 = @"<START>This is a test.<END>";
	NSArray *segments3 = [test3 gh_substringSegmentsWithinStart:@"<START>" end:@"<END>"];
	NSArray *expected3 = [NSArray arrayWithObjects:[GHStringSegment string:@"This is a test." isMatch:YES], nil];
	STAssertEqualObjects(segments3, expected3, @"Segments is invalid");	

	NSString *test4 = @"<START>This is a test.<END> ";
	NSArray *segments4 = [test4 gh_substringSegmentsWithinStart:@"<START>" end:@"<END>"];
	NSArray *expected4 = [NSArray arrayWithObjects:[GHStringSegment string:@"This is a test." isMatch:YES], [GHStringSegment string:@" " isMatch:NO], nil];
	STAssertEqualObjects(segments4, expected4, @"Segments is invalid");	
	
	NSString *test5 = @" <START>This is a test.<END> <END>";
	NSArray *segments5 = [test5 gh_substringSegmentsWithinStart:@"<START>" end:@"<END>"];
	NSArray *expected5 = [NSArray arrayWithObjects:[GHStringSegment string:@" " isMatch:NO], [GHStringSegment string:@"This is a test." isMatch:YES], [GHStringSegment string:@" <END>" isMatch:NO], nil];
	STAssertEqualObjects(segments5, expected5, @"Segments is invalid");	
	
	// TODO: Ok to kill the start token?
	NSString *test6 = @"<START>This is a test.";
	NSArray *segments6 = [test6 gh_substringSegmentsWithinStart:@"<START>" end:@"<END>"];
	NSArray *expected6 = [NSArray arrayWithObjects:[GHStringSegment string:@"This is a test." isMatch:YES], nil];
	STAssertEqualObjects(segments6, expected6, @"Segments is invalid");	
	
	// TODO: Return nil on empty string input?
	NSString *test7 = @"";
	NSArray *segments7 = [test7 gh_substringSegmentsWithinStart:@"<START>" end:@"<END>"];
	NSArray *expected7 = [NSArray arrayWithObjects:nil];
	STAssertEqualObjects(segments7, expected7, @"Segments is invalid");	
	
}

	
@end
