//
//  PPMessengerInputAccessoryViewObserver.h
//  PPChatViewController
//
//  Created by Alex Padalko on 3/23/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PPMessengerInputAccessoryViewProt;
@protocol PPMessengerInputAccessoryViewObserver <NSObject>

-(void)ppm_inputAccesoryView:(UIView<PPMessengerInputAccessoryViewProt>*)inputAccessoryView didChangeHeight:(float)newHeight;

@end
