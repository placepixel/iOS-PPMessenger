//
//  PPMGroup.h
//  PPChatViewController
//
//  Created by Alex Padalko on 3/24/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPMessengerContentDisplayObjectProt.h"
@interface PPMGroup : NSObject <PPMessengerContentDisplayGroupProt>
@property (nonatomic,retain)NSMutableArray <PPMessengerContentDisplayObjectProt>*ppm_items;
@property (nonatomic,retain)NSMutableArray <PPMessengerContentDisplayObjectProt>*ppm_dynamic_items;
@end
