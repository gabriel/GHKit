//
//  NSURL+UtilsTest.m
//  GHKit
//
//  Created by Gabriel Handford on 1/13/09.
//

#import "GHNSURL+Utils.h"

@interface NSURLUtilsTest : GHTestCase { }
@end

@implementation NSURLUtilsTest

- (void)testEncode {	
	NSString *test1 = @"~!@#$%^&*(){}[]=:/,;?+'\"\\";
	NSString *escaped1 = [NSURL gh_encode:test1];
	NSArray *expected1 = @"~!@#$%25%5E&*()%7B%7D%5B%5D=:/,;?+'%22%5C";
	GHAssertEqualObjects(escaped1, expected1, nil);			
}

- (void)testEncodeComponent {	
	NSString *test1 = @"~!@#$%^&*(){}[]=:/,;?+'\"\\";
	NSString *escaped1 = [NSURL gh_encodeComponent:test1];
	NSArray *expected1 = @"~!%40%23%24%25%5E%26*()%7B%7D%5B%5D%3D%3A%2F%2C%3B%3F%2B'%22%5C";
	GHAssertEqualObjects(escaped1, expected1, nil);		
}

- (void)testEscapeAll {	
	NSString *test1 = @"~!@#$%^&*(){}[]=:/,;?+'\"\\~!*()'";
	NSString *escaped1 = [NSURL gh_escapeAll:test1];
	NSArray *expected1 = @"%7E%21%40%23%24%25%5E%26%2A%28%29%7B%7D%5B%5D%3D%3A%2F%2C%3B%3F%2B%27%22%5C%7E%21%2A%28%29%27";
	GHAssertEqualObjects(escaped1, expected1, nil);		
}

- (void)testDictionaryToQueryString {
	NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", nil];
	NSString *s = [NSURL gh_dictionaryToQueryString:dict];
	GHAssertEqualObjects(s, @"key1=value1&key2=value2", nil);
	
	NSDictionary *dict2 = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"AAA", @"value2", @"BBB", @"value3", @"CCC", nil];
	NSString *s2 = [NSURL gh_dictionaryToQueryString:dict2 sort:YES];
	GHAssertEqualObjects(s2, @"AAA=value1&BBB=value2&CCC=value3", nil);	
}

- (void)testQueryStringToDictionary {
	NSDictionary *dict = [NSURL gh_queryStringToDictionary:@"key1=value1&key2=value2"];
	GHAssertEqualObjects(@"value1", [dict objectForKey:@"key1"], nil);
	GHAssertEqualObjects(@"value2", [dict objectForKey:@"key2"], nil);
	
	NSDictionary *dict2 = [NSURL gh_queryStringToDictionary:@"key1==value1&&key2=value2%20&key3=value3=more"];
	GHAssertEqualObjects(@"=value1", [dict2 objectForKey:@"key1"], nil);
	GHAssertEqualObjects(@"value2 ", [dict2 objectForKey:@"key2"], nil);
	GHAssertEqualObjects(@"value3=more", [dict2 objectForKey:@"key3"], nil);
}


@end
