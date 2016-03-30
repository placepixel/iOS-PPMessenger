//
//  PPChatInputAccessoryViewProt.h
//  PPChatViewController
//
//  Created by Alex Padalko on 3/22/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPMessengerInputAccessoryViewObserver.h"
@protocol PPMessengerInputAccessoryViewProt <NSObject>

-(instancetype)initWithHeight:(float)height andObserver:(id<PPMessengerInputAccessoryViewObserver>)observer;

@property (nonatomic,weak)id<PPMessengerInputAccessoryViewObserver>ppm_observer;
@property (nonatomic,retain)UITextView * ppm_inputTextView;

-(float)ppm_height;

@end
