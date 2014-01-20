//
//  RottenTomatoesDetailViewController.h
//  RottenTomatoes
//
//  Created by Angus Huang on 1/18/14.
//  Copyright (c) 2014 Angus Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface RottenTomatoesDetailViewController : UIViewController

- (void)setDetailItem:(Movie *)movie;

@property (strong, nonatomic) Movie *movie;

@end
