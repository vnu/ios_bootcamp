//
//  Tweet.m
//  twitter
//
//  Created by Timothy Lee on 8/5/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "Tweet.h"
#import <NSDate+TimeAgo.h>

@implementation Tweet


- (NSString *)tweetText {
    return  [self.data valueOrNilForKeyPath:@"text"];
}

- (NSString *)tweetID {
    return  [self.data valueOrNilForKeyPath:@"id_str"];
}

- (NSString *)screenName {
    return  [self.data valueOrNilForKeyPath:@"user.screen_name"];
}

- (NSString *)name {
    return [self.data valueOrNilForKeyPath:@"user.name"];
}

- (NSString *)profileImage {
    return [self.data valueOrNilForKeyPath:@"user.profile_image_url"];
}

- (NSString *)createdAt {
    return [self.data valueOrNilForKeyPath:@"created_at"];
}

- (NSString *)timeAgo{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
    NSDate *date = [dateFormatter dateFromString:self.createdAt];
    return [date timeAgo];
}

+ (NSMutableArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *params in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:params]];
    }
    return tweets;
}
@end
