//
//  Movie.m
//  iRottenTomatoes
//
//  Created by Vinu Charanya on 10/20/13.
//  Copyright (c) 2013 vnu. All rights reserved.
//

#import "Movie.h"

@implementation Movie
+ (NSArray *)moviesWithJSON:(NSArray *)results
{
    NSMutableArray *movies = [[NSMutableArray alloc] init];
    for (NSDictionary *keys in results) {
        Movie *movie = [[Movie alloc] init];
        movie.title = [keys objectForKey:@"title"];
        
        NSMutableArray *stars = [[NSMutableArray alloc] init];
        for (NSDictionary *member in [keys objectForKey:@"abridged_cast"]) {
            [stars addObject:[member objectForKey:@"name"]];
        }
        movie.starring = [stars componentsJoinedByString:@", "];
        
        [movies addObject:movie];
    }
    return movies;
}

@end
