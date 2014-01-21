//
//  RottenTomatoesNetworkRequest.m
//  RottenTomatoes
//
//  Created by Angus Huang on 1/18/14.
//  Copyright (c) 2014 Angus Huang. All rights reserved.
//

#import "DvdTopRentalsNetworkRequest.h"
#import "MoviesParser.h"

@implementation DvdTopRentalsNetworkRequest

//==============================================================================
#pragma mark - Private Constants
//==============================================================================

NSString *const REQUEST_URL = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs";

//==============================================================================
#pragma mark - Public Methods
//==============================================================================

+ (void)fetchDvdTopRentals:(void (^)(NSMutableArray *))callback errorHandler:(void (^)(NSError *))errorHandler
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:REQUEST_URL]];
    
    void (^handler)(NSURLResponse*, NSData*, NSError*) = ^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            errorHandler(connectionError);
        } else {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSMutableArray *movies = [MoviesParser parse:dict];
            callback(movies);
        }
    };
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:handler];
}

@end
