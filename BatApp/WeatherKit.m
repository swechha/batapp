//
//  WeatherKit.m
//  BatApp
//
//  Created by Swechha Prakash on 29/03/14.
//  Copyright (c) 2014 Swechha. All rights reserved.
//

#import "WeatherKit.h"
#import <OWMWeatherAPI.h>

@interface WeatherKit()
@property OWMWeatherAPI* weatherAPI;
@end

@implementation WeatherKit

+ (id)sharedInstance
{
    static WeatherKit *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        _weatherAPI = [[OWMWeatherAPI alloc] initWithAPIKey:@"39a01302bc8f9ec64bbb6932006ace3b"];
    }
    return self;
}

- (void)weatherAtLocation:(CLLocation*)location success:(void (^)(NSDictionary* result))success faliure:(void (^)(NSError *error))failure
{
    [self.weatherAPI currentWeatherByCoordinate:location.coordinate withCallback:^(NSError *error, NSDictionary *result) {
        if (!error) {
            success([result copy]);
        } else {
            failure(error);
        }
    }];
}

@end
