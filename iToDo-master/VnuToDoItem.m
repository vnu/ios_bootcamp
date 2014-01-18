//
//  VnuToDoItem.m
//  iToDo
//
//  Created by Vinu Charanya on 10/16/13.
//  Copyright (c) 2013 vnu. All rights reserved.
//

#import "VnuToDoItem.h"

@implementation VnuToDoItem

-(id)initWithText:(NSString*)text {
    if (self = [super init]) {
        self.text = text;
    }
    return self;
}

+(id)toDoItemWithText:(NSString *)text {
    return [[VnuToDoItem alloc] initWithText:text];
}

@end
