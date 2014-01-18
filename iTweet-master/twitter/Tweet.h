//
//  Tweet.h
//  twitter
//
//  Created by Timothy Lee on 8/5/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : RestObject

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *tweetID;
@property (nonatomic, strong, readonly) NSString *screenName;
@property (nonatomic, strong, readonly) NSString *tweetText;
@property (nonatomic, strong, readonly) NSString *createdAt;
@property (nonatomic, strong, readonly) NSString *timeAgo;
@property (nonatomic, strong, readonly) NSString *profileImage;


+ (NSMutableArray *)tweetsWithArray:(NSArray *)array;

@end
