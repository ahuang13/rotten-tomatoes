//
//  RottenTomatoesDetailViewController.m
//  RottenTomatoes
//
//  Created by Angus Huang on 1/18/14.
//  Copyright (c) 2014 Angus Huang. All rights reserved.
//

#import "RottenTomatoesDetailViewController.h"

@interface RottenTomatoesDetailViewController ()
- (void)configureView;
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
        self.summaryLabel.text = self.movie.synopsis;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

@end
