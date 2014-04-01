//
//  ForecastWeather.h
//  BatApp
//
//  Created by Swechha Prakash on 01/04/14.
//  Copyright (c) 2014 Swechha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForecastWeather : NSObject

@property CGFloat maxTemp;
@property CGFloat minTemp;
@property NSString *date;
@property NSString *weatherDescription;

- (instancetype)initWithDictionary: (NSDictionary *)dictionary;

@end
