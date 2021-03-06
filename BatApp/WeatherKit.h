//
//  WeatherKit.h
//  BatApp
//
//  Created by Swechha Prakash on 29/03/14.
//  Copyright (c) 2014 Swechha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface WeatherKit : NSObject

+ (id)sharedInstance;
- (void)weatherAtLocation:(CLLocation*)location success:(void (^)(NSDictionary* result))success faliure:(void (^)(NSError *error))failure;
- (void)weatherIconWithId:(NSString *)iconId success:(void (^)(UIImage* icon))sucess failure:(void (^)(NSError* error))failure;
- (void)forecastAtLocation:(CLLocation*)location success:(void (^)(NSDictionary* result))success faliure:(void (^)(NSError *error))failure;
- (UIImageView *)weatherIconWithId:(NSString *)iconId;

@end
