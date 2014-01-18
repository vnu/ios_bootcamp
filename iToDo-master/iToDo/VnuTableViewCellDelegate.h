//
//  VnuTableViewCellDelegate.h
//  iToDo
//
//  Created by Vinu Charanya on 10/17/13.
//  Copyright (c) 2013 vnu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VnuToDoItem.h"

@class VnuTableViewCell;

@protocol VnuTableViewCellDelegate <NSObject>

// indicates that the given item has been deleted
-(void) toDoItemDeleted:(VnuToDoItem*)todoItem;

// Indicates that the edit process has begun for the given cell
-(void)cellDidBeginEditing:(VnuTableViewCell*)cell;

// Indicates that the edit process has committed for the given cell
-(void)cellDidEndEditing:(VnuTableViewCell*)cell;

@end
