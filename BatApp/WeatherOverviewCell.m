//
//  WeatherOverviewCell.m
//  BatApp
//
//  Created by Swechha Prakash on 28/03/14.
//  Copyright (c) 2014 Swechha. All rights reserved.
//

#import "WeatherOverviewCell.h"
#import "WeatherKit.h"

@interface WeatherOverviewCell()
@property (nonatomic, strong) UILabel *cityLabel;
@property (nonatomic, strong) UILabel *humidityLabel;
@property (nonatomic, strong) UILabel *maxTempLabel;
@property (nonatomic, strong) UILabel *minTempLabel;
@property (nonatomic, strong) UILabel *temperatureLabel;
@property (nonatomic, strong) UILabel *weatherDescription;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIImageView *currentLocationView;
@end

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
    
    self.cityLabel.text = self.weatherObject.cityName;
    self.humidityLabel.text = [NSString stringWithFormat:@"%ld %% Humidity", weatherObject.humidity];
    self.maxTempLabel.text = [NSString stringWithFormat:@"Max: %ld °C", weatherObject.temperatureMax];
    self.minTempLabel.text = [NSString stringWithFormat:@"Min: %ld °C", weatherObject.temperatureMin];
    self.weatherDescription.text = weatherObject.weatherDescription;
    self.temperatureLabel.text = [NSString stringWithFormat:@"%ld °C",(long)self.weatherObject.temperature];
    
    //Weather icon
    self.iconView = [[WeatherKit sharedInstance] weatherIconWithId:self.weatherObject.iconID];
    self.iconView.center = CGPointMake(3*self.contentView.frame.size.width/4, 205);
    [self.contentView addSubview:self.iconView];
    
    //Icon for current location
    if (self.weatherObject.isCurrentLocation) {
        UIImage *isCurrentLocation = [UIImage imageNamed:@"location"];
        isCurrentLocation = [isCurrentLocation imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.currentLocationView.image = isCurrentLocation;
    }
   
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    _iconView = nil;
    _currentLocationView.image = nil;
}

#pragma mark - On-demand Getters

- (UILabel *)cityLabel
{
    if (!_cityLabel) {
        _cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.contentView.frame.size.width-20, 40)];
        _cityLabel.font = [UIFont fontWithName:@"Avenir" size:32];
        _cityLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_cityLabel];
    }
    return _cityLabel;
}

- (UILabel *)temperatureLabel
{
    if (!_temperatureLabel) {
        _temperatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 180, self.contentView.frame.size.width/2, 50)];
        _temperatureLabel.font = [UIFont fontWithName:@"Avenir" size:48];
        _temperatureLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_temperatureLabel];
    }
    return _temperatureLabel;
}

- (UILabel *)maxTempLabel
{
    if (!_maxTempLabel) {
        _maxTempLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, self.contentView.frame.size.width, 15)];
        _maxTempLabel.font = [UIFont fontWithName:@"Avenir" size:14];
        _maxTempLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_maxTempLabel];
    }
    return _maxTempLabel;
}

- (UILabel *)minTempLabel
{
    if (!_minTempLabel) {
        _minTempLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 110, self.contentView.frame.size.width, 15)];
        _minTempLabel.font = [UIFont fontWithName:@"Avenir" size:14];
        _minTempLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_minTempLabel];
    }
    return _minTempLabel;
}

- (UILabel *)humidityLabel
{
    if (!_humidityLabel) {
        _humidityLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, self.contentView.frame.size.width-20, 20)];
        _humidityLabel.font = [UIFont fontWithName:@"Avenir" size:18];
        _humidityLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_humidityLabel];
    }
    return _humidityLabel;
}

- (UILabel *)weatherDescription
{
    if (!_weatherDescription) {
        _weatherDescription = [[UILabel alloc] initWithFrame:CGRectMake(10, 140, self.contentView.frame.size.width, 30)];
        _weatherDescription.font = [UIFont fontWithName:@"Avenir" size:22];
        _weatherDescription.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_weatherDescription];
    }
    return _weatherDescription;
}

- (UIImageView *)currentLocationView
{
    if (!_currentLocationView) {
        _currentLocationView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [_currentLocationView setTintColor:[UIColor whiteColor]];
        _currentLocationView.center = CGPointMake(self.contentView.frame.size.width-20, 60);
        [self.contentView addSubview:_currentLocationView];
    }
    return _currentLocationView;
}

@end
