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

#import "PPMessengerTextHelper.h"

#import "PPMMessageTextContentDisplayView.h"
////groups



////

@interface PPMMessageDisplayObject ()

@property (nonatomic,retain)NSMutableArray* selectionsArray;
@property (nonatomic,retain)NSMutableAttributedString * attrTextContent;

@end

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
    
    

    
    
    *indifiter=@"ppm_textmessage_i";
    *displayViewClass=[PPMMessageTextContentDisplayView class];
    
    *configurateBlock=^(PPMMessageTextContentDisplayView * viewToConfigurate){
        
        
        [viewToConfigurate setTextContent:self.attrTextContent];
        
        
    };
    
//    displayViewClass=[ppmessa]
    
}


#pragma mark - setup

-(UIEdgeInsets)ppm_globalInsets{
    
    return UIEdgeInsetsMake(0, 50, 5, 5);
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
   
    [group setPpm_header:senderUsername];
    
    return group;
    
}
-(NSString *)ppm_groupBy{
    return [self.message fromUserUserId];
}

#pragma mark else

-(CGSize)ppm_calculateContentSizeInBackgroundAvailableOnSize:(CGSize)size{
    
    
    
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:[self.message textContent] attributes:@{NSForegroundColorAttributeName:[self textColor],NSFontAttributeName:[self textFont]}];
    self.selectionsArray=[[NSMutableArray alloc] init];
    
      [self.selectionsArray addObjectsFromArray:[attrStr ppm_findAndSelect:@"@" color:[self soemthingColor] font:[self soemthingFont] removeFinder:NO]];
      [self.selectionsArray addObjectsFromArray:[attrStr ppm_findAndSelect:@"#" color:[self soemthingColor] font:[self soemthingFont] removeFinder:NO]];
      [self.selectionsArray addObjectsFromArray:[attrStr ppm_findAndSelect:@"http" color:[self soemthingColor] font:[self soemthingFont] removeFinder:NO]];
  
    self.attrTextContent=attrStr;
    CGSize r =[attrStr ppm_sizeOfStringWithAvailableSize:size];
    return r;
    
}


-(NSString *)ppm_type{
    return [self.message isSendedFromCurrentUser]?PPMessengerCurrentUserBubble:PPMessengerOtherUserBubble;
}


#pragma mark - ui stuf

-(UIColor*)textColor{
    
    return [UIColor blackColor];
    
}
-(UIFont*)textFont{
    
    return [UIFont systemFontOfSize:15];
    
}
-(UIFont*)soemthingFont{
    
    return [UIFont boldSystemFontOfSize:15];
}
-(UIColor*)soemthingColor{
    
    return [UIColor blueColor];
}
@end
