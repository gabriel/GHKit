//
//  GHCLUtils.m
//  GHKitIPhone
//
//  Created by Gabriel Handford on 4/23/09.
//  Copyright 2009. All rights reserved.
//

#import "GHCLUtils.h"

const double kYPMilesPerLongitude = 69.16022727272727;
const double kYPMilesPerLatitude = 68.70795454545454;

// Represents NULL CLLocationCoordinate2D
const CLLocationCoordinate2D GHCLLocationCoordinate2DNull = {DBL_MAX, DBL_MAX};

CLLocationDistance YPLatLngDistance(CLLocationCoordinate2D c1, CLLocationCoordinate2D c2) {	
	double radius = 6371; // Earth’s radius in Kilometers
	CLLocationDegrees latitudeDiff = GHDegreesToRadians(c2.latitude - c1.latitude);  
	CLLocationDegrees longitudeDiff = GHDegreesToRadians(c2.longitude - c1.longitude);
	double nA = pow(sin(latitudeDiff/2), 2) + cos(GHDegreesToRadians(c1.latitude)) * cos(GHDegreesToRadians(c2.latitude)) * pow (sin(longitudeDiff/2), 2);
	double nC = 2 * atan2(sqrt(nA), sqrt(1 - nA));
	return radius * nC;	
}

BOOL GHCLLocationCoordinate2DIsNull(CLLocationCoordinate2D coordinate) {
	return coordinate.latitude == GHCLLocationCoordinate2DNull.latitude && coordinate.longitude == GHCLLocationCoordinate2DNull.longitude;
}

double GHDegreesToRadians(double val) {
	return val * (M_PI/180);
}

double GHRadiansToDegrees(double val) {
	return val * (180/M_PI);
}

CLLocationCoordinate2D GHLocationAtDistance(CLLocationCoordinate2D coordinate, CLLocationDistance distance, double bearingInRadians) {
	double lat1 = GHDegreesToRadians(coordinate.latitude);
	double lon1 = GHDegreesToRadians(coordinate.longitude);
	
	double a = 6378137, b = 6356752.3142, f = 1/298.257223563;  // WGS-84 ellipsiod
	double s = distance;
	double alpha1 = bearingInRadians;
	double sinAlpha1 = sin(alpha1);
	double cosAlpha1 = cos(alpha1);
	
	double tanU1 = (1 - f) * tan(lat1);
	double cosU1 = 1 / sqrt((1 + tanU1 * tanU1));
	double sinU1 = tanU1 * cosU1;
	double sigma1 = atan2(tanU1, cosAlpha1);
	double sinAlpha = cosU1 * sinAlpha1;
	double cosSqAlpha = 1 - sinAlpha * sinAlpha;
	double uSq = cosSqAlpha * (a * a - b * b) / (b * b);
	double A = 1 + uSq / 16384 * (4096 + uSq * (-768 + uSq * (320 - 175 * uSq)));
	double B = uSq / 1024 * (256 + uSq * (-128 + uSq * (74 - 47 * uSq)));
	
	double sigma = s / (b * A);
	double sigmaP = 2 * M_PI;
	
	double cos2SigmaM, sinSigma, cosSigma;
	
	while(abs(sigma - sigmaP) > 1e-12) {
		cos2SigmaM = cos(2 * sigma1 + sigma);
		sinSigma = sin(sigma);
		cosSigma = cos(sigma);
		double deltaSigma = B * sinSigma * (cos2SigmaM + B / 4 * (cosSigma * (-1 + 2 * cos2SigmaM * cos2SigmaM) - B / 6 * cos2SigmaM * (-3 + 4 * sinSigma * sinSigma) * (-3 + 4 * cos2SigmaM * cos2SigmaM)));
		sigmaP = sigma;
		sigma = s / (b * A) + deltaSigma;
	}
	
	double tmp = sinU1 * sinSigma - cosU1 * cosSigma * cosAlpha1;
	double lat2 = atan2(sinU1 * cosSigma + cosU1 * sinSigma * cosAlpha1, (1 - f) * sqrt(sinAlpha * sinAlpha + tmp * tmp));
	double lambda = atan2(sinSigma * sinAlpha1, cosU1 * cosSigma - sinU1 * sinSigma * cosAlpha1);
	double C = f / 16 * cosSqAlpha * (4 + f * (4 - 3 * cosSqAlpha));
	double L = lambda - (1 - C) * f * sinAlpha * (sigma + C * sinSigma * (cos2SigmaM + C * cosSigma * (-1 + 2 * cos2SigmaM * cos2SigmaM)));
	
	double lon2 = lon1 + L;
	
	CLLocationCoordinate2D dest;
	dest.latitude = GHRadiansToDegrees(lat2);
	dest.longitude = GHRadiansToDegrees(lon2);
	return dest;
}