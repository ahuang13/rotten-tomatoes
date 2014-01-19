//
//  MovieParser.m
//  RottenTomatoes
//
//  Created by Angus Huang on 1/18/14.
//  Copyright (c) 2014 Angus Huang. All rights reserved.
//

#import "MoviesParser.h"
#import "Movie.h"

@implementation MoviesParser

//==============================================================================
#pragma mark - Public Methods
//==============================================================================

+ (NSMutableArray *)parse:(NSDictionary *)dict {
    
    // Allocate the result array of Movie objects.
    NSMutableArray *movies = [[NSMutableArray alloc] init];
    
    // Loop through all the movies in the dictionary array.
    NSArray *movieDictsArray = [dict objectForKey:@"movies"];
    for (NSDictionary *movieDict in movieDictsArray) {
        Movie *movie = [MoviesParser parseMovie:movieDict];
        [movies addObject:movie];
    }
    
    return movies;
}

//==============================================================================
#pragma mark - Private Methods
//==============================================================================

+ (Movie *)parseMovie:(NSDictionary *)movieDict {
    
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
    movie.cast = [MoviesParser parseCast:movieDict];
    
    return movie;
}

+ (NSMutableArray *)parseCast:(NSDictionary *)movieDict {
    
    NSMutableArray *cast = [[NSMutableArray alloc] init];

    // Loop through all cast members in the dictionary array.
    NSArray *castDictsArray = [movieDict objectForKey:@"abridged_cast"];
    for (NSDictionary *castDict in castDictsArray) {
        NSString *name = [castDict objectForKey:@"name"];
        NSLog(@"%@", name);
        [cast addObject:name];
    }
    
    return cast;
}

@end
