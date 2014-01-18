//
//  RottenTomatoesClient.h
//  iRottenTomatoes
//
//  Created by Vinu Charanya on 10/20/13.
//  Copyright (c) 2013 vnu. All rights reserved.
//

#import "AFHTTPClient.h"

@interface RottenTomatoesClient : AFHTTPClient

- (void)boxOfficeWithSuccess:(void (^)(AFHTTPRequestOperation *operation, NSArray *movies))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
