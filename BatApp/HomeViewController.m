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
#import "SearchViewController.h"
#import <LiveFrost.h>

@interface HomeViewController ()
@property (nonatomic, strong) CLLocationManager *locationManager;
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
        self.weatherData = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Initialize location manager
    _locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    
    [self.collectionView registerClass:[WeatherOverviewCell class] forCellWithReuseIdentifier:@"WeatherCell"];
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    [self.collectionView setBackgroundView:backgroundView];
    
    //Adding blur to the background
    _glassView = [[LFGlassView alloc] initWithFrame:backgroundView.bounds];
    _glassView.blurRadius = 0.8;
    _glassView.liveBlurring = YES;
    [backgroundView addSubview:self.glassView];
    
    [self addTopButtons];
    
    //start updating location
    [self startUpdatingCurrentLocation];
}


//For adding "+" and "settings" icon on top of the collection view
//Size of button: 30x30, center of button: (25,25), Font size: 30
- (void)addTopButtons
{
    _addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [self.addButton.titleLabel setFont:[UIFont fontWithName:@"Avenir" size:30]];
    [self.addButton setTitle:@"+" forState:UIControlStateNormal];
    self.addButton.center = CGPointMake(25, 25);
    [self.addButton addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.collectionView addSubview:self.addButton];
}

- (void)startUpdatingCurrentLocation
{
    [self.locationManager startUpdatingLocation];
}

//Called on clicking on + button
- (void)addButtonClicked
{
    SearchViewController *searchViewController = [[SearchViewController alloc]initWithParentController:self];
    [self.navigationController pushViewController:searchViewController animated:YES];
}

- (void)addNewCityFromDicionary:(NSDictionary *)dictionary
{
    Weather *weather = [[Weather alloc] initWithDictionary:dictionary];
    [self.weatherData addObject:weather];
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UICollectionViewDelegate methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Weather *selectedWeather = self.weatherData[indexPath.row];
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
    weatherCell.weatherObject = self.weatherData[indexPath.row];
    return weatherCell;
}

#pragma mark CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLocation = [locations lastObject];
    
    [[WeatherKit sharedInstance] weatherAtLocation:currentLocation success:^(NSDictionary *result)
    {
        Weather *weather = [[Weather alloc] initWithDictionary:result];
        weather.isCurrentLocation = YES;
        if ([self.weatherData count] != 0) {
            if ([self.weatherData[0] isCurrentLocation] == YES) {
                self.weatherData[0] = weather;
            } else {
                [self.weatherData insertObject:weather atIndex:0];
            }
        } else {
            self.weatherData[0] = weather;
        }
            
        [self.collectionView reloadData];
    } faliure:^(NSError *error) {
        NSLog(@"Couldn't get the weather at current location");
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Location Manager failed");
    //Display a message for "Cannot get the current location
}

@end
