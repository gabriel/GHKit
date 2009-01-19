//
//  GHTestCase.h
//
//  Created by Gabriel Handford on 1/16/09.
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

#import <Foundation/Foundation.h>

#import "GHTestMacros.h"
#import "GHTest.h"

@class GHTestCase;

@protocol GHTestCaseDelegate <NSObject>
@optional
- (void)testCaseDidStart:(GHTestCase *)testCase;
- (void)testCase:(GHTestCase *)testCase didStartTest:(GHTest *)test;
- (void)testCase:(GHTestCase *)testCase didFinishTest:(GHTest *)test passed:(BOOL)passed;
- (void)testCaseDidFinish:(GHTestCase *)testCase;
@end

@interface GHTestCase : NSObject {
	
	NSArray *tests_;	
	GHTest *currentTest_;
	
	NSString *className_;
	
	id<GHTestCaseDelegate> delegate_; // weak
	
	NSTimeInterval interval_;
	
	NSInteger failedCount_;
}

@property (assign) id<GHTestCaseDelegate> delegate;
@property (readonly) NSString *name;
@property (readonly) NSInteger failedCount;
@property (readonly) NSInteger totalCount;
@property (readonly) NSTimeInterval interval;

/*!
 Run all tests in test case.
 @result YES if all passed
 */
- (BOOL)run;

// GTM_BEGIN
- (void)setUp;
- (void)tearDown;
- (void)failWithException:(NSException*)exception;

+ (void)printException:(NSException *)exception fromTestName:(NSString *)name;
// GTM_END
@end

