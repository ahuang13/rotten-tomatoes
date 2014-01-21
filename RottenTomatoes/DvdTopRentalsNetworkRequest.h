//
//  RottenTomatoesNetworkRequest.h
//  RottenTomatoes
//
//  Created by Angus Huang on 1/18/14.
//  Copyright (c) 2014 Angus Huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DvdTopRentalsNetworkRequest : NSObject

+ (void)fetchDvdTopRentals:(void (^)(NSMutableArray *))callback errorHandler:(void (^)(NSError *))errorHandler;

@end
