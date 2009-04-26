//
//  GHCLUtils.h
//  GHKitIPhone
//
//  Created by Gabriel Handford on 4/23/09.
//  Copyright 2009. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

/*!
 Difference between lat/lng coordinates.
 @see http://www.movable-type.co.uk/scripts/latlong.html
 
 Haversine Formula
 R = earth’s radius (mean radius = 6,371km)
 Δlat = lat2 − lat1
 Δlong = long2 − long1
 a = sin²(Δlat/2) + cos(lat1).cos(lat2).sin²(Δlong/2)
 c = 2.atan2(√a, √(1−a))
 d = R.c
 
 @result Distance in kilometers.
 */
CLLocationDistance GHLatLngDistance(CLLocationCoordinate2D c1, CLLocationCoordinate2D c2);

/*!
 Check if CLLocationCoordinate2D is NULL.
 @param coordinate
 @result YES if NULL, NO otherwise
 */
BOOL GHCLLocationCoordinate2DIsNull(CLLocationCoordinate2D coordinate);

double GHDegreesToRadians(double val);
double GHRadiansToDegrees(double val);

/*!
 Calculate an endpoint given a startpoint, bearing and distance
 Vincenty 'Direct' formula based on the formula as described at http://www.movable-type.co.uk/scripts/latlong-vincenty-direct.html
 Original JavaScript implementation © 2002-2006 Chris Veness
 Obj-C code derived from http://www.thismuchiknow.co.uk/?p=120
 @param source Starting lat/lng coordinates
 @param distance Distance in meters to move
 @param bearingInRadians Bearing in radians (bearing is 0 north clockwise compass direction; 0 degrees is north, 90 degrees is east)
 @result New lat/lng coordinate
 */
CLLocationCoordinate2D GHLocationAtDistance(CLLocationCoordinate2D coordinate, CLLocationDistance distance, double bearingInRadians);
