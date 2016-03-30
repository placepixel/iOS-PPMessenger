//
//  PPMMessageProt.h
//  PPChatViewController
//
//  Created by Alex Padalko on 3/25/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM (NSInteger , PPMMessageMediaType){
    
    
    PPMMessageMediaTypeNone,
    PPMMessageMediaTypeImage,
    PPMMessageMediaTypeVideo,
    PPMMessageMediaTypeShortVideo
    
};
@protocol PPMMessageProt <NSObject>
-(NSString*)fromUserUsername;
-(NSString*)fromUserUserId;
-(NSString*)fromUserProfilePictureUrlStr;
-(NSString*)textContent;
-(PPMMessageMediaType)mediaTypeIntgr;
-(NSString*)mediaContentUrlStr;

-(NSDictionary*)dictionaryRepresentation;
-(NSDate*)createdAt;

-(BOOL)isSendedFromCurrentUser;

- (NSComparisonResult)dateDscCompare:(id<PPMMessageProt>)otherMessage;
-(NSComparisonResult)dateAscCompare:(id<PPMMessageProt>)otherMessage;
@end
