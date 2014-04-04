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
@property NSString *baseURL;
@property NSString *appID;
@property NSMutableArray *searchResults;
@property (nonatomic,weak) HomeViewController *parentController;
@property AFJSONRequestOperation *jsonRequestOperation;
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
    
    //Search Bar
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 40, self.view.frame.size.width-20, 50)];
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchBar.delegate = self;
    
    //Table View
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 90, self.view.frame.size.width-20, self.view.frame.size.height-60) style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"SearchCell"];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:1.0]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //Cancel button to dismiss the view
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 100, 30)];
    cancelButton.titleLabel.font = [UIFont fontWithName:@"Avenir" size:20];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelButton setTitle:@"〈 Back" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.tableView];
    [self.view addSubview:cancelButton];
}

- (void)searchCity
{
    __weak SearchViewController *weakSelf = self;
    [self.searchResults removeAllObjects];
    NSString *searchString = [self.searchBar.text stringByAddingPercentEscapesUsingEncoding:NSStringEncodingConversionAllowLossy];
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?q=%@&units=metric&mode=json&APPID=%@",self.baseURL,searchString,self.appID]];
    NSURLRequest *searchRequest = [NSURLRequest requestWithURL:requestURL];
    
    self.jsonRequestOperation = [[AFJSONRequestOperation alloc] initWithRequest:searchRequest];
    [self.jsonRequestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseList = responseObject[@"list"];
        for (NSDictionary *listObject in responseList) {
            [weakSelf.searchResults addObject:@{@"name":listObject[@"name"], @"weather":listObject}];
            [weakSelf.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    [self.jsonRequestOperation start];
}

- (void)backButtonPressed
{
    [self.navigationController popViewControllerAnimated:YES];
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
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault     reuseIdentifier:identifier];
    }
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
    if (self.jsonRequestOperation.isExecuting) {
        [self.jsonRequestOperation cancel];
        NSLog(@"Current JSON request canceled");
    }
    [self searchCity];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchResults removeAllObjects];
    [self.tableView reloadData];
    NSLog(@"Cancel button clicked");
}

@end
