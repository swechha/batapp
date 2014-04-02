//
//  ForecastWeatherViewCell.m
//  BatApp
//
//  Created by Swechha Prakash on 01/04/14.
//  Copyright (c) 2014 Swechha. All rights reserved.
//

#import "ForecastWeatherViewCell.h"

@interface ForecastWeatherViewCell()

@end

@implementation ForecastWeatherViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.2]];
    }
    return self;
}

- (void)setForecastWeather:(ForecastWeather *)forecastWeather
{
    _forecastWeather = forecastWeather;
    
    //Label for date (Top Left)
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.contentView.frame.size.width/2, 30)];
    dateLabel.text = self.forecastWeather.dateString;
    dateLabel.textColor = [UIColor whiteColor];
    dateLabel.font = [UIFont fontWithName:@"Avenir" size:20];
    
    //Label for weather decription (Bottom Left)
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.contentView.frame.size.height/2, self.contentView.frame.size.width/2, 30)];
    descriptionLabel.text = self.forecastWeather.weatherDescription;
    descriptionLabel.textColor = [UIColor whiteColor];
    descriptionLabel.font = [UIFont fontWithName:@"Avenir" size:20];
    
    //Minimum tempertaure label (Top Right)
    UILabel *maxTempLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width/2 + 10, 10, self.contentView.frame.size.width/2, 30)];
    maxTempLabel.text = [NSString stringWithFormat:@"Max: %ld °C",self.forecastWeather.maxTemp];
    maxTempLabel.textColor = [UIColor whiteColor];
    maxTempLabel.font = [UIFont fontWithName:@"Avenir" size:20];
    
    
    //Maximum temperature label (Bottom Right)
    UILabel *minTempLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width/2 + 10, self.contentView.frame.size.height/2, self.contentView.frame.size.width/2, 30)];
    minTempLabel.text = [NSString stringWithFormat:@"Min: %ld °C",self.forecastWeather.minTemp];
    minTempLabel.textColor = [UIColor whiteColor];
    minTempLabel.font = [UIFont fontWithName:@"Avenir" size:20];
    
    [self.contentView addSubview:dateLabel];
    [self.contentView addSubview:descriptionLabel];
    [self.contentView addSubview:maxTempLabel];
    [self.contentView addSubview:minTempLabel];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
