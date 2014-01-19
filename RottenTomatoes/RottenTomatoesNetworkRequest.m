//
//  RottenTomatoesNetworkRequest.m
//  RottenTomatoes
//
//  Created by Angus Huang on 1/18/14.
//  Copyright (c) 2014 Angus Huang. All rights reserved.
//

#import "RottenTomatoesNetworkRequest.h"
#import "MoviesParser.h"

@implementation RottenTomatoesNetworkRequest

//==============================================================================
#pragma mark - Private Constants
//==============================================================================

NSString *const REQUEST_URL = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs";

//==============================================================================
#pragma mark - Public Methods
//==============================================================================

+ (void)fetchDvdTopRentals
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:REQUEST_URL]];
    
    void (^handler)(NSURLResponse*, NSData*, NSError*) = ^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@", dict);
        [MoviesParser parse:dict];
    };
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:handler];
}

@end
