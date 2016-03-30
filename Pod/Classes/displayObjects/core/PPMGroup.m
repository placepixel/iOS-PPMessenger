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
@synthesize ppm_header=_ppm_header;



-(instancetype)initWithGroupIndif:(NSString*)groupIndif andGroupIndex:(NSInteger)index{
    
    if (self=[super init]) {
        self.ppm_groupIndif=groupIndif;
        self.groupIndex=index;
    }
    return self;
}
-(void)setPpm_header:(id<PPMessengerContentDisplayObjectProt>)ppm_header{
    _ppm_header=ppm_header;
    [self.ppm_items addObject:ppm_header];
}
-(void)addDynamicItem:(id<PPMessengerContentDisplayObjectProt>)dynamicItem forType:(PPMDisplayLayoutType)layotType{
    if (![self.ppm_dynamic_items containsObject:dynamicItem]) {
           [self.ppm_dynamic_items addObject:dynamicItem];
    }
    [self addItemToGroup:dynamicItem];
 
 
}

-(void)addItemToGroup:(id<PPMessengerContentDisplayObjectProt>)contentDispObject reversed:(BOOL)reversed{
    
    if (reversed) {
        if (self.ppm_header) {
                    [self insertItem:contentDispObject toGroupAtIndex:self.ppm_items.count-1];
        }else{
                     [self addItemToGroup:contentDispObject];
        }

    }else{
        [self addItemToGroup:contentDispObject];
    }
}

-(void)insertItem:(id<PPMessengerContentDisplayObjectProt>)contentDispObject toGroupAtIndex:(NSInteger)index;
{
    if (![self.ppm_items containsObject:contentDispObject]) {
        [self.ppm_items removeObject:contentDispObject];
    }
    [self.ppm_items insertObject:contentDispObject atIndex:index];
    
}
-(void)addItemToGroup:(id<PPMessengerContentDisplayObjectProt>)contentDispObject{
    
    if (![self.ppm_items containsObject:contentDispObject]) {
        [self.ppm_items removeObject:contentDispObject];
    }
            [self.ppm_items addObject:contentDispObject];
}
-(void)ppm_updateGroupWithOffset:(UICollectionView *)holder reversed:(BOOL)reversed{
    
    
    

    
  
    
    if (!reversed) {
        
        float offset = holder.contentOffset.y;
            float gr_off =  self.ppm_groupFrame.origin.y - offset;
        for (id<PPMessengerContentDisplayObjectProt> obj in self.ppm_dynamic_items) {
            
            
            float obj_off = gr_off+[obj ppm_globalInsets].top;
           
            
            float y = MAX(0, obj_off);
            y+=offset;
             y+=5;
            float objH=[obj ppm_contentSize].height;

            
          y=  MIN(y,[self ppm_groupFrame].origin.y+[self ppm_groupFrame].size.height-objH-[obj ppm_globalInsets].bottom);
            
            
            [obj ppm_layoutAttributes].frame=CGRectMake([obj ppm_layoutAttributes].frame.origin.x,
                                                        
                                                        y,
                                                        

                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        [obj ppm_layoutAttributes].frame.size.width, [obj ppm_layoutAttributes].frame.size.height);
            
        }
    }else{
        
           float offset = holder.contentOffset.y;
        
               float gr_off =  self.ppm_groupFrame.origin.y+self.ppm_groupFrame.size.height - offset - holder.frame.size.height;
        for (id<PPMessengerContentDisplayObjectProt> obj in self.ppm_dynamic_items) {
            
            
            float add_off=MAX(0, gr_off - [obj ppm_contentSize].height+[obj ppm_globalInsets].bottom);
      
             float objH=[obj ppm_contentSize].height;
            float obj_off = gr_off+[obj ppm_globalInsets].top;
//            float y = MAX(0, obj_off);
            
            
             float y =  MAX(self.ppm_groupFrame.origin.y+self.ppm_groupFrame.size.height-objH-[obj ppm_globalInsets].top-[obj ppm_globalInsets].bottom -add_off, self.ppm_groupFrame.origin.y+5);
            
//            y+=MIN(0, <#B#>)
//            y+=offset;
//            y+=5;
//            float objH=[obj ppm_contentSize].height;
//            
//            
//            y=  MIN(y,[self ppm_groupFrame].origin.y+[self ppm_groupFrame].size.height-objH-[obj ppm_globalInsets].bottom);
            
            
            [obj ppm_layoutAttributes].frame=CGRectMake([obj ppm_layoutAttributes].frame.origin.x,
                                                        
                                                        y,
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        [obj ppm_layoutAttributes].frame.size.width, [obj ppm_layoutAttributes].frame.size.height);
            
            [[obj ppm_layoutAttributes] setTransform:CGAffineTransformMakeScale(1.0, -1.0)];
            
        }
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
-(float)ppm_getMaxY:(BOOL)reversed{
    if (reversed) {
        
        NSLog(@"%f--%f",CGRectGetMaxY([[[self ppm_items] firstObject] ppm_layoutAttributes].frame),CGRectGetMaxY([[self dispObjectForIndex:[self numberOfItemsInGroup]-1] ppm_layoutAttributes].frame));
        
         return CGRectGetMinY([[[self ppm_items] lastObject] ppm_layoutAttributes].frame);
    }else
    return CGRectGetMaxY([[self dispObjectForIndex:[self numberOfItemsInGroup]-1] ppm_layoutAttributes].frame);
    
}
@end
