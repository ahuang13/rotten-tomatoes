//
//  Movie.h
//  RottenTomatoes
//
//  Created by Angus Huang on 1/18/14.
//  Copyright (c) 2014 Angus Huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property NSString *title;
@property NSString *synopsis;
@property NSMutableArray *cast;
@property NSString *thumbnailPosterUrl;
@property NSString *detailPosterUrl;

- (NSString *)getFormattedCastString;

@end
