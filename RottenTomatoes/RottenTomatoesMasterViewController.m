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
#import "UIImageView+AFNetworking.h"
#import "TWMessageBarManager.h"
#import "NetworkErrorMessageBarStyle.h"

@interface RottenTomatoesMasterViewController ()

@property (nonatomic, strong) NSMutableArray *movies;
@property BOOL isLoading;

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
    
    // Initialize pull-to-refresh.
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    
    if (self.isLoading) {
        [self.refreshControl beginRefreshing];
    }
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
    [RottenTomatoesMasterViewController setPosterImageIn:cell forMovie:movie];
    
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
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    };
    
    void (^onDownloadError)(NSError *) = ^(NSError *connectionError) {
        [self.refreshControl endRefreshing];
        // TODO: Show error message.
        NSInteger errorCode = connectionError.code;
        NSString *errorMsg = [connectionError.userInfo objectForKey:NSLocalizedDescriptionKey];
        NSLog(@"[%d] %@", errorCode, errorMsg);

        [TWMessageBarManager sharedInstance].styleSheet = [[NetworkErrorMessageBarStyle alloc] init];
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Network Error"
                                                       description:@"Make sure you have an Internet connection."
                                                              type:TWMessageBarMessageTypeSuccess];
    };
    
    self.isLoading = YES;
    [DvdTopRentalsNetworkRequest fetchDvdTopRentals:(void (^)(NSMutableArray *))callback
                                       errorHandler:onDownloadError];
}

+ (void)setPosterImageIn:(MovieCell *)cell forMovie:(Movie *)movie {
    
    __weak MovieCell *weakCell = cell;
    
    NSURL *url = [NSURL URLWithString:movie.thumbnailPosterUrl];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    // Successful download handler.
    void (^onDownloadSuccess)(NSURLRequest *, NSHTTPURLResponse *, UIImage *) = ^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        weakCell.imageView.image = image;
        
        //only required if no placeholder is set to force the imageview on the cell to be laid out to house the new image.
        if (weakCell.imageView.frame.size.height==0 || weakCell.imageView.frame.size.width==0 ){
            [weakCell setNeedsLayout];
        }
    };
    
    // Download the thumbnail poster image.
    [cell.imageView setImageWithURLRequest:request
                          placeholderImage:nil
                                   success:onDownloadSuccess
                                   failure:nil];
}

@end
