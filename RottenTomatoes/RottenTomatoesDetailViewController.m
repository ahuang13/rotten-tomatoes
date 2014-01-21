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
@property (weak, nonatomic) IBOutlet UILabel *castLabel;
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

        [self.imageView setImageWithURL:[self.movie getDetailPosterNSURL]];
        
        self.summaryLabel.text = self.movie.synopsis;
        [self.summaryLabel sizeToFit];
        
        self.castLabel.text = [self.movie getFormattedCastString];
        [self.castLabel sizeToFit];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

@end
