//
//  Weather.h
//  BatApp
//
//  Created by Swechha Prakash on 28/03/14.
//  Copyright (c) 2014 Swechha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Weather : NSObject

@property NSString *cityName;
@property CGFloat latitude;
@property CGFloat longitude;
//Temperature unit - Kelvin
@property NSInteger temperature;
//Pressure unit - hPa
@property NSInteger pressure;
@property NSInteger temperatureMin;
@property NSInteger temperatureMax;
//Humidity in %
@property CGFloat humidity;
//Overall weather using codes on OpenWeatherMap
@property NSArray *weather;

- (instancetype)initWithLocation:(CLLocation*)location;
- (instancetype)initWithDictionary:(NSDictionary*)response;

@end
