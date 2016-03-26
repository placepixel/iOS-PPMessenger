//
//  PPMCurrentUserBubbleConstructor.m
//  PPChatViewController
//
//  Created by Alex Padalko on 3/24/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMCurrentUserBubbleConstructor.h"

@implementation PPMCurrentUserBubbleConstructor
-(NSString *)ppm_groupType{
    return PPMessengerCurrentUserMessagesGroup;
}
-(NSString *)ppm_type{
    return PPMessengerCurrentUserBubble;
}
@end
