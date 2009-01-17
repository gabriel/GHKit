//
//  GHTestCase.m
//
//  Created by Gabriel Handford on 1/16/09.
//  Copyright 2009. All rights reserved.
//
// Portions of this file fall under the following license, marked with:
// GTM_BEGIN : GTM_END
//
//  Copyright 2008 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License"); you may not
//  use this file except in compliance with the License.  You may obtain a copy
//  of the License at
// 
//  http://www.apache.org/licenses/LICENSE-2.0
// 
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
//  WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
//  License for the specific language governing permissions and limitations under
//  the License.
//

// Changes:
//   Renamed SenTestCase to GHTestCase (Avoid naming conflicts)
//   Re-implemented printException to use GTMStackTrace

#import "GHTestCase.h"

#import "GTMStackTrace.h"

// GTM_BEGIN
@interface GHTestCase (Private)
// our method of logging errors
+ (void)printException:(NSException *)exception fromTestName:(NSString *)name;
@end


@implementation GHTestCase

- (void)failWithException:(NSException*)exception {
  [exception raise];
}

- (void)setUp {
}

- (void)performTest:(SEL)sel {
  currentSelector_ = sel;
  @try {
    [self invokeTest];
  } @catch (NSException *exception) {
    [[self class] printException:exception
                    fromTestName:NSStringFromSelector(sel)];
    [exception raise];
  }
}

+ (void)printException:(NSException *)exception fromTestName:(NSString *)name {
	
	NSDictionary *userInfo = [exception userInfo];
  NSString *filename = [userInfo objectForKey:GHTestFilenameKey];
  NSNumber *lineNumber = [userInfo objectForKey:GHTestLineNumberKey];
  if ([filename length] == 0) {
    filename = @"Unknown.m";
  }
	
	NSString *className = NSStringFromClass([self class]);
	NSString *exceptionInfo = [NSString stringWithFormat:@"%@:%d: error: -[%@ %@]\n", 
														 filename,
														 [lineNumber integerValue],
														 className, 
														 name,
														 [exception reason]];
	
	NSString *exceptionTrace = [NSString stringWithFormat:@"%@\n%@\n", 
															exceptionInfo, 
															GTMStackTraceFromException(exception)];
	
  fprintf(stderr, [exceptionInfo UTF8String]);
  fflush(stderr);
	NSLog(exceptionTrace);
}

- (void)invokeTest {
  NSException *e = nil;
  @try {
    // Wrap things in autorelease pools because they may
    // have an STMacro in their dealloc which may get called
    // when the pool is cleaned up
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    // We don't log exceptions here, instead we let the person that called
    // this log the exception.  This ensures they are only logged once but the
    // outer layers get the exceptions to report counts, etc.
    @try {
      [self setUp];
      @try {
        [self performSelector:currentSelector_];
      } @catch (NSException *exception) {
        e = [exception retain];
      }
      [self tearDown];
    } @catch (NSException *exception) {
      e = [exception retain];
    }
    [pool release];
  } @catch (NSException *exception) {
    e = [exception retain];
  }
  if (e) {
    [e autorelease];
    [e raise];
  }
}

- (void)tearDown {
}
@end

// GTM_END