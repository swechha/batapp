//
//  ForecastWeatherViewCell.m
//  BatApp
//
//  Created by Swechha Prakash on 01/04/14.
//  Copyright (c) 2014 Swechha. All rights reserved.
//

#import "ForecastWeatherViewCell.h"

@interface ForecastWeatherViewCell()
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *maxTempLabel;
@property (nonatomic, strong) UILabel *minTempLabel;
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
    
    self.dateLabel.text = self.forecastWeather.dateString;
    self.descriptionLabel.text = self.forecastWeather.weatherDescription;
    self.maxTempLabel.text = [NSString stringWithFormat:@"Max: %ld °C",self.forecastWeather.maxTemp];
    self.minTempLabel.text = [NSString stringWithFormat:@"Min: %ld °C",self.forecastWeather.minTemp];
}

- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.contentView.frame.size.width/2, 30)];
        _dateLabel.textColor = [UIColor whiteColor];
        _dateLabel.font = [UIFont fontWithName:@"Avenir" size:20];
        [self.contentView addSubview:_dateLabel];
    }
    return _dateLabel;
}


- (UILabel *)descriptionLabel
{
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.contentView.frame.size.height/2, self.contentView.frame.size.width/2, 30)];
        _descriptionLabel.textColor = [UIColor whiteColor];
        _descriptionLabel.font = [UIFont fontWithName:@"Avenir" size:20];
        [self.contentView addSubview:_descriptionLabel];
    }
    return _descriptionLabel;
}

- (UILabel *)maxTempLabel
{
    if (!_maxTempLabel) {
        _maxTempLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width/2 + 10, 10, self.contentView.frame.size.width/2, 30)];
        _maxTempLabel.textColor = [UIColor whiteColor];
        _maxTempLabel.font = [UIFont fontWithName:@"Avenir" size:20];
        [self.contentView addSubview:_maxTempLabel];
    }
    return _maxTempLabel;
}

- (UILabel *)minTempLabel
{
    if (!_minTempLabel) {
        _minTempLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width/2 + 10, self.contentView.frame.size.height/2, self.contentView.frame.size.width/2, 30)];
        _minTempLabel.textColor = [UIColor whiteColor];
        _minTempLabel.font = [UIFont fontWithName:@"Avenir" size:20];
        [self.contentView addSubview:_minTempLabel];
    }
    return _minTempLabel;
}

@end
