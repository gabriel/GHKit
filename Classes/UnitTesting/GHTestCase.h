//
//  GHTestCase.h
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

#import <Foundation/Foundation.h>
#import "GHTestMacros.h"

// GTM_BEGIN
@interface GHTestCase : NSObject {
  SEL currentSelector_;
}

- (void)setUp;
- (void)invokeTest;
- (void)tearDown;
- (void)performTest:(SEL)sel;
- (void)failWithException:(NSException*)exception;

+ (void)printException:(NSException *)exception fromTestName:(NSString *)name;
@end
// GTM_END
