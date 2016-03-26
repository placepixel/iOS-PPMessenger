//
//  PPMessengerChatBubbleCell.m
//  PPChatViewController
//
//  Created by Alex Padalko on 3/24/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMessengerBubbleReusableView.h"

@implementation PPMessengerBubbleReusableView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor orangeColor]];
    }
    return self;
}
@end
