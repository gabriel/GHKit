//
//  GHTestViewDelegate.m
//
//  Created by Gabriel Handford on 11/28/08.
//  Copyright 2008. All rights reserved.
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

#import "GHTestViewDelegate.h"

#import "GHTestRunner.h"

@implementation GHTestViewDelegate

+ (void)load {
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
  [nc addObserver:self
         selector:@selector(appFinishedLaunchingHandler:)
             name:NSApplicationDidFinishLaunchingNotification
           object:nil];
  [pool release];
}

+ (void)appFinishedLaunchingHandler:(NSNotification *)notification {
	NSLog(@"Application launched");
	[NSThread detachNewThreadSelector:@selector(runTests) toTarget:self withObject:nil];	
}

+ (void)runTests {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];	
	NSLog(@"Running tests");
	GHTestRunner *runner = [[GHTestRunner alloc] init];
	[runner runTests];
	NSLog(@"Tests done");		
	[pool release];
}

@end
