//
//  TweetVC.m
//  twitter
//
//  Created by Vinu Charanya on 10/23/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TweetVC.h"
#import "ComposeVC.h"
#import "UIIMageView+AFNetworking.h"

@interface TweetVC ()
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (nonatomic, weak) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *createdAt;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;

- (IBAction)onReply:(id)sender;
- (IBAction)retweet:(id)sender;
- (IBAction)favorite:(id)sender;
@end

@implementation TweetVC


- (id)initWithTweet:(Tweet *)tweet
{
    self = [super init];
    
    if (self) {
        self.title = @"Tweet";
        self.tweet = tweet;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tweetText.text = self.tweet.tweetText;
    self.nameLabel.text = self.tweet.name;
    self.screenName.text = self.tweet.screenName;
    self.createdAt.text = self.tweet.timeAgo;
    NSURL *imageURL = [NSURL URLWithString:self.tweet.profileImage];
    if (imageURL) {
        [self.profilePic setImageWithURL:imageURL];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onReply:(id)sender {
    NSLog(@"onReply");
    ComposeVC *composeVC = [[ComposeVC alloc] init];
    composeVC.rTweetID = self.tweet.tweetID;

    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:composeVC];
    [self presentViewController:navigationController animated:YES completion:nil];
}
//
- (IBAction)retweet:(id)sender {
    NSLog(@"retweet");
    [[TwitterClient instance] retweetWithTweetId:self.tweet.tweetID success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"Retweet Success!");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Retweet Error! Error: %@", error);
    }];
}
//
- (IBAction)favorite:(id)sender {
    NSLog(@"favorite");
    [[TwitterClient instance] favoriteWithTweetId:self.tweet.tweetID success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"fav Success!");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Favorite Error! Error: %@", error);
    }];
}

@end
