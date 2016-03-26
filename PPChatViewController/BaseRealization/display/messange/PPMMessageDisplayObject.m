//
//  PPMMessageDisplayObject.m
//  PPChatViewController
//
//  Created by Alex Padalko on 3/25/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMMessageDisplayObject.h"
////groups

#import "PPMCurrentUserMessagesGroup.h"
#import "PPMOtherUserMessagesGroup.h"

////
@implementation PPMMessageDisplayObject
+(NSArray *)createWithMessages:(NSArray *)messages{
    NSMutableArray * resultArray =[[NSMutableArray alloc] init];
    for (id<PPMMessageProt> message in messages) {
        
        [resultArray addObject:[[self alloc] initWithMessage:message]];
    }
    
    return resultArray;
    
}
-(instancetype)initWithMessage:(id<PPMMessageProt>)message{
    
    if (self=[super init]) {
        self.message=message;
    }
    return self;
    
}

#pragma mark - <PPMessengerContentDisplayObjectProt>


#pragma mark group


-(id<PPMessengerContentDisplayGroupProt>)ppm_generateGroupWithGroupIndex:(NSInteger)groupIndex{
    
    if ([[self message] isSendedFromCurrentUser]) {
        
        
        return [[PPMCurrentUserMessagesGroup alloc] initWithUserId:[self.message fromUserUserId] username:[self.message fromUserUsername] userProfilePictureUrlStr:[self.message fromUserProfilePictureUrlStr] andIndex:groupIndex];
    }else{
        
        return [[PPMOtherUserMessagesGroup alloc] initWithUserId:[self.message fromUserUserId] username:[self.message fromUserUsername] userProfilePictureUrlStr:[self.message fromUserProfilePictureUrlStr] andIndex:groupIndex];
    }
    
}
-(NSString *)ppm_groupBy{
    return [self.message fromUserUserId];
}

#pragma mark else

-(CGSize)ppm_calculateContentSizeInBackgroundOnSize:(CGSize)size{
    
    CGSize r =CGSizeMake(size.width-arc4random()%30, 100-arc4random()%40);
    return r;
    
}

-(UIView*)ppm_displayview{
    return nil;
}
-(BOOL)ppm_allowToGroup{
    return YES;
}
-(NSString *)ppm_fromUserId{
    return [self.message fromUserUserId];
}
-(NSString *)ppm_fromUserUsername{
    
    return [self.message fromUserUsername];
}


-(NSString *)ppm_type{
    return [self.message isSendedFromCurrentUser]?PPMessengerCurrentUserBubble:PPMessengerOtherUserBubble;
}
-(NSString*)ppm_groupType{
    return [self.message isSendedFromCurrentUser]?PPMessengerOtherUserMessagesGroup:PPMessengerOtherUserBubble;
}
@end
