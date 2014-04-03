//
//  ForecastCityNameCell.m
//  BatApp
//
//  Created by Swechha Prakash on 02/04/14.
//  Copyright (c) 2014 Swechha. All rights reserved.
//

#import "ForecastCityNameCell.h"

@interface ForecastCityNameCell()
@property (nonatomic, strong) UILabel *forecastLabel;
@property (nonatomic, strong) UILabel *cityNameLabel;
@end

@implementation ForecastCityNameCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setCityName:(NSString *)cityName
{
    _cityName = cityName;
    
    self.forecastLabel.text = @"Forecast";
    self.cityNameLabel.text = cityName;
    
    [self.contentView addSubview:self.forecastLabel];
    [self.contentView addSubview:self.cityNameLabel];
}

-(UILabel *)forecastLabel
{
    if (!_forecastLabel) {
        _forecastLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.contentView.frame.size.width-20, 40)];
        _forecastLabel.textColor = [UIColor whiteColor];
        _forecastLabel.font = [UIFont fontWithName:@"Avenir" size:38];
    }
    return _forecastLabel;
}

-(UILabel *)cityNameLabel
{
    if (!_cityNameLabel) {
        _cityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, self.contentView.frame.size.width-20, 22)];
        _cityNameLabel.textColor = [UIColor whiteColor];
        _cityNameLabel.font = [UIFont fontWithName:@"Avenir" size:20];
    }
    return _cityNameLabel;
}

@end
