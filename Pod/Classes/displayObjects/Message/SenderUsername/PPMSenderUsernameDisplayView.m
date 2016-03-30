//
//  PPMSenderUsernameDisplayView.m
//  PPChatViewController
//
//  Created by Alex Padalko on 3/25/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMSenderUsernameDisplayView.h"
@interface PPMSenderUsernameDisplayView ()
@property (nonatomic,retain)UIButton * usernameButton;
@end
@implementation PPMSenderUsernameDisplayView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.usernameButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.usernameButton addTarget:self action:@selector(onUsernameButton) forControlEvents:UIControlEventTouchUpInside];
        [self.usernameButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.usernameButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self addSubview:self.usernameButton];
    }
    return self;
}
-(void)setSenderUsername:(NSString *)senderUsername{
    _senderUsername=senderUsername;
    
   _senderUsername = [senderUsername hasPrefix:@"@"]?senderUsername:[NSString stringWithFormat:@"@%@",senderUsername];
    
    [self.usernameButton setTitle:_senderUsername forState:UIControlStateNormal];
}
-(void)onUsernameButton{
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.usernameButton setFrame:self.bounds];
}
@end
