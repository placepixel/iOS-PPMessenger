//
//  PPChatContentObjectProt.h
//  PPChatViewController
//
//  Created by Alex Padalko on 3/22/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPMessengerDefaults.h"
#import "PPMessengerConstructionProt.h"
@protocol PPMessengerContentDisplayGroupProt;
@protocol PPMessengerContentDisplayObjectProt <NSObject>



-(id<PPMessengerContentDisplayGroupProt>)ppm_generateGroupWithGroupIndex:(NSInteger)groupIndex;

-(CGSize)ppm_calculateContentSizeInBackgroundOnSize:(CGSize)size;
-(UICollectionViewLayoutAttributes*)ppm_calculateInBackgroundOnSize:(CGSize)size constructor:(id<PPMessengerConstructionProt>)constructor withY:(float)y andIndexPath:(NSIndexPath*)indexPath;
@property (nonatomic,retain)UIView * ppm_displayContentView;
@property (nonatomic,retain)UICollectionViewLayoutAttributes* ppm_layoutAttributes;
@property (nonatomic)CGSize  ppm_contentSize;
@property (nonatomic)UIEdgeInsets ppm_contentInsets;

-(NSString*)ppm_type;
-(NSString*)ppm_groupBy;

//@property (nonatomic)

//-(NSString*)ppm_fromUserId;
//-(NSString*)ppm_fromUserUsername;

//-(NSString*)ppm_groupType;


@end



@protocol PPMessengerContentDisplayGroupProt <NSObject>
//@property (nonatomic,retain)SEL ppm_groupBySelector;

-(instancetype)initWithGroupIndif:(NSString*)groupIndif andGroupIndex:(NSInteger)index;

@property (nonatomic)NSInteger groupIndex;

-(void)addDynamicItem:(id<PPMessengerContentDisplayObjectProt>)dynamicItem forType:(PPMDisplayLayoutType)layotType;
-(void)addItemToGroup:(id<PPMessengerContentDisplayObjectProt>)contentDispObject;

-(NSInteger)numberOfItemsInGroup;
-(id<PPMessengerContentDisplayObjectProt>)dispObjectForIndex:(NSInteger)index;
-(NSArray*)ppm_getAllLayouts;
-(void)ppm_updateGroupWithOffset:(float)offset;

@property (nonatomic)CGRect ppm_groupFrame;
@property (nonatomic,retain)NSString * ppm_groupIndif;


-(float)ppm_getMaxY;

@end