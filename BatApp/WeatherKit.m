//
//  WeatherKit.m
//  BatApp
//
//  Created by Swechha Prakash on 29/03/14.
//  Copyright (c) 2014 Swechha. All rights reserved.
//

#import "WeatherKit.h"
#import <OWMWeatherAPI.h>
#import <AFNetworking.h>

@interface WeatherKit()
@property OWMWeatherAPI* weatherAPI;
@property NSURL *imageBaseURL;
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
        _imageBaseURL = [[NSURL alloc] initWithString:@"http://openweathermap.org/img/w"];
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

- (void)forecastAtLocation:(CLLocation*)location success:(void (^)(NSDictionary* result))success faliure:(void (^)(NSError *error))failure
{
    [self.weatherAPI dailyForecastWeatherByCoordinate:location.coordinate withCount:14 andCallback:^(NSError *error, NSDictionary *result) {
        if (!error) {
            //get the forecast
            success([result copy]);
        } else {
            failure(error);
        }
    }];
}

- (void)weatherIconWithId:(NSString *)iconId success:(void (^)(UIImage* icon))sucess failure:(void (^)(NSError* error))failure
{
    NSURL *imageURL = [self.imageBaseURL URLByAppendingPathComponent:iconId];
    UIImage *iconImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
    if (iconImage) {
        sucess([iconImage copy]);
    } else {
        failure([NSError errorWithDomain:@"Faield to fetch the image" code:-1 userInfo:nil]);
    }
}

@end
