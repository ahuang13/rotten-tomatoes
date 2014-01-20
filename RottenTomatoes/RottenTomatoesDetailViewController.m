//
//  RottenTomatoesDetailViewController.m
//  RottenTomatoes
//
//  Created by Angus Huang on 1/18/14.
//  Copyright (c) 2014 Angus Huang. All rights reserved.
//

#import "RottenTomatoesDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface RottenTomatoesDetailViewController ()
- (void)configureView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@end

@implementation RottenTomatoesDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(Movie *)movie
{
    if (_movie != movie) {
        _movie = movie;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.movie) {
        self.title = self.movie.title;
        self.summaryLabel.text = self.movie.synopsis;
        [self setPosterImageWithUrl:self.movie.detailPosterUrl];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

//==============================================================================
#pragma mark - Private Methods
//==============================================================================

- (void)setPosterImageWithUrl:(NSString *)urlString {
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    // Successful download handler.
    void (^onDownloadSuccess)(NSURLRequest *, NSHTTPURLResponse *, UIImage *) = ^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        self.imageView.image = image;
    };
    
    // Download the thumbnail poster image.
    [self.imageView setImageWithURLRequest:request
                          placeholderImage:nil
                                   success:onDownloadSuccess
                                   failure:nil];
}

@end
