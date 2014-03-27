//
//  HomeViewController.m
//  BatApp
//
//  Created by Swechha Prakash on 27/03/14.
//  Copyright (c) 2014 Swechha. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)init {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 20;
    self = [super initWithCollectionViewLayout:flowLayout];
    if (self) {
        //custom init
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    [self.collectionView setBackgroundView:backgroundView];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
