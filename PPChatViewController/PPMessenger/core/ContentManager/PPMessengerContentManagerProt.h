//
//  PPMessengerContentConstructorProt.h
//  PPChatViewController
//
//  Created by Alex Padalko on 3/23/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPMessengerContentDisplayObjectProt.h"
#import "PPMessengerConstructionProt.h"
@protocol PPMessengerContentManagerDelegate <NSObject>

-(CGSize)ppmcm_getSize;
-(id<PPMessengerConstructionProt>)ppmcm_getConstructorForType:(NSString*)type;
-(CGSize)ppmcm_getContentAvailableSizeForType:(NSString*)type;
@end

@protocol PPMessengerContentManagerProt <NSObject>

@property (weak,nonatomic)id<PPMessengerContentManagerDelegate>delegate;

@property (nonatomic,retain)NSMutableArray * ppm_items;
@property (nonatomic)float ppm_currentWidth;
-(void)workWithNewItems:(NSArray<PPMessengerContentDisplayObjectProt>*)newObjects complititionBlock:(void(^)(NSArray*result))complitBlock;

-(NSInteger)ppm_numberOfGroups;
-(NSInteger)ppm_numberItemsInGroupAtIndex:(NSInteger)index;
-(id<PPMessengerContentDisplayGroupProt>)ppm_groupAtIndex:(NSInteger)index;
-(id<PPMessengerContentDisplayObjectProt>)ppm_displayObjectAtIndexPath:(NSIndexPath*)ip;

@property (nonatomic)float ppm_totalH;

@end
