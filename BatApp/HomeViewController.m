//
//  HomeViewController.m
//  BatApp
//
//  Created by Swechha Prakash on 27/03/14.
//  Copyright (c) 2014 Swechha. All rights reserved.
//

#import "HomeViewController.h"
#import "WeatherOverviewCell.h"
#import "Weather.h"
#import "WeatherKit.h"
#import "DetailViewController.h"
#import <LiveFrost.h>

@interface HomeViewController ()
@property LFGlassView *glassView;
@property UIButton *addButton;
@property UIButton *settingsButton;
@property NSMutableArray *weatherData;
@end

@implementation HomeViewController

- (id)init {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 20;
    flowLayout.footerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 40);
    flowLayout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 40);
    
    self = [super initWithCollectionViewLayout:flowLayout];
    if (self) {
        [self startUpdatingCurrentLocation];
        //initialize weatherData with current location
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerClass:[WeatherOverviewCell class] forCellWithReuseIdentifier:@"WeatherCell"];
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    [self.collectionView setBackgroundView:backgroundView];
    
    //Adding blur to the background
    _glassView = [[LFGlassView alloc] initWithFrame:backgroundView.bounds];
    _glassView.blurRadius = 0.8;
    _glassView.liveBlurring = YES;
    [backgroundView addSubview:self.glassView];
    
    
    //HARDCODED STUFF -- NEED TO REMOVE IT
    //ALSO USE WEAK SELF WHEN YOU REWRITE THIS CODE FOR "+" BUTTON
    //__________________________________________________________________________________________
    [[WeatherKit sharedInstance] weatherAtLocation:[[CLLocation alloc] initWithLatitude:35 longitude:139] success:^(NSDictionary *result) {
        Weather *weather = [[Weather alloc] initWithDictionary:result];
        self.weatherData = [[NSMutableArray alloc]initWithObjects:weather, nil];
        [self.collectionView reloadData];
    } faliure:^(NSError *error) {
        NSLog(@"Whaaaaaaaa");
    }];
    [[WeatherKit sharedInstance] weatherAtLocation:[[CLLocation alloc] initWithLatitude:50 longitude:28] success:^(NSDictionary *result) {
        Weather *weather = [[Weather alloc] initWithDictionary:result];
        [self.weatherData addObject:weather];
        [self.collectionView reloadData];
    } faliure:^(NSError *error) {
        NSLog(@"Whaaaaaaaa");
    }];
    //___________________________________________________________________________________________
    
    [self addTopButtons];
}


//For adding "+" and "settings" icon on top of the collection view
//Size of button: 30x30, center of button: (25,25), Font size: 30
- (void)addTopButtons
{
    _addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [self.addButton.titleLabel setFont:[UIFont fontWithName:@"Avenir" size:30]];
    [self.addButton setTitle:@"+" forState:UIControlStateNormal];
    self.addButton.center = CGPointMake(25, 25);
    [self.addButton targetForAction:@selector(addNewCity) withSender:self];
    
    [self.collectionView addSubview:self.addButton];
}

- (void)startUpdatingCurrentLocation
{
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    
    [locationManager startUpdatingLocation];
}

//Called on clicking on + button
- (void)addNewCity
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UICollectionViewDelegate methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Weather *selectedWeather = [self.weatherData objectAtIndex:indexPath.row];
    //Create and push detailViewController
    CLLocation *thisLocation = [[CLLocation alloc] initWithLatitude:selectedWeather.latitude longitude:selectedWeather.longitude];
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithLocation:thisLocation];
    detailViewController.cityName = selectedWeather.cityName;
    
    [self.navigationController pushViewController:detailViewController animated:NO];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%lf %lf",self.view.frame.size.width-20, (self.view.frame.size.height-80)/2);
    return CGSizeMake(300, 244);
}

#pragma mark - UICollectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.weatherData count];
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WeatherOverviewCell *weatherCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"WeatherCell" forIndexPath:indexPath];
    weatherCell.weatherObject = [self.weatherData objectAtIndex:indexPath.row];
    return weatherCell;
}

#pragma mark CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLocation = [locations lastObject];
    if (!_weatherData) {
        [[WeatherKit sharedInstance] weatherAtLocation:currentLocation success:^(NSDictionary *result) {
            Weather *weather = [[Weather alloc] initWithDictionary:result];
            self.weatherData = [[NSMutableArray alloc]initWithObjects:weather, nil];
            [self.collectionView reloadData];
        } faliure:^(NSError *error) {
            NSLog(@"Whaaaaaaaa");
        }];
    } else {
        [[WeatherKit sharedInstance] weatherAtLocation:[[CLLocation alloc] initWithLatitude:35 longitude:139] success:^(NSDictionary *result) {
            Weather *weather = [[Weather alloc] initWithDictionary:result];
            self.weatherData[0] = weather;
            [self.collectionView reloadData];
        } faliure:^(NSError *error) {
            NSLog(@"Whaaaaaaaa");
        }];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Location Manager failed");
    //Display a message for "Cannot get the current location
}

@end
