//
//  VnuToDoItem.h
//  iToDo
//
//  Created by Vinu Charanya on 10/16/13.
//  Copyright (c) 2013 vnu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VnuToDoItem : NSObject

// A text description of this item.
@property (nonatomic, copy) NSString *text;

// A Boolean value that determines the completed state of this item.
@property (nonatomic) BOOL completed;

// Returns an VnuToDoItem item initialized with the given text.
-(id)initWithText:(NSString*)text;

// Returns an VnuToDoItem item initialized with the given text.
+(id)toDoItemWithText:(NSString*)text;

@end
