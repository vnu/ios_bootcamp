//
//  VnuTableViewCell.h
//  iToDo
//
//  Created by Vinu Charanya on 10/17/13.
//  Copyright (c) 2013 vnu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VnuToDoItem.h"
#import "VnuTableViewCellDelegate.h"

@interface VnuTableViewCell : UITableViewCell <UITextFieldDelegate>

// The item that this cell renders.
@property (nonatomic) VnuToDoItem *todoItem;

// The object that acts as delegate for this cell.
@property (nonatomic, assign) id<VnuTableViewCellDelegate> delegate;


@end
