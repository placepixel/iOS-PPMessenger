
//
//  PPMMessage.m
//  PPChatViewController
//
//  Created by Alex Padalko on 3/25/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMMessage.h"
#import "PPMUserData.h"
@implementation PPMMessage

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    if (property.type.typeClass == [NSDate class]) {
        
        if ([oldValue isKindOfClass:[NSNumber class]]) {
            return [NSDate dateWithTimeIntervalSince1970:[oldValue integerValue]];
        }
    }
    
    return oldValue;
}
+(instancetype)createWithData:(NSDictionary *)data{
    return [self mj_objectWithKeyValues:data];
}

+(NSArray *)createWithDataArray:(NSArray *)dataArray{
    
    NSMutableArray * resuktArr =[[NSMutableArray alloc] init];
    
    
    for (NSDictionary * d  in dataArray) {
        [resuktArr addObject:[self createWithData:d]];
    }
    
    return resuktArr;
    
}

+(instancetype)createTextMessageWithContent:(NSString *)content{
    
    PPMMessage * message = [self alloc];
    
    [message setTextContent:content];
    [message setFromUserUserId:[[PPMUserData sharedInstance] userId]];
    [message setFromUserUsername:[[PPMUserData sharedInstance] username]];
    [message setFromUserProfilePictureUrlStr:[[PPMUserData sharedInstance] profilePictureUrlStr]];
    [message setMediaType:@(PPMMessageMediaTypeNone)];
    [message setCreatedAt:[NSDate date]];
    return message;
    
}


-(PPMMessageMediaType)mediaTypeIntgr{
    return [self.mediaType integerValue];
}


-(NSDictionary *)dictionaryRepresentation{
    
;
    NSMutableDictionary *  d=  [self mj_keyValues];
    [d setValue:    @([@([self.createdAt timeIntervalSince1970]) integerValue]) forKey:@".priority"];
    [d setValue:    @([@([self.createdAt timeIntervalSince1970]) integerValue]) forKey:@"createdAt"];
    return d;
}
-(BOOL)isSendedFromCurrentUser{
    return NO;
}

- (NSComparisonResult)dateDscCompare:(id<PPMMessageProt>)otherMessage{
     return [[self createdAt] compare:otherMessage.createdAt];
   
}
- (NSComparisonResult)dateAscCompare:(id<PPMMessageProt>)otherMessage{
  return [[otherMessage createdAt] compare:self.createdAt];
}
@end
