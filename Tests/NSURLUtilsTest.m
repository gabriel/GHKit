//
//  NSURL+UtilsTest.m
//  GHKit
//
//  Created by Gabriel Handford on 1/13/09.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

@import GHKit;

@interface NSURLUtilsTest : XCTestCase { }
@end

@implementation NSURLUtilsTest

- (void)testEncode {	
	NSString *test1 = @"~!@#$%^&*(){}[]=:/,;?+'\"\\";
	NSString *escaped1 = [NSURL gh_encode:test1];
	NSString *expected1 = @"~!@#$%25%5E&*()%7B%7D%5B%5D=:/,;?+'%22%5C";
	XCTAssertEqualObjects(escaped1, expected1);			
}

- (void)testEncodeComponent {	
	NSString *test1 = @"~!@#$%^&*(){}[]=:/,;?+'\"\\";
	NSString *escaped1 = [NSURL gh_encodeComponent:test1];
	NSString *expected1 = @"~!%40%23%24%25%5E%26*()%7B%7D%5B%5D%3D%3A%2F%2C%3B%3F%2B'%22%5C";
	XCTAssertEqualObjects(escaped1, expected1);		
}

- (void)testEscapeAll {	
	NSString *test1 = @"~!@#$%^&*(){}[]=:/,;?+'\"\\~!*()'";
	NSString *escaped1 = [NSURL gh_escapeAll:test1];
	NSString *expected1 = @"%7E%21%40%23%24%25%5E%26%2A%28%29%7B%7D%5B%5D%3D%3A%2F%2C%3B%3F%2B%27%22%5C%7E%21%2A%28%29%27";
	XCTAssertEqualObjects(escaped1, expected1);		
}

- (void)testDictionaryToQueryString {
	NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", nil];
	NSString *s = [NSURL gh_dictionaryToQueryString:dict sort:YES];
	XCTAssertEqualObjects(s, @"key1=value1&key2=value2");
	
	NSDictionary *dict2 = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"AAA", @"value2", @"BBB", @"value3", @"CCC", nil];
	NSString *s2 = [NSURL gh_dictionaryToQueryString:dict2 sort:YES];
	XCTAssertEqualObjects(s2, @"AAA=value1&BBB=value2&CCC=value3");	
}

- (void)testDictionaryWithObjectsToQueryString {
	NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:1], @"key1", @"[]", @"key2", nil];
	NSString *s = [NSURL gh_dictionaryToQueryString:dict sort:YES];
	XCTAssertEqualObjects(s, @"key1=1&key2=%5B%5D");
}

- (void)testDictionaryWithNSNull {
	NSDictionary *dict = [NSDictionary gh_dictionaryWithKeysAndObjectsMaybeNil:@"key1", @"value1", @"key2", nil, nil];
	NSString *s = [NSURL gh_dictionaryToQueryString:dict sort:YES];
	XCTAssertEqualObjects(s, @"key1=value1");
}

- (void)testQueryStringToDictionary {
	NSDictionary *dict = [NSURL gh_queryStringToDictionary:@"key1=value1&key2=value2"];
	XCTAssertEqualObjects(@"value1", [dict objectForKey:@"key1"]);
	XCTAssertEqualObjects(@"value2", [dict objectForKey:@"key2"]);
	
	NSDictionary *dict2 = [NSURL gh_queryStringToDictionary:@"key1==value1&&key2=value2%20&key3=value3=more"];
	XCTAssertEqualObjects(@"=value1", [dict2 objectForKey:@"key1"]);
	XCTAssertEqualObjects(@"value2 ", [dict2 objectForKey:@"key2"]);
	XCTAssertEqualObjects(@"value3=more", [dict2 objectForKey:@"key3"]);
}

- (void)testDeriveWithQuery {
	NSURL *URL = [NSURL URLWithString:@"http://api.yelp.com/path?key1=value1&key2=value2"];
	NSURL *derivedURL = [URL gh_deriveWithQuery:@"key3=value3&key4=value4"];
	XCTAssertEqualObjects([derivedURL description], @"http://api.yelp.com/path?key3=value3&key4=value4");	
}

- (void)testDeriveComplexWithQuery {
	NSURL *URL = [NSURL URLWithString:@"https://user:pass@api.yelp.com:400/path?key1=value1&key2=value2#myfrag"];
	NSURL *derivedURL = [URL gh_deriveWithQuery:@"key3=value3&key4=value4"];
	XCTAssertEqualObjects([derivedURL description], @"https://user:pass@api.yelp.com:400/path?key3=value3&key4=value4#myfrag");	
}

- (void)testCanonical {
	NSURL *URL = [NSURL URLWithString:@"https://user:pass@api.yelp.com:400/path?b=c&a=d#myfrag"];
	NSURL *canonical = [URL gh_canonical];
	XCTAssertEqualObjects(canonical, [NSURL URLWithString:@"https://user:pass@api.yelp.com:400/path?a=d&b=c#myfrag"]);

	NSURL *URL2 = [NSURL URLWithString:@"https://user:pass@api.yelp.com:400/path?b=c&a=d&ignore=ignored#myfrag"];
	NSURL *canonical2 = [URL2 gh_canonicalWithIgnore:[NSArray arrayWithObject:@"ignore"]];
	XCTAssertEqualObjects(canonical2, [NSURL URLWithString:@"https://user:pass@api.yelp.com:400/path?a=d&b=c#myfrag"]);
}

- (void)testFilter {
  NSURL *URL = [NSURL URLWithString:@"https://user:pass@api.yelp.com:400/path?b=c&a=d&ignore=ignored#myfrag"];
	NSURL *filtered = [URL gh_filterQueryParams:[NSArray arrayWithObjects:@"ignore", @"ignore2", nil] sort:YES];
	XCTAssertEqualObjects(filtered, [NSURL URLWithString:@"https://user:pass@api.yelp.com:400/path?a=d&b=c#myfrag"]);
}

- (void)testQueryDictionaryWithArray {
	NSArray *array1 = [NSArray arrayWithObjects:@"va", @"vb", @"vc", nil];
	NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:array1, @"key1", @"value2", @"key2", nil];
	NSString *s = [NSURL gh_dictionaryToQueryString:dict sort:YES];
	XCTAssertEqualObjects(s, @"key1=va%2Cvb%2Cvc&key2=value2");	
}

- (void)testQueryDictionaryWithSet {
	NSSet *set1 = [NSSet setWithObjects:@"va", @"vb", nil];
	NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:set1, @"key1", nil];
	NSString *s = [NSURL gh_dictionaryToQueryString:dict sort:YES];
	XCTAssertTrue([s isEqualToString:@"key1=va%2Cvb"] || [s isEqualToString:@"key1=vb%2Cva"]);	
}

@end
