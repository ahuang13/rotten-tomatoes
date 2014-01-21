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
//    [cell.textLabel sizeToFit];

    NSLog(@"%d", indexPath.row);
    NSLog(@"%d", indexPath.section);
    
    // Configure the cell...
//    cell.textLabel;
//    cell.detailTextLabel;
//    cell.imageView;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
