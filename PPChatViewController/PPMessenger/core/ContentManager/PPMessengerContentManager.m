//
//  PPMessengerContentManager.m
//  PPChatViewController
//
//  Created by Alex Padalko on 3/23/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMessengerContentManager.h"
#import "PPMGroup.h"
@interface PPMessengerContentManager ()



@end
@implementation PPMessengerContentManager
@synthesize ppm_items=_ppm_items;
@synthesize ppm_currentWidth=_ppm_currentWidth;
@synthesize delegate=_delegate;
@synthesize ppm_totalH=_ppm_totalH;
-(void)workWithNewItems:(NSArray<PPMessengerContentDisplayObjectProt> *)newObjects complititionBlock:(void (^)(NSArray *))complitBlock{
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        NSMutableArray * checkedArr=[[NSMutableArray alloc] initWithArray:newObjects];
        NSMutableArray * realArray = [[NSMutableArray alloc] init];
        
        [self _workWithItemsArray:checkedArr deltaIndex: [self.ppm_items count]-1 realResultArray:realArray];
        
        
        float dy=0;
        
        id<PPMessengerContentDisplayGroupProt> firstGroup = [realArray firstObject];
        
        if ([firstGroup groupIndex]>0) {
            id<PPMessengerContentDisplayGroupProt> lastCalculatedGroup = [self.ppm_items objectAtIndex:[firstGroup groupIndex]-1];
            dy=[lastCalculatedGroup ppm_getMaxY];
        }
        
        
        CGSize s = [self.delegate ppmcm_getSize];
        for (id<PPMessengerContentDisplayGroupProt> group in realArray) {
            
            
            float startY=dy;
            
            for (NSInteger a = 0; a<[group numberOfItemsInGroup]; a++) {
                
                id<PPMessengerContentDisplayObjectProt> obj = [group dispObjectForIndex:a];
                [obj ppm_calculateInBackgroundOnSize:s  withY:dy andIndexPath:[NSIndexPath indexPathForRow:a inSection:[group groupIndex]]];

                if ([obj ppm_layoutType]==PPMDisplayLayoutTypeHeader) {
                    NSLog(@"header");
                    
                }else{
                    dy+=[obj ppm_layoutAttributes].frame.size.height;
                    dy+=[obj ppm_globalInsets].bottom;
                }
                
       
            }
            
            [group setPpm_groupFrame:CGRectMake(0, startY, s.width, dy-startY)];
            
        }
      
        
        self.ppm_totalH=dy;
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self.ppm_items addObjectsFromArray:realArray];
            complitBlock(realArray);
            
        });
        
    });
    
}

-(void)_workWithItemsArray:(NSMutableArray*)itemsArray deltaIndex:(NSInteger)deltaIndex realResultArray:(NSMutableArray*)realResultArray{
    
    if (itemsArray.count>0) {
        id<PPMessengerContentDisplayObjectProt> obj = [itemsArray firstObject];
        [itemsArray removeObjectAtIndex:0];
        if ([obj ppm_groupBy]) {
            
        
            id<PPMessengerContentDisplayGroupProt> group = [realResultArray lastObject];
            if (!group||![ group conformsToProtocol:@protocol(PPMessengerContentDisplayGroupProt)]||![[group ppm_groupIndif] isEqualToString:[obj ppm_groupBy]]) {
                
            
                group =[obj ppm_generateGroupWithGroupIndex:deltaIndex+1];
             
                
                if (!group) {
                    PPMGroup * gr = [[PPMGroup alloc] initWithGroupIndif:@"-1s" andGroupIndex:deltaIndex+1];
                    [gr addItemToGroup:obj];
                    [realResultArray addObject:gr];
                    [self _workWithItemsArray:itemsArray deltaIndex:gr.groupIndex realResultArray:realResultArray];
                    
                    [self _workWithItemsArray:itemsArray deltaIndex:group.groupIndex realResultArray:realResultArray];
                    return;
                }else{
                    
                    
                    [group addItemToGroup:obj];
                    [realResultArray addObject:group];
                }
                
            }

            if ([[group ppm_groupIndif] isEqualToString:[obj ppm_groupBy]]) {
                
                [group addItemToGroup:obj];
            }
            
            [self _workWithItemsArray:itemsArray deltaIndex:group.groupIndex realResultArray:realResultArray];
            
            
        }else{
            
            PPMGroup * gr = [[PPMGroup alloc] initWithGroupIndif:@"-1s" andGroupIndex:deltaIndex+1];
            [gr addItemToGroup:obj];
            [realResultArray addObject:gr];
            [self _workWithItemsArray:itemsArray deltaIndex:gr.groupIndex realResultArray:realResultArray];
        }
        
        
  
        
    }
    
}

-(NSInteger)ppm_numberOfGroups{
    return self.ppm_items.count;
}
-(NSInteger)ppm_numberItemsInGroupAtIndex:(NSInteger)index{
    id <PPMessengerContentDisplayGroupProt> group = [self ppm_groupAtIndex:index];
    return [group numberOfItemsInGroup];
}
-(id<PPMessengerContentDisplayGroupProt>)ppm_groupAtIndex:(NSInteger)index{
     id <PPMessengerContentDisplayGroupProt> group = [self.ppm_items objectAtIndex:index];
    return group;
    
    
}
-(id<PPMessengerContentDisplayObjectProt>)ppm_displayObjectAtIndexPath:(NSIndexPath *)ip{
    
    id<PPMessengerContentDisplayGroupProt> group = [self ppm_groupAtIndex:ip.section];
    
    
    return [group dispObjectForIndex:ip.row];
    
}
#pragma mark - lazy init

-(NSMutableArray *)ppm_items{
    if (!_ppm_items) {
        _ppm_items=[[NSMutableArray alloc] init];
    }
    return _ppm_items;
}

@end
