//
//  MovieParser.m
//  RottenTomatoes
//
//  Created by Angus Huang on 1/18/14.
//  Copyright (c) 2014 Angus Huang. All rights reserved.
//

#import "MovieParser.h"
#import "Movie.h"

@implementation MovieParser

//==============================================================================
#pragma mark - Public Methods
//==============================================================================

+ (NSMutableArray *)parse:(NSDictionary *)dict {
    
    NSMutableArray *movies = [[NSMutableArray alloc] init];
    
    NSArray *movieDictsArray = [dict objectForKey:@"movies"];
    
    for (NSDictionary *movieDict in movieDictsArray) {
        
        Movie *movie = [[Movie alloc] init];
        
        // Parse title.
        movie.title = [movieDict objectForKey:@"title"];
        NSLog(@"%@", movie.title);
        
        // Parse synopsis.
        movie.synopsis = [movieDict objectForKey:@"synopsis"];
        NSLog(@"%@", movie.synopsis);

        // Parse poster URLs.
        NSDictionary *postersDict = [movieDict objectForKey:@"posters"];
        movie.thumbnailPosterUrl = [postersDict objectForKey:@"thumbnail"];
        movie.detailPosterUrl = [postersDict objectForKey:@"detailed"];
        NSLog(@"thumbnail = %@", movie.thumbnailPosterUrl);
        NSLog(@"detailed = %@", movie.detailPosterUrl);
        
        // Parse cast.
        movie.cast = [MovieParser parseCast:movieDict];

        // Add this movie to the result array.
        [movies addObject:movie];
    }
    
    return movies;
}

//==============================================================================
#pragma mark - Private Methods
//==============================================================================

+ (NSMutableArray *)parseCast:(NSDictionary *)movieDict {
    
    NSMutableArray *cast = [[NSMutableArray alloc] init];

    NSArray *castDictsArray = [movieDict objectForKey:@"abridged_cast"];
    for (NSDictionary *castDict in castDictsArray) {
        NSString *name = [castDict objectForKey:@"name"];
        NSLog(@"%@", name);
        [cast addObject:name];
    }
    
    return cast;
}

@end
