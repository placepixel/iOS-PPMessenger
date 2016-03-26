//
//  PPMOtherUserMessagesGroup.m
//  PPChatViewController
//
//  Created by Alex Padalko on 3/24/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMOtherUserMessagesGroup.h"
#import "PPMSenderProfilePictureDisplayObject.h"
@implementation PPMOtherUserMessagesGroup

-(instancetype)initWithUserId:(NSString*)userId username:(NSString*)username userProfilePictureUrlStr:(NSString*)userprofilePictureUrlStr andIndex:(NSInteger)index{
    
    if (self=[super initWithUserId:userId username:username userProfilePictureUrlStr:userprofilePictureUrlStr andIndex:index]  ) {
        
        PPMSenderProfilePictureDisplayObject * sender = [[PPMSenderProfilePictureDisplayObject alloc] init];
        [self addItemToGroup:sender];
        [self addDynamicItem:sender forType:PPMDisplayLayoutTypeHeader];
        //        [self.ppm_items addObject:];
        
    }
    return self;
}

    


@end
