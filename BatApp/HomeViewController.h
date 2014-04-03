//
//  HomeViewController.h
//  BatApp
//
//  Created by Swechha Prakash on 27/03/14.
//  Copyright (c) 2014 Swechha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface HomeViewController : UICollectionViewController <CLLocationManagerDelegate>

- (void)addNewCityFromDicionary:(NSDictionary *)dictionary;

@end
