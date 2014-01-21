//
//  RottenTomatoesDetailsViewController.m
//  RottenTomatoes
//
//  Created by Angus Huang on 1/21/14.
//  Copyright (c) 2014 Angus Huang. All rights reserved.
//

#import "RottenTomatoesDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "Movie.h"
@interface RottenTomatoesDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
@end

@implementation RottenTomatoesDetailsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.posterImage setImageWithURL:[self.movie getDetailPosterNSURL]];
    self.title = self.movie.title;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return (section == 0) ? @"Summary" : @"Cast";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = (indexPath.section == 0) ? self.movie.synopsis : [self.movie getFormattedCastString];
    
    CGSize size = CGSizeMake(self.tableView.frame.size.width - 20, CGFLOAT_MAX);
    size = [text sizeWithFont:[UIFont systemFontOfSize:11] constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    
    return size.height + 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *text = (indexPath.section == 0) ? self.movie.synopsis : [self.movie getFormattedCastString];
    cell.textLabel.text = text;
    cell.textLabel.font = [UIFont systemFontOfSize:11];
    cell.textLabel.numberOfLines = 0;
    
    return cell;
}

@end
