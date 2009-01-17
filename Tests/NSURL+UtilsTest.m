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
	GHAssertEqualObjects(escaped1, expected1, @"Error");			
}

- (void)testEncodeAll {	
	NSString *test1 = @"~!@#$%^&*(){}[]=:/,;?+'\"\\";
	NSString *escaped1 = [NSURL gh_encodeAll:test1];
	NSArray *expected1 = @"~!%40%23%24%25%5E%26*()%7B%7D%5B%5D%3D%3A%2F%2C%3B%3F%2B'%22%5C";
	GHAssertEqualObjects(escaped1, expected1, @"Error");		
}

- (void)testParamsToString {
	NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", nil];
	NSString *s = [NSURL gh_paramsToString:dict];
	GHAssertEqualObjects(s, @"key1=value1&key2=value2", @"Error");
	
	NSDictionary *dict2 = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"AAA", @"value2", @"BBB", @"value3", @"CCC", nil];
	NSString *s2 = [NSURL gh_paramsToString:dict2 sort:YES];
	GHAssertEqualObjects(s2, @"AAA=value1&BBB=value2&CCC=value3", @"Error");	
}

- (void)testStringToParams {
	NSDictionary *dict = [NSURL gh_stringToParams:@"key1=value1&key2=value2"];
	GHAssertEqualObjects(@"value1", [dict objectForKey:@"key1"], @"Error");
	GHAssertEqualObjects(@"value2", [dict objectForKey:@"key2"], @"Error");
	
	NSDictionary *dict2 = [NSURL gh_stringToParams:@"key1==value1&&key2=value2&key3=value3=more"];
	GHAssertEqualObjects(@"=value1", [dict2 objectForKey:@"key1"], @"Error");
	GHAssertEqualObjects(@"value2", [dict2 objectForKey:@"key2"], @"Error");
	GHAssertEqualObjects(@"value3=more", [dict2 objectForKey:@"key3"], @"Error");
}


@end
