//
//  GHNSStringEnumerator.m
//  GHKit
//
//  Created by Gabriel Handford on 6/12/09.
//  Copyright 2009 Yelp. All rights reserved.
//

#import "GHNSStringEnumerator.h"


@implementation GHNSStringEnumerator

@synthesize inSeparator=_inSeparator;

- (id)initWithString:(NSString *)string separatorCharacterSet:(NSCharacterSet *)separatorCharacterSet 
		 separatorString:(NSString *)separatorString {
	
	if ((self = [super init])) {
		_scanner = [[NSScanner alloc] initWithString:string];
		_scanner.charactersToBeSkipped = nil;
		_separatorCharacterSet = [separatorCharacterSet retain];
		_separatorString = [separatorString retain];
		_inSeparator = YES;
	}
	return self;
}

- (id)initWithString:(NSString *)string separatorCharacterSet:(NSCharacterSet *)separatorCharacterSet {
	return [self initWithString:string separatorCharacterSet:separatorCharacterSet separatorString:nil];
}

- (id)initWithString:(NSString *)string separatorString:(NSString *)separatorString {
	return [self initWithString:string separatorCharacterSet:nil separatorString:separatorString];
}

- (void)dealloc {
	[_scanner release];
	[_separatorCharacterSet release];
	[_separatorString release];
	[super dealloc];
}

- (NSString *)nextString {
	if (_scanner.isAtEnd) return nil;
	
	NSString *s = nil;
	while(s == nil) {
		_inSeparator = !_inSeparator;	
		if (_separatorCharacterSet) {
			if (!_inSeparator) {				
				[_scanner scanUpToCharactersFromSet:_separatorCharacterSet intoString:&s];
			} else {
				[_scanner scanCharactersFromSet:_separatorCharacterSet intoString:&s];
			}
		} else if (_separatorString) {
			if (!_inSeparator) {
				[_scanner scanUpToString:_separatorString intoString:&s];
			} else {
				[_scanner scanString:_separatorString intoString:&s];
			}
		}		
	}
	return s;
}

- (id)nextObject {
	return [self nextString];
}

@end
