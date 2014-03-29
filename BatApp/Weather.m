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
        _temperature = roundf([response[@"main"][@"temp"] floatValue]);
        _cityName = response[@"name"];
    }
    return self;
}

@end
