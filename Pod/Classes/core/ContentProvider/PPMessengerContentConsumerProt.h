//
//  PPMessengerContentConsumerProt.h
//  PPChatViewController
//
//  Created by Alex Padalko on 3/25/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PPMessengerContentConsumerProt <NSObject>
-(void)ppm_shoudSendTextMessageWithText:(NSString*)text;
@end
