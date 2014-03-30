//
//  WeatherOverviewCell.m
//  BatApp
//
//  Created by Swechha Prakash on 28/03/14.
//  Copyright (c) 2014 Swechha. All rights reserved.
//

#import "WeatherOverviewCell.h"
#import "WeatherKit.h"

@implementation WeatherOverviewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.2]];
    }
    return self;
}

- (void)setWeatherObject:(Weather *)weatherObject
{
    _weatherObject = weatherObject;
    
    //City Name Label
    UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.contentView.frame.size.width, 40)];
    cityLabel.font = [UIFont fontWithName:@"Avenir" size:32];
    cityLabel.textColor = [UIColor whiteColor];
    cityLabel.text = self.weatherObject.cityName;
    
    //Humidity Label
    UILabel *humidityLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, self.contentView.frame.size.width, 20)];
    humidityLabel.font = [UIFont fontWithName:@"Avenir" size:18];
    humidityLabel.textColor = [UIColor whiteColor];
    humidityLabel.text = [NSString stringWithFormat:@"%ld %% Humidity", weatherObject.humidity];
    
    //Max/Min temperature labels
    UILabel *maxTempLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, self.contentView.frame.size.width, 15)];
    UILabel *minTempLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 110, self.contentView.frame.size.width, 15)];
    maxTempLabel.font = [UIFont fontWithName:@"Avenir" size:14];
    maxTempLabel.textColor = [UIColor whiteColor];
    minTempLabel.font = [UIFont fontWithName:@"Avenir" size:14];
    minTempLabel.textColor = [UIColor whiteColor];
    maxTempLabel.text = [NSString stringWithFormat:@"Max: %ld °C", weatherObject.temperatureMax];
    minTempLabel.text = [NSString stringWithFormat:@"Min: %ld °C", weatherObject.temperatureMin];
    
    //Weather description
    UILabel *weatherDecription = [[UILabel alloc] initWithFrame:CGRectMake(10, 140, self.contentView.frame.size.width, 30)];
    weatherDecription.font = [UIFont fontWithName:@"Avenir" size:22];
    weatherDecription.textColor = [UIColor whiteColor];
    weatherDecription.text = weatherObject.weatherDescription;
    
    //Temperature Label
    UILabel *temperatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 180, self.contentView.frame.size.width/2, 50)];
    temperatureLabel.font = [UIFont fontWithName:@"Avenir" size:48];
    temperatureLabel.textColor = [UIColor whiteColor];
    temperatureLabel.text = [NSString stringWithFormat:@"%ld °C",(long)self.weatherObject.temperature];
    
    //Weather icon
    [[WeatherKit sharedInstance] weatherIconWithId:weatherObject.iconID success:^(UIImage *icon) {
        UIImageView *weatherIconView = [[UIImageView alloc] initWithImage:icon];
        weatherIconView.center = CGPointMake(3*self.contentView.frame.size.width/4, 205);
        [self.contentView addSubview:weatherIconView];
    } failure:^(NSError *error) {
        NSLog(@"Failed to get the icon");
    }];
    
    //Adding subviews
    [self.contentView addSubview:cityLabel];
    [self.contentView addSubview:humidityLabel];
    [self.contentView addSubview:temperatureLabel];
    [self.contentView addSubview:weatherDecription];
    [self.contentView addSubview:maxTempLabel];
    [self.contentView addSubview:minTempLabel];
}

@end
