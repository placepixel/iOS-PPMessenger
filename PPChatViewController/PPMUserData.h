//
//  PPMUserData.h
//  PPChatViewController
//
//  Created by Alex Padalko on 3/25/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPMUserData : NSObject
+(instancetype)sharedInstance;

@property (nonatomic,retain)NSString * userId;
@property (nonatomic,retain)NSString * username;
@property (nonatomic,retain)NSString * profilePictureUrlStr;

@end
