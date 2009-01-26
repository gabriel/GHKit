//
//  TestsMain.m
//  GHKit
//
//  Created by Gabriel Handford on 1/25/09.
//  Copyright 2009. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/NSDebug.h>

#import <GHUnit/GHUnit.h>
#import <GHUnit/GHTestApp.h>

int main(int argc, char *argv[]) {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	GHTestApp *app = [[GHTestApp alloc] init];
	[NSApp run];
	[app release];
	[pool release];
}