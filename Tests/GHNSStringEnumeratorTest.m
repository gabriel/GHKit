//
//  GHNSStringEnumeratorTest.m
//  GHKit
//
//  Created by Gabriel Handford on 6/12/09.
//  Copyright 2009. All rights reserved.
//

#import <GRUnit/GRUnit.h>
#import "GHNSStringEnumerator.h"

@interface GHNSStringEnumeratorTest : GRTestCase {}
@end

@implementation GHNSStringEnumeratorTest

- (void)testCharacterSet {
	NSString *string = @"matz can't\n patch blues";
	GHNSStringEnumerator *enumerator = [[GHNSStringEnumerator alloc] initWithString:string
																														separatorCharacterSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	NSArray *results = [enumerator allObjects];
	NSArray *expected = [NSArray arrayWithObjects:@"matz", @" ", @"can't", @"\n ", @"patch", @" ", @"blues", nil];
	GRAssertEqualObjects(results, expected);
}

- (void)testCharacterSet2 {
	NSString *string = @"  matz can't\n patch blues";
	GHNSStringEnumerator *enumerator = [[GHNSStringEnumerator alloc] initWithString:string
																														separatorCharacterSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	NSArray *results = [enumerator allObjects];
	NSArray *expected = [NSArray arrayWithObjects:@"  ", @"matz", @" ", @"can't", @"\n ", @"patch", @" ", @"blues", nil];
	GRAssertEqualObjects(results, expected);
}

- (void)testString {
	NSString *string = @"matz can't\n patch blues";
	GHNSStringEnumerator *enumerator = [[GHNSStringEnumerator alloc] initWithString:string
																																	separatorString:@" "];
	
	NSArray *results = [enumerator allObjects];
	NSArray *expected = [NSArray arrayWithObjects:@"matz", @" ", @"can't\n", @" ", @"patch", @" ", @"blues", nil];
	GRAssertEqualObjects(results, expected);
}


@end
