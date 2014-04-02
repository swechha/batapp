//
//  ForecastWeather.m
//  BatApp
//
//  Created by Swechha Prakash on 01/04/14.
//  Copyright (c) 2014 Swechha. All rights reserved.
//

#import "ForecastWeather.h"

@implementation ForecastWeather

- (instancetype)initWithDictionary: (NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.maxTemp = [dictionary[@"temp"][@"max"] integerValue];
        self.minTemp = [dictionary[@"temp"][@"min"] integerValue];
        self.weatherDescription = dictionary[@"weather"][0][@"description"];
        
        NSDate *date = dictionary[@"dt"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd-mm-yyyy"];
        self.dateString = [formatter stringFromDate:date];
    }
    return self;
}

@end
