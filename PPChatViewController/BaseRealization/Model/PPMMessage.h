//
//  PPMMessage.h
//  PPChatViewController
//
//  Created by Alex Padalko on 3/25/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PPMMessageProt.h"
#import <MJExtension/MJExtension.h>
@interface PPMMessage : NSObject <PPMMessageProt>

+(instancetype)createTextMessageWithContent:(NSString*)content;


+(NSArray*)createWithDataArray:(NSArray*)dataArray;
+(instancetype)createWithData:(NSDictionary*)data;

@property (nonatomic,retain)NSString * fromUserUsername;
@property (nonatomic,retain)NSString * fromUserUserId;
@property (nonatomic,retain)NSString * fromUserProfilePictureUrlStr;
@property (nonatomic,retain)NSString * textContent;
@property (nonatomic,retain)NSNumber * mediaType;
@property (nonatomic,retain)NSString * mediaContentUrlStr;
@property (nonatomic,retain)NSDate* createdAt;

@end
