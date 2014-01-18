//
//  Movie.h
//  iRottenTomatoes
//
//  Created by Vinu Charanya on 10/20/13.
//  Copyright (c) 2013 vnu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *starring;

+ (NSArray *)moviesWithJSON:(NSArray *)results;

@end
