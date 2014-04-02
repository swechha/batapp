//
//  ForecastWeather.h
//  BatApp
//
//  Created by Swechha Prakash on 01/04/14.
//  Copyright (c) 2014 Swechha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForecastWeather : NSObject

@property NSInteger maxTemp;
@property NSInteger minTemp;
@property (nonatomic, copy) NSString *dateString;
@property (nonatomic, copy) NSString *weatherDescription;

- (instancetype)initWithDictionary: (NSDictionary *)dictionary;

@end
