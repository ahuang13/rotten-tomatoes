//
//  RottenTomatoesMasterViewController.m
//  RottenTomatoes
//
//  Created by Angus Huang on 1/18/14.
//  Copyright (c) 2014 Angus Huang. All rights reserved.
//

#import "RottenTomatoesMasterViewController.h"
#import "RottenTomatoesDetailViewController.h"
#import "DvdTopRentalsNetworkRequest.h"
#import "MovieCell.h"
#import "Movie.h"

@interface RottenTomatoesMasterViewController ()

@property (nonatomic, strong) NSMutableArray *movies;

@end

@implementation RottenTomatoesMasterViewController

//==============================================================================
#pragma mark - Initializers
//==============================================================================

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self loadData];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self loadData];
    }
    return self;
}

//==============================================================================
#pragma mark - View Lifecycle
//==============================================================================

- (void)viewDidLoad
{
    [super viewDidLoad];
}

//==============================================================================
#pragma mark - Table View
//==============================================================================

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Movie *movie = self.movies[indexPath.row];
    
    cell.titleLabel.text = movie.title;
    cell.synopsisLabel.text = movie.synopsis;
    cell.castLabel.text = [movie getFormattedCastString];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Movie *movie = self.movies[indexPath.row];
        [[segue destinationViewController] setDetailItem:movie];
    }
}

//==============================================================================
#pragma mark - Private Methods
//==============================================================================

- (void)loadData {
    
    void (^callback)() = ^(NSMutableArray *movies){
        NSLog(@"handler callback received... %d", movies.count);
        self.movies = movies;
        [self.tableView reloadData];
    };
    
    [DvdTopRentalsNetworkRequest fetchDvdTopRentals:(void (^)(NSMutableArray *))callback];
}

@end
