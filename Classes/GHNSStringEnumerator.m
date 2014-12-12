//
//  GHNSStringEnumerator.m
//  GHKit
//
//  Created by Gabriel Handford on 6/12/09.
//  Copyright 2009. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//


#import "GHNSStringEnumerator.h"


@implementation GHNSStringEnumerator

@synthesize inSeparator=_inSeparator;

- (id)initWithString:(NSString *)string separatorCharacterSet:(NSCharacterSet *)separatorCharacterSet 
		 separatorString:(NSString *)separatorString {
	
	if ((self = [super init])) {
		_scanner = [[NSScanner alloc] initWithString:string];
		_scanner.charactersToBeSkipped = nil;
		_separatorCharacterSet = separatorCharacterSet;
		_separatorString = separatorString;
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
