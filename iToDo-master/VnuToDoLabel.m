//
//  VnuToDoLabel.m
//  iToDo
//
//  Created by Vinu Charanya on 10/17/13.
//  Copyright (c) 2013 vnu. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "VnuToDoLabel.h"

@implementation VnuToDoLabel {
    bool _strikethrough;
    CALayer* _strikethroughLayer;
}

const float STRIKEOUT_THICKNESS = 2.0f;

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _strikethroughLayer = [CALayer layer];
        _strikethroughLayer.backgroundColor = [[UIColor whiteColor] CGColor];
        _strikethroughLayer.hidden = YES;
        [self.layer addSublayer:_strikethroughLayer];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [self resizeStrikeThrough];
}

-(void)setText:(NSString *)text {
    [super setText:text];
    [self resizeStrikeThrough];
}

// resizes the strikethrough layer to match the current label text
-(void)resizeStrikeThrough {
    CGSize textSize = [self.text sizeWithFont:self.font];
    _strikethroughLayer.frame = CGRectMake(0, self.bounds.size.height/2,
                                           textSize.width, STRIKEOUT_THICKNESS);
}

#pragma mark - property setter
-(void)setStrikethrough:(bool)strikethrough {
    _strikethrough = strikethrough;
    _strikethroughLayer.hidden = !strikethrough;
}

@end
