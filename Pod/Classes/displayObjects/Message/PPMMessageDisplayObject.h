//
//  PPMMessageDisplayObject.h
//  PPChatViewController
//
//  Created by Alex Padalko on 3/25/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMContentDisplayObject.h"
#import "PPMMessageProt.h"
@interface PPMMessageDisplayObject : PPMContentDisplayObject
+(NSArray*)createWithMessages:(NSArray*)messages;
-(instancetype)initWithMessage:(id<PPMMessageProt>)message;

@property (nonatomic,retain)id<PPMMessageProt>message;


@end
