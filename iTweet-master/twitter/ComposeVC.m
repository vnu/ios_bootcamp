//
//  ComposeVC.m
//  twitter
//
//  Created by Vinu Charanya on 10/23/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "ComposeVC.h"
#import "TwitterClient.h"
#import <UIImageView+AFNetworking.h>

@interface ComposeVC ()

@property (weak, nonatomic) IBOutlet UITextView *composeText;

@end

@implementation ComposeVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.composeText becomeFirstResponder];
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(onCloseButton)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onTweetButton)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)onCloseButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onCancelButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onTweetButton {
    [[TwitterClient instance] tweet:self.composeText.text inReplyToTweetID:self.rTweetID
                            success:^(AFHTTPRequestOperation *operation, id response) {
                                NSLog(@"Tweet sent!");
                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                NSLog(@"%@", error);
                            }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
