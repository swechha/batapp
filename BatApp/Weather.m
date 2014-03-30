//
//  Weather.m
//  BatApp
//
//  Created by Swechha Prakash on 28/03/14.
//  Copyright (c) 2014 Swechha. All rights reserved.
//

#import "Weather.h"
#import <OpenWeatherMapAPI/OWMWeatherAPI.h>
#import <math.h>

@interface Weather()

@property (nonatomic, strong)NSDictionary *response;
@property OWMWeatherAPI *weatherAPI;

@end

@implementation Weather

- (instancetype)init
{
    if (self = [super init]) {
        //init
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary*)response
{
    if (self = [super init]) {
        _latitude = [response[@"coord"][@"lat"] floatValue];
        _longitude = [response[@"coord"][@"long"] floatValue];
        _temperature = roundf([response[@"main"][@"temp"] floatValue]);
        _cityName = response[@"name"];
        _weatherDescription = response[@"weather"][0][@"description"];
        _iconID = response[@"weather"][0][@"icon"];
        _humidity = [response[@"main"][@"humidity"] integerValue];
        _temperatureMax = [response[@"main"][@"temp_max"] integerValue];
        _temperatureMin = [response[@"main"][@"temp_min"] integerValue];
    }
    return self;
}

@end
