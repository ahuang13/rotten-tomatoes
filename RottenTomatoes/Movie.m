//
//  Movie.m
//  RottenTomatoes
//
//  Created by Angus Huang on 1/18/14.
//  Copyright (c) 2014 Angus Huang. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (NSString *)getFormattedCastString {    
    return [self.cast componentsJoinedByString:@", "];
}

- (NSURL *)getDetailPosterNSURL {
    return [NSURL URLWithString:self.detailPosterUrl];
}

@end
