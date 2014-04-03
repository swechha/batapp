//
//  SearchViewController.h
//  BatApp
//
//  Created by Swechha Prakash on 03/04/14.
//  Copyright (c) 2014 Swechha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"

@interface SearchViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>
- (id)initWithParentController:(HomeViewController *)parentController;
@end
