//
//  DetailViewController.m
//  BatApp
//
//  Created by Swechha Prakash on 31/03/14.
//  Copyright (c) 2014 Swechha. All rights reserved.
//

#import "DetailViewController.h"
#import <LiveFrost.h>
#import "ForecastWeatherViewCell.h"
#import "WeatherKit.h"
#import "ForecastWeather.h"
#import "ForecastCityNameCell.h"

@interface DetailViewController ()
@property LFGlassView *glassView;
@property NSMutableArray *forecastList;
@property CLLocation *location;
@end

@implementation DetailViewController

- (id)initWithLocation:(CLLocation *)location
{
    _location = location;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 20;
    flowLayout.footerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 40);
    flowLayout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 40);
    self = [super initWithCollectionViewLayout:flowLayout];
    if (self) {
        _forecastList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)makeRequestForForecast
{
    __weak DetailViewController *weakSelf = self;
    [[WeatherKit sharedInstance] forecastAtLocation:self.location success:^(NSDictionary *result) {
        [weakSelf createForecastModelFromArray:result[@"list"]];
        [weakSelf.collectionView reloadData];
    } faliure:^(NSError *error) {
        NSLog(@"Request to get forecast failed!");
        //Display appropriate error message and exit
    }];
}

- (void)createForecastModelFromArray:(NSArray *)list
{
    for (NSDictionary *forecast in list) {
        ForecastWeather *forecastObject = [[ForecastWeather alloc] initWithDictionary:forecast];
        [self.forecastList addObject:forecastObject];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self makeRequestForForecast];
    
    [self.collectionView registerClass:[ForecastWeatherViewCell class] forCellWithReuseIdentifier:@"ForecastCell"];
    [self.collectionView registerClass:[ForecastCityNameCell class] forCellWithReuseIdentifier:@"ForecastCityNameCell"];
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    
    //Adding blur to the background
    self.glassView = [[LFGlassView alloc] initWithFrame:self.view.frame];
    self.glassView.blurRadius = 0.8;
    self.glassView.liveBlurring = YES;
    [backgroundView addSubview:self.glassView];
    [self.glassView performSelector:@selector(setLiveBlurring:) withObject:@NO afterDelay:0.25];
    
    [self.collectionView setBackgroundView:backgroundView];
    
    [self addCancelButton];
}

/* Cancel button: Size - 30x30, Font: 30
 * Center: (width-25, 20)
 */
- (void)addCancelButton
{
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    cancelButton.center = CGPointMake(self.collectionView.frame.size.width-25, 20);
    [cancelButton.titleLabel setTextColor:[UIColor whiteColor]];
    [cancelButton.titleLabel setFont:[UIFont fontWithName:@"Avenir" size:30]];
    [cancelButton setTitle:@"x" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.collectionView addSubview:cancelButton];
}

//Dismiss the detail view on the press of cancel button
- (void)cancelButtonPressed
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return (1+[self.forecastList count]);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ForecastCityNameCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ForecastCityNameCell" forIndexPath:indexPath];
        cell.cityName = self.cityName;
        return cell;
    } else {
        ForecastWeatherViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ForecastCell" forIndexPath:indexPath];
        cell.forecastWeather = self.forecastList[indexPath.row-1];
        return cell;
    }
}

#pragma mark - UICollectionViewDelegate methods

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.collectionView.frame.size.width - 20, 100);
}

@end
