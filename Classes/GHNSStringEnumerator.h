//
//  GHNSStringEnumerator.h
//  GHKit
//
//  Created by Gabriel Handford on 6/12/09.
//  Copyright 2009 Yelp. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GHNSStringEnumerator : NSEnumerator {
	NSScanner *_scanner;
	
	NSCharacterSet *_separatorCharacterSet;
	NSString *_separatorString;
	
	BOOL _inSeparator;
}

@property (readonly, nonatomic, getter=isInSeparator) BOOL inSeparator;

- (id)initWithString:(NSString *)string separatorCharacterSet:(NSCharacterSet *)separatorCharacterSet;
- (id)initWithString:(NSString *)string separatorString:(NSString *)separatorString;

- (NSString *)nextString;

@end
