//
//  PPMessengerInputAccessoryView.h
//  PPChatViewController
//
//  Created by Alex Padalko on 3/23/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPMessengerInputAccessoryViewProt.h"
@class PPMessengerInputAccessoryView;
@protocol PPMessengerInputAccessoryViewDelegate <NSObject>

-(void)ppmiav_accessoryView:(PPMessengerInputAccessoryView*)inputAccessoryView wantsToSendText:(NSString*)text shouldClean:(BOOL*)shouldClean shouldResingResponder:(BOOL*)resignResponder;

@end

@interface PPMessengerInputAccessoryView : UIView <PPMessengerInputAccessoryViewProt,UITextViewDelegate>
@property (nonatomic)UIEdgeInsets textViewInstets;
@property (nonatomic)UIFont * textViewFont;

@property (weak,nonatomic)id<PPMessengerInputAccessoryViewDelegate> delegate;

@end
