//
//  GHNSError+Utils.m
//  GHKitIPhone
//
//  Created by Gabriel Handford on 3/9/09.
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

#import "GHNSError+Utils.h"


@implementation NSError(GHUtils)

+ (NSError *)gh_errorWithDomain:(NSString *)domain code:(NSInteger)code localizedDescription:(NSString *)localizedDescription {
	NSDictionary *userInfo = [NSDictionary dictionaryWithObject:localizedDescription forKey:NSLocalizedDescriptionKey];
	return [self errorWithDomain:domain code:code userInfo:userInfo];
}

+ (NSError *)gh_errorFromException:(NSException *)exception {
	NSDictionary *userInfo = [NSDictionary dictionaryWithObject:exception.reason forKey:NSLocalizedDescriptionKey];
	return [self errorWithDomain:exception.name code:-1 userInfo:userInfo];
}

- (void)gh_fullDescription:(NSMutableString *)errorDescription level:(NSInteger)level {
	[errorDescription appendFormat:@"%@\n", [self localizedDescription]];
	
	if (level > 0) [errorDescription appendString:@"--\n"];
	level++;
	for(id userInfoKey in [self userInfo]) {	
		id userInfoEntry = [[self userInfo] objectForKey:userInfoKey];
		if (userInfoEntry == self) continue;
		[errorDescription appendFormat:@" %@: ", userInfoKey];		
		if ([userInfoEntry isKindOfClass:[NSArray class]]) { 
			for(id userInfoEntryItem in userInfoEntry) {
				if ([userInfoEntryItem isKindOfClass:[NSError class]]) {					
					[(NSError *)userInfoEntryItem gh_fullDescription:errorDescription level:level];
				} else {					
					[errorDescription appendFormat:@"%@\n", [userInfoEntryItem description]];
				}
			}
		} else if ([userInfoEntry isKindOfClass:[NSError class]]) {
			[(NSError *)userInfoEntry gh_fullDescription:errorDescription level:level];
		} else {
			[errorDescription appendString:[userInfoEntry description]];
		}
	}
}

- (NSString *)gh_fullDescription {
	NSMutableString *errorDescription = [[NSMutableString alloc] init];
	[self gh_fullDescription:errorDescription level:0];
  return errorDescription;
}


@end
