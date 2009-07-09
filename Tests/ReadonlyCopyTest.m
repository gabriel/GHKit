//
//  ReadonlyCopyTest.m
//  GHKit
//
//  Created by Gabriel Handford on 5/29/09.
//  Copyright 2009. All rights reserved.
//


@interface ReadonlyCopyTest : GHTestCase {
	NSMutableArray *array_;
}

@property (readonly, copy, nonatomic) NSMutableArray *array;

@end

@implementation ReadonlyCopyTest

@synthesize array=array_;

- (void)testReadonlyCopy {	
	array_ = [NSMutableArray arrayWithObjects:self, self, self, nil];
	
	for(id o in [[self.array copy] autorelease]) {
		[array_ removeObject:o];
	}
}

@end

