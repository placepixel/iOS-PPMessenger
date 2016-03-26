//
//  PPChatInptutViewController.m
//  PPChatViewController
//
//  Created by Alex Padalko on 3/22/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPChatInptutViewController.h"
@interface PPChatInptutViewController ()



@end
@implementation PPChatInptutViewController
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.inputTextView=[[UITextView alloc] init];
        
        [self.view addSubview:self.inputTextView];
        
//        [self.inputTextView setInputView:self.view];
    }
    return self;
}
-(UIView *)view{
    return self;
}
-(void)viewDidLoad{
//    [super viewDidLoad];
    
   
}
-(void)layoutSubviews{
    [super layoutSubviews];
        [self.inputTextView setFrame:self.view.bounds];
}
//-(void)viewDidLayoutSubviews{
//    [super viewDidLayoutSubviews];
//    [self.inputTextView setFrame:self.view.bounds];
//}

@end
