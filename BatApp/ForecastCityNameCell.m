//
//  ForecastCityNameCell.m
//  BatApp
//
//  Created by Swechha Prakash on 02/04/14.
//  Copyright (c) 2014 Swechha. All rights reserved.
//

#import "ForecastCityNameCell.h"

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
    
    UILabel *forecastLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.contentView.frame.size.width-20, 40)];
    UILabel *cityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, self.contentView.frame.size.width-20, 22)];
    
    forecastLabel.textColor = [UIColor whiteColor];
    forecastLabel.font = [UIFont fontWithName:@"Avenir" size:38];
    forecastLabel.text = @"Forecast";
    
    cityNameLabel.textColor = [UIColor whiteColor];
    cityNameLabel.font = [UIFont fontWithName:@"Avenir" size:20];
    cityNameLabel.text = cityName;
    
    [self.contentView addSubview:forecastLabel];
    [self.contentView addSubview:cityNameLabel];
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
