//
//  SearchViewController.m
//  BatApp
//
//  Created by Swechha Prakash on 03/04/14.
//  Copyright (c) 2014 Swechha. All rights reserved.
//

#import "SearchViewController.h"
#import <AFNetworking.h>

@interface SearchViewController ()
@property UISearchBar *searchBar;
@property UITableView *tableView;
@property UISearchDisplayController *searchController;
@property NSString *baseURL;
@property NSString *appID;
@property NSMutableArray *searchResults;
@property (nonatomic,weak) HomeViewController *parentController;
@end

@implementation SearchViewController

- (id)initWithParentController:(HomeViewController *)parentController
{
    self = [super init];
    if (self) {
        _parentController = parentController;
        _baseURL = @"http://api.openweathermap.org/data/2.5/find";
        _searchResults = [[NSMutableArray alloc] init];
        _appID = @"39a01302bc8f9ec64bbb6932006ace3b";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    //Table View
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 60, self.view.frame.size.width-20, self.view.frame.size.height-60) style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"SearchCell"];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //Search Bar
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width-20, 50)];
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchBar.delegate = self;
    
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.tableView];
}

- (void)searchCity
{
    [self.searchResults removeAllObjects];
    NSString *searchString = self.searchBar.text;
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?q=%@&units=metric&mode=json&APPID=%@",self.baseURL,searchString,self.appID]];
    NSURLRequest *searchRequest = [NSURLRequest requestWithURL:requestURL];
    
    AFJSONRequestOperation *jsonRequestOperation = [[AFJSONRequestOperation alloc] initWithRequest:searchRequest];
    [jsonRequestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseList = responseObject[@"list"];
        for (NSDictionary *listObject in responseList) {
            [self.searchResults addObject:@{@"name":listObject[@"name"], @"weather":listObject}];
            [self.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    [jsonRequestOperation start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"SearchCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault     reuseIdentifier:identifier];
    cell.textLabel.font = [UIFont fontWithName:@"Avenir" size:20];
    cell.textLabel.text = self.searchResults[indexPath.row][@"name"];
    
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.parentController addNewCityFromDicionary:self.searchResults[indexPath.row][@"weather"]];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UISearchBarDelegate methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchCity];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchResults removeAllObjects];
    [self.tableView reloadData];
    NSLog(@"Cancel button clicked");
}

@end
