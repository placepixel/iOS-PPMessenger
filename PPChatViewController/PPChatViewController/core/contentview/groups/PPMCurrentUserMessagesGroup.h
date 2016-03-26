//
//  PPMCurrentUserMessagesGroup.h
//  PPChatViewController
//
//  Created by Alex Padalko on 3/24/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMGroup.h"


@interface PPMCurrentUserMessagesGroup : PPMGroup

-(instancetype)initWithUserId:(NSString*)userId username:(NSString*)username userProfilePictureUrlStr:(NSString*)userprofilePictureUrlStr andIndex:(NSInteger)index;
@end
