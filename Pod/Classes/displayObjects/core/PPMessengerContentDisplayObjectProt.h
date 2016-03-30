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

typedef void (^ PPMessengerContentConfigurationBlock) (id viewToConfigurate);

@protocol PPMessengerContentDisplayGroupProt;
@protocol PPMessengerContentDisplayObjectProt <PPMessengerConstructionProt>



-(id<PPMessengerContentDisplayGroupProt>)ppm_generateGroupWithGroupIndex:(NSInteger)groupIndex;


-(CGSize)ppm_calculateContentSizeInBackgroundAvailableOnSize:(CGSize)size;
-(UICollectionViewLayoutAttributes*)ppm_calculateInBackgroundOnSize:(CGSize)size withY:(float)y andIndexPath:(NSIndexPath*)indexPath reversed:(BOOL)reversed;



-(void)ppm_generateDisplayViewClass:(Class*)displayViewClass andIndifiter:(NSString**)indifiter andConfigurateBlock:(PPMessengerContentConfigurationBlock*)configurateBlock;


@property (nonatomic,retain)UICollectionViewLayoutAttributes* ppm_layoutAttributes;
@property (nonatomic)CGSize  ppm_contentSize;
-(NSString*)ppm_groupBy;








@end



@protocol PPMessengerContentDisplayGroupProt <NSObject>
//@property (nonatomic,retain)SEL ppm_groupBySelector;

-(instancetype)initWithGroupIndif:(NSString*)groupIndif andGroupIndex:(NSInteger)index;
@property (nonatomic,retain)id<PPMessengerContentDisplayObjectProt> ppm_header;
@property (nonatomic)NSInteger groupIndex;

-(void)addDynamicItem:(id<PPMessengerContentDisplayObjectProt>)dynamicItem forType:(PPMDisplayLayoutType)layotType;
-(void)addItemToGroup:(id<PPMessengerContentDisplayObjectProt>)contentDispObject;
-(void)insertItem:(id<PPMessengerContentDisplayObjectProt>)contentDispObject toGroupAtIndex:(NSInteger)index;
-(void)addItemToGroup:(id<PPMessengerContentDisplayObjectProt>)contentDispObject reversed:(BOOL)reversed;


-(NSInteger)numberOfItemsInGroup;
-(id<PPMessengerContentDisplayObjectProt>)dispObjectForIndex:(NSInteger)index;
-(NSArray*)ppm_getAllLayouts;
-(void)ppm_updateGroupWithOffset:(UICollectionView*)holder reversed:(BOOL)reversed;

@property (nonatomic)CGRect ppm_groupFrame;
@property (nonatomic,retain)NSString * ppm_groupIndif;


-(float)ppm_getMaxY:(BOOL)reversed;

@end