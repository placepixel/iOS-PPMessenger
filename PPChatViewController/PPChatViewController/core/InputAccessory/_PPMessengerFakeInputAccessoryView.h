//
//  _PPChatFakeInputAccessoryView.h
//  PPChatViewController
//
//  Created by Alex Padalko on 3/22/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <UIKit/UIKit.h>
@class _PPMessengerFakeInputAccessoryView;
@protocol _PPMessengerFakeInputAccessoryViewDelegate <NSObject>
-(void)_ppm_fakeInput:(_PPMessengerFakeInputAccessoryView*)fakeInput superViewDidChangeFrame:(CGRect)newFrame;
@end
@interface _PPMessengerFakeInputAccessoryView : UIView
@property (weak,nonatomic)UIView * realInputView;
-(instancetype)initWithDelegate:(id<_PPMessengerFakeInputAccessoryViewDelegate>)delegate;
@property (nonatomic,weak)id<_PPMessengerFakeInputAccessoryViewDelegate> delegate;
@end
