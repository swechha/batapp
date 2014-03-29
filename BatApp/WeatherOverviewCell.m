//
//  WeatherOverviewCell.m
//  BatApp
//
//  Created by Swechha Prakash on 28/03/14.
//  Copyright (c) 2014 Swechha. All rights reserved.
//

#import "WeatherOverviewCell.h"

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
    
    //Temperature Label
    UILabel *temperatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width/2, self.contentView.frame.size.height/2)];
    temperatureLabel.font = [UIFont fontWithName:@"Avenir" size:40];
    temperatureLabel.textColor = [UIColor whiteColor];
    temperatureLabel.center = CGPointMake(20+self.contentView.frame.size.width/4, 3*self.contentView.frame.size.height/4);
    temperatureLabel.text = [NSString stringWithFormat:@"%ld °C",(long)self.weatherObject.temperature];
    
    //City Name Label
    UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.contentView.frame.size.width, self.contentView.frame.size.height/2)];
    cityLabel.font = [UIFont fontWithName:@"Avenir" size:32];
    cityLabel.textColor = [UIColor whiteColor];
    cityLabel.text = self.weatherObject.cityName;
    
    //Adding subviews
    [self.contentView addSubview:temperatureLabel];
    [self.contentView addSubview:cityLabel];
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
