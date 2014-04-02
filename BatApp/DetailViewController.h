//
//  DetailViewController.h
//  BatApp
//
//  Created by Swechha Prakash on 31/03/14.
//  Copyright (c) 2014 Swechha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface DetailViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, copy) NSString *cityName;
- (id)initWithLocation:(CLLocation *)location;
@end
