//
//  RottenTomatoesNetworkRequest.h
//  RottenTomatoes
//
//  Created by Angus Huang on 1/18/14.
//  Copyright (c) 2014 Angus Huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RottenTomatoesNetworkRequest : NSObject

+ (void)fetchDvdTopRentals:(void (^)(NSMutableArray *))callback;

@end
