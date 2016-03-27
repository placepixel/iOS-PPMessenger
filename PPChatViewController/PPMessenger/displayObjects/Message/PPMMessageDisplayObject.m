//
//  PPMMessageDisplayObject.m
//  PPChatViewController
//
//  Created by Alex Padalko on 3/25/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMMessageDisplayObject.h"

#import "PPMSenderUsernameDisplayObject.h"
#import "PPMSenderProfilePictureDisplayObject.h"
////groups



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

-(void)ppm_generateDisplayViewClass:(Class*)displayViewClass andIndifiter:(NSString**)indifiter andConfigurateBlock:(PPMessengerContentConfigurationBlock*)configurateBlock{
    
//    displayViewClass=[ppmessa]
    
}


#pragma mark - setup

-(UIEdgeInsets)ppm_globalInsets{
    
    return UIEdgeInsetsMake(5, 50, 5, 5);
}
-(UIEdgeInsets)ppm_contentInsets{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark group

-(id<PPMessengerContentDisplayGroupProt>)ppm_generateGroupWithGroupIndex:(NSInteger)groupIndex{
    
    id<PPMessengerContentDisplayGroupProt> group = [super ppm_generateGroupWithGroupIndex:groupIndex];
    
    PPMSenderProfilePictureDisplayObject * senderProf = [[PPMSenderProfilePictureDisplayObject alloc] init];
    [senderProf setProfilePictureUrl:[self.message fromUserProfilePictureUrlStr]];
    [group addDynamicItem:senderProf forType:PPMDisplayLayoutTypeHeader];
    
    
    PPMSenderUsernameDisplayObject * senderUsername = [[PPMSenderUsernameDisplayObject alloc] init];
    [senderUsername setSenderUsername:[self.message fromUserUsername]];
    [group addItemToGroup:senderUsername];
    
    return group;
    
}
-(NSString *)ppm_groupBy{
    return [self.message textContent];
}

#pragma mark else

-(CGSize)ppm_calculateContentSizeInBackgroundAvailableOnSize:(CGSize)size{
    
    CGSize r =CGSizeMake(size.width-arc4random()%30, 100-arc4random()%40);
    return r;
    
}


-(NSString *)ppm_type{
    return [self.message isSendedFromCurrentUser]?PPMessengerCurrentUserBubble:PPMessengerOtherUserBubble;
}

@end
