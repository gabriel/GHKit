//
//  GHCLUtilsTest.m
//  GHKitIPhone
//
//  Created by Gabriel Handford on 4/23/09.
//  Copyright 2009 Yelp. All rights reserved.
//

#import "GHCLUtils.h"

@interface GHCLUtilsTest : GHTestCase { }
@end

@implementation GHCLUtilsTest

/*!
 Verified against http://www.movable-type.co.uk/scripts/latlong-vincenty-direct.html
 To convert from degrees, minutes, seconds to decimal: http://www.fcc.gov/mb/audio/bickel/DDDMMSS-decimal.html 
 */
- (void)testMove {
	CLLocationCoordinate2D c1 = {37.786759,-122.402201}; // (37° 47' 12.3324", -122° 24' 7.9236")
	CLLocationCoordinate2D c2 = GHLocationAtDistance(c1, 15.0, M_PI/2.0);
	
	GHAssertEqualsWithAccuracy(c2.latitude, 37.786759, 0.000001, nil); 
	GHAssertEqualsWithAccuracy(c2.longitude, -122.402031, 0.000001, nil);
}

@end
