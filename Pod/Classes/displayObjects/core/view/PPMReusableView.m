//
//  PPMReusableView.m
//  PPChatViewController
//
//  Created by Alex Padalko on 3/25/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMReusableView.h"

@implementation PPMReusableView
@synthesize displayView=_displayView;
@synthesize contentInsets=_contentInsets;

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame: frame]) {
        [self setBackgroundColor:[UIColor purpleColor]];
    }
    return self;
}

-(void)setDisplayView:(UIView *)displayView{
    
    if (_displayView) {
        [_displayView removeFromSuperview];
    }
    
    _displayView=displayView;
    
    [self addSubview:_displayView];
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [_displayView setFrame:UIEdgeInsetsInsetRect(self.bounds, self.contentInsets)];
}
@end
