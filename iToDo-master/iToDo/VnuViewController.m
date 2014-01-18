//
//  VnuViewController.m
//  iToDo
//
//  Created by Vinu Charanya on 10/16/13.
//  Copyright (c) 2013 vnu. All rights reserved.
//

#import "VnuViewController.h"
#import "VnuToDoItem.h"
#import "VnuTableViewCell.h"

@interface VnuViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property(nonatomic,strong) NSMutableArray* _toDoItems;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
@end

@implementation VnuViewController

//An Array of ToDo Items
NSMutableArray* _toDoItems;
// the offset applied to cells when entering “edit mode”
float _editingOffset;

- (void)viewDidLoad
{
    [super viewDidLoad];
    _toDoItems = [[NSMutableArray alloc] init];
    [self createDummy];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor blackColor];
    [self.tableView registerClass:[VnuTableViewCell class] forCellReuseIdentifier:@"cell"];


}


- (IBAction)addToDo: (id)sender {
    [_toDoItems insertObject:[VnuToDoItem toDoItemWithText:@""] atIndex:0];
    
    [self.tableView reloadData];
    
}
- (IBAction)editToDo: (UIBarButtonItem *)sender {
    if ([self isEditing]) {
        sender.title = @"Edit";
        self.addButton.enabled = TRUE;
        [self setEditing:FALSE animated:FALSE];
    } else {
        sender.title = @"Done";
        self.addButton.enabled = FALSE;
        [self setEditing:TRUE animated:TRUE];
    }

}

- (void)setEditing:(BOOL)editing animated:(BOOL)animate {
    [super setEditing:editing animated:animate];
    [self.tableView setEditing:editing animated:animate];
}


//Initial Dummy Data
-(void) createDummy{
    [_toDoItems addObject:[VnuToDoItem toDoItemWithText:@"Seven Habits of Highly Effective People"]];
    [_toDoItems addObject:[VnuToDoItem toDoItemWithText:@"Be Proactive"]];
    [_toDoItems addObject:[VnuToDoItem toDoItemWithText:@"Begin with the end in mind"]];
    [_toDoItems addObject:[VnuToDoItem toDoItemWithText:@"First Things First"]];
    [_toDoItems addObject:[VnuToDoItem toDoItemWithText:@"Think Win-Win"]];
    [_toDoItems addObject:[VnuToDoItem toDoItemWithText:@"Seek First to Understand"]];
    [_toDoItems addObject:[VnuToDoItem toDoItemWithText:@"Then to be Understood"]];
    [_toDoItems addObject:[VnuToDoItem toDoItemWithText:@"Synergize"]];
    [_toDoItems addObject:[VnuToDoItem toDoItemWithText:@"Sharpen the saw"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - SHCTableViewDataSource methods
-(NSInteger)numberOfRows {
    return _toDoItems.count;
}

-(UITableViewCell *)cellForRow:(NSInteger)row {
    NSString *ident = @"cell";
    VnuTableViewCell *cell = [[VnuTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:ident];
    VnuToDoItem *item = _toDoItems[row];
    cell.todoItem = item;
    cell.delegate = self;
    cell.backgroundColor = [self colorForIndex:row];
    return cell;
}

#pragma mark - UITableViewDataSource protocol methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _toDoItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ident = @"cell";
    // re-use or create a cell
    VnuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident forIndexPath:indexPath];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    // find the to-do item for this index
    int index = [indexPath row];
    
    VnuToDoItem *item = _toDoItems[index];

    // set the text
//    cell.textLabel.text = item.text;
    
    cell.delegate = self;
    cell.todoItem = item;
    return cell;
}

#pragma mark - VnuTableViewCellDelegate protocol methods
-(void)toDoItemDeleted:(id)todoItem {
    // use the UITableView to animate the removal of this row
    NSUInteger index = [_toDoItems indexOfObject:todoItem];
    [self.tableView beginUpdates];
    [_toDoItems removeObject:todoItem];
    [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]
                          withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

//Set the color for the index
-(UIColor*)colorForIndex:(NSInteger) index {
    NSUInteger itemCount = _toDoItems.count - 1;
    float val = ((float)index / (float)itemCount) * 0.6;
    return [UIColor colorWithRed: 1.0 green:val blue: 0.0 alpha:1.0];
}

//To set the height of each cell
#pragma mark - UITableViewDataDelegate protocol methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(VnuTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [self colorForIndex:indexPath.row];
}

-(void)cellDidBeginEditing:(VnuTableViewCell *)editingCell {
//    _editingOffset = _tableView.scrollView.contentOffset.y - editingCell.frame.origin.y;
    for(VnuTableViewCell* cell in [_tableView visibleCells]) {
        [UIView animateWithDuration:0.3
                         animations:^{
                             cell.frame = CGRectOffset(cell.frame, 0, _editingOffset);
                             if (cell != editingCell) {
                                 cell.alpha = 0.3;
                             }
                         }];
    }
}

-(void)cellDidEndEditing:(VnuTableViewCell *)editingCell {
    for(VnuTableViewCell* cell in [_tableView visibleCells]) {
        [UIView animateWithDuration:0.3
                         animations:^{
                             cell.frame = CGRectOffset(cell.frame, 0, -_editingOffset);
                             if (cell != editingCell)
                             {
                                 cell.alpha = 1.0;
                             }
                         }];
    }
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [_toDoItems removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)newIndexPath{
    
    UITextField* field =  (UITextField *) [tableView viewWithTag: newIndexPath.row];
    
    [field becomeFirstResponder];
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSObject *task = _toDoItems[fromIndexPath.row];
    [_toDoItems removeObjectAtIndex:fromIndexPath.row];
    [_toDoItems insertObject:task atIndex:toIndexPath.row];
    
    [tableView reloadData];
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

//Edit Actions




@end
