//
//  PPMGroup.m
//  PPChatViewController
//
//  Created by Alex Padalko on 3/24/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMGroup.h"

@implementation PPMGroup
@synthesize ppm_groupIndif=_ppm_groupIndif;
@synthesize ppm_items=_ppm_items;
@synthesize ppm_groupFrame=_ppm_groupFrame;
@synthesize groupIndex=_groupIndex;
-(instancetype)initWithGroupIndif:(NSString*)groupIndif andGroupIndex:(NSInteger)index{
    
    if (self=[super init]) {
        self.ppm_groupIndif=groupIndif;
        self.groupIndex=index;
    }
    return self;
}

-(void)addDynamicItem:(id<PPMessengerContentDisplayObjectProt>)dynamicItem forType:(PPMDisplayLayoutType)layotType{
    if (![self.ppm_dynamic_items containsObject:dynamicItem]) {
           [self.ppm_dynamic_items addObject:dynamicItem];
    }
 
}
-(void)addItemToGroup:(id<PPMessengerContentDisplayObjectProt>)contentDispObject{
    [self.ppm_items addObject:contentDispObject];
}
-(void)ppm_updateGroupWithOffset:(float)offset{
    
    for (id<PPMessengerContentDisplayObjectProt> obj in self.ppm_dynamic_items) {
        
        
        
        [obj ppm_layoutAttributes].frame=CGRectMake([obj ppm_layoutAttributes].frame.origin.x,
                                                    
                                                    
                                                    
                                                    MIN(self.ppm_groupFrame.origin.y- MIN(self.ppm_groupFrame.origin.y-offset, 0)+5, CGRectGetMaxY(self.ppm_groupFrame)-[obj ppm_layoutAttributes].frame.size.height),

//                                                 MAX(   MIN(self.ppm_groupFrame.origin.y+offset, CGRectGetMaxY(self.ppm_groupFrame)-[obj ppm_layoutAttributes].frame.size.height), self.ppm_groupFrame.origin.y+5),
                                                    
                                                    
                                                    
                                                    
                                                    
                                                    
                                                    [obj ppm_layoutAttributes].frame.size.width, [obj ppm_layoutAttributes].frame.size.height);
        
    }
    
    
}

-(NSMutableArray<PPMessengerContentDisplayObjectProt> *)ppm_dynamic_items{
    if (!_ppm_dynamic_items) {
        _ppm_dynamic_items=(NSMutableArray<PPMessengerContentDisplayObjectProt> *)[[NSMutableArray alloc] init];
    }
    return _ppm_dynamic_items;
}

-(NSMutableArray<PPMessengerContentDisplayObjectProt> *)ppm_items{
    if (!_ppm_items) {
        _ppm_items=(NSMutableArray<PPMessengerContentDisplayObjectProt> *)[[NSMutableArray alloc] init];
    }
    return _ppm_items;
}
-(NSInteger)numberOfItemsInGroup{
    return self.ppm_items.count;
}
-(id<PPMessengerContentDisplayObjectProt>)dispObjectForIndex:(NSInteger)index{
    return [self.ppm_items objectAtIndex:index];
}
-(NSArray*)ppm_getAllLayouts{
    NSMutableArray * resultArray=[[NSMutableArray alloc] init];
    for (id<PPMessengerContentDisplayObjectProt> obj in self.ppm_items) {
        [resultArray addObject:[obj ppm_layoutAttributes]];
    }
    return resultArray;
    
}
-(float)ppm_getMaxY{
    
    
    return CGRectGetMaxY([[self dispObjectForIndex:[self numberOfItemsInGroup]-1] ppm_layoutAttributes].frame);
    
}
@end
