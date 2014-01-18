//
//  VnuTableViewCell.m
//  iToDo
//
//  Created by Vinu Charanya on 10/17/13.
//  Copyright (c) 2013 vnu. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "VnuTableViewCell.h"
#import "VnuToDoLabel.h"

@implementation VnuTableViewCell{

CAGradientLayer* _gradientLayer;
CGPoint _originalCenter;
BOOL _deleteOnDragRelease;
BOOL _markCompleteOnDragRelease;
VnuToDoLabel *_label;
CALayer *_itemCompleteLayer;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // add a layer that overlays the cell adding a subtle gradient effect
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = self.bounds;
        _gradientLayer.colors = @[(id)[[UIColor colorWithWhite:1.0f alpha:0.2f] CGColor],
                                  (id)[[UIColor colorWithWhite:1.0f alpha:0.1f] CGColor],
                                  (id)[[UIColor clearColor] CGColor],
                                  (id)[[UIColor colorWithWhite:0.0f alpha:0.1f] CGColor]];
        _gradientLayer.locations = @[@0.00f, @0.01f, @0.95f, @1.00f];
        [self.layer insertSublayer:_gradientLayer atIndex:0];
        

        _label = [[VnuToDoLabel alloc] initWithFrame:CGRectNull];
        _label.delegate = self;
        _label.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont boldSystemFontOfSize:16];
        _label.backgroundColor = [UIColor clearColor];
        [self addSubview:_label];
        // remove the default blue highlight for selected cells
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        // add a layer that renders a green background when an item is complete
        
        _itemCompleteLayer = [CALayer layer];
        _itemCompleteLayer.backgroundColor = [[[UIColor alloc] initWithRed:0.0 green:0.6 blue:0.0 alpha:1.0] CGColor];
        _itemCompleteLayer.hidden = YES;
        [self.layer insertSublayer:_itemCompleteLayer atIndex:0];
        
        UIGestureRecognizer* recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        recognizer.delegate = self;
        [self addGestureRecognizer:recognizer];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

const float LABEL_LEFT_MARGIN = 50.0f;

-(void)layoutSubviews {
    [super layoutSubviews];
    // ensure the gradient layers occupies the full bounds
    _gradientLayer.frame = self.bounds;
    _itemCompleteLayer.frame = self.bounds;
    _label.frame = CGRectMake(LABEL_LEFT_MARGIN, 0,
                              self.bounds.size.width - LABEL_LEFT_MARGIN,self.bounds.size.height);
}

-(void)setTodoItem:(VnuToDoItem *)todoItem {
    _todoItem = todoItem;
    // we must update all the visual state associated with the model item
    _label.text = todoItem.text;
//    _label.textAlignment = NSTextAlignmentCenter;
    if([_label.text  isEqual: @""]){
        _label.placeholder = @"Add ToDo Item";
    }
    
    _label.strikethrough = todoItem.completed;
    _itemCompleteLayer.hidden = !todoItem.completed;
}

#pragma mark - horizontal pan gesture methods
-(BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:[self superview]];
    // Check for horizontal gesture
    if (fabsf(translation.x) > fabsf(translation.y)) {
        return YES;
    }
    return NO;
}

-(void)handlePan:(UIPanGestureRecognizer *)recognizer {
    // 1
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        // if the gesture has just started, record the current centre location
        _originalCenter = self.center;
    }
    
    // 2
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        // translate the center
        CGPoint translation = [recognizer translationInView:self];
        self.center = CGPointMake(_originalCenter.x + translation.x, _originalCenter.y);
        // determine whether the item has been dragged far enough to initiate a delete / complete
        _deleteOnDragRelease = self.frame.origin.x < -self.frame.size.width / 2;
        _markCompleteOnDragRelease = self.frame.origin.x > self.frame.size.width / 2;
        
    }
    
    // 3
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        // the frame this cell would have had before being dragged
        CGRect originalFrame = CGRectMake(0, self.frame.origin.y,
                                          self.bounds.size.width, self.bounds.size.height);
        if (!_deleteOnDragRelease) {
            // if the item is not being deleted, snap back to the original location
            [UIView animateWithDuration:0.2
                             animations:^{
                                 self.frame = originalFrame;
                             }
             ];
        }
        if (_deleteOnDragRelease) {
            // notify the delegate that this item should be deleted
            [self.delegate toDoItemDeleted:self.todoItem];
        }
        if (_markCompleteOnDragRelease) {
            // mark the item as complete and update the UI state
            self.todoItem.completed = YES;
            _itemCompleteLayer.hidden = NO;
            _label.strikethrough = YES;
        }
    }
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    // close the keyboard on enter
    [textField resignFirstResponder];
    return NO;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    // disable editing of completed to-do items
    return !self.todoItem.completed;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [self.delegate cellDidEndEditing:self];
    if([textField.text  isEqual: @""]){
        _label.placeholder = @"Add ToDo Item";
    }else{
    self.todoItem.text = textField.text;
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.delegate cellDidBeginEditing:self];
}
@end
