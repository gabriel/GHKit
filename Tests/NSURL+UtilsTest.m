//
//  NSURL+UtilsTest.m
//  GHKit
//
//  Created by Gabriel Handford on 1/13/09.
//

#import "NSURL+UtilsTest.h"

#import "GHNSURL+Utils.h"

@implementation NSURLUtilsTest

- (void)testEncode {	
	NSString *test1 = @"~!@#$%^&*(){}[]=:/,;?+'\"\\";
	NSString *escaped1 = [NSURL gh_encode:test1];
	NSArray *expected1 = @"~!@#$%25%5E&*()%7B%7D%5B%5D=:/,;?+'%22%5C";
	STAssertEqualObjects(escaped1, expected1, @"Error");			
}

- (void)testEncodeAll {	
	NSString *test1 = @"~!@#$%^&*(){}[]=:/,;?+'\"\\";
	NSString *escaped1 = [NSURL gh_encodeAll:test1];
	NSArray *expected1 = @"~!%40%23%24%25%5E%26*()%7B%7D%5B%5D%3D%3A%2F%2C%3B%3F%2B'%22%5C";
	STAssertEqualObjects(escaped1, expected1, @"Error");		
}

- (void)testParamsToString {
	NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2"];
	NSString *s = [NSURL gh_paramsToString:dict];
	STAssertEqualObjects(@"key1=value1&key2=value2", s, @"Error");
}

- (void)testStringToParams {
	NSDictionary *dict = [NSURL gh_stringToParams:@"key1=value1&key2=value2"];
	STAssertEqualObjects(@"value1", [dict objectForKey:@"key1"], @"Error");
	STAssertEqualObjects(@"value2", [dict objectForKey:@"key2"], @"Error");
}


@end
