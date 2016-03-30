//
//  PPMessengerContentManager.m
//  PPChatViewController
//
//  Created by Alex Padalko on 3/23/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMessengerContentManager.h"
#import "PPMGroup.h"

#import "PPMLoaderDisplayObject.h"
@interface PPMessengerContentManager ()


@property (nonatomic,retain)NSArray * oldestPageArray;

@end
@implementation PPMessengerContentManager



@synthesize ppm_loaderObject=_ppm_loaderObject;
@synthesize ppm_loaderDisplayGroup=_ppm_loaderDisplayGroup;
@synthesize ppm_items=_ppm_items;
@synthesize ppm_currentWidth=_ppm_currentWidth;
@synthesize delegate=_delegate;
@synthesize ppm_totalH=_ppm_totalH;

@synthesize ppm_pageSize = _ppm_pageSize;
@synthesize ppm_currentIndex = _ppm_currentIndex;
@synthesize ppm_shouldShowLoadCell=_ppm_shouldShowLoadCell;

@synthesize ppm_reversed=_ppm_reversed;
-(instancetype)init{
    if (self=[super init]) {
        self.ppm_pageSize=10;
        self.ppm_currentIndex=0;
        self.ppm_shouldShowLoadCell=NO;
    }
    return self;
}


-(void)workWithNewItems:(NSArray<PPMessengerContentDisplayObjectProt> *)newObjects complititionBlock:(void (^)(NSArray *))complitBlock{
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        if (!self.ppm_reversed&&self.ppm_currentIndex==0  ) {
            self.oldestPageArray=newObjects;
        }
        NSMutableArray * checkedArr=[[NSMutableArray alloc] initWithArray:newObjects];
        NSMutableArray * realArray = [[NSMutableArray alloc] init];
        
        if (newObjects.count>=self.ppm_pageSize) {
            self.ppm_shouldShowLoadCell=YES;
        }else{
            self.ppm_shouldShowLoadCell=NO;
        }
        
        id<PPMessengerContentDisplayGroupProt>  gr = [self.ppm_items lastObject];
        if ([gr isEqual:self.ppm_loaderDisplayGroup]) {
            [self.ppm_items removeLastObject];
        }
        
        if (self.ppm_shouldShowLoadCell) {
                 [checkedArr addObject:[[PPMLoaderDisplayObject alloc] init]];
        }
  
        self.ppm_currentIndex+=newObjects.count;
        
        id<PPMessengerContentDisplayGroupProt>  lastGroup = [self.ppm_items lastObject];
        
//        for (UICollectionViewLayoutAttributes *  obj in [lastGroup ppm_getAllLayouts]) {
//            NSLog(@"%@",obj);
//        }
//        id<PPMLoaderDisplayObjectProt> lastObject = [checkedArr lastObject];
        
        NSInteger startIdx = -1;
        if (lastGroup) {
            [realArray insertObject:lastGroup atIndex:0];
             [self.ppm_items removeLastObject];
            startIdx=[lastGroup groupIndex];
        }
  
     
        
        
  
        [self _workWithItemsArray:checkedArr deltaIndex: startIdx realResultArray:realArray];
        
        
//        for (UICollectionViewLayoutAttributes *  obj in [lastGroup ppm_getAllLayouts]) {
//            NSLog(@"%@",obj);
//        }
        
        self.ppm_loaderDisplayGroup=[realArray lastObject];
        
        float dy=0;
        
        id<PPMessengerContentDisplayGroupProt> firstGroup = [realArray firstObject];
        if ([firstGroup groupIndex]>0) {
            id<PPMessengerContentDisplayGroupProt> lastCalculatedGroup = [self.ppm_items lastObject];
            dy=CGRectGetMaxY([lastCalculatedGroup ppm_groupFrame]);
        }
        CGSize s = [self.delegate ppmcm_getSize];
//       [self.loaderDisplayGroup setGroupIndex:self.ppm_items.count-1+realArray.count-1];
//        [realArray addObject:self.loaderDisplayGroup];
        for (id<PPMessengerContentDisplayGroupProt> group in realArray) {
            
            
            float startY=dy;
            
            for (NSInteger a = 0; a<[group numberOfItemsInGroup]; a++) {
                
                id<PPMessengerContentDisplayObjectProt> obj = [group dispObjectForIndex:a];
              
                [obj ppm_calculateInBackgroundOnSize:s  withY:dy andIndexPath:[NSIndexPath indexPathForRow:a inSection:[group groupIndex]] reversed:self.ppm_reversed];

                if ([obj ppm_layoutType]==PPMDisplayLayoutTypeHeader) {
                    NSLog(@"header");
                    
                }else{
                    
                   
                    dy=CGRectGetMaxY([obj ppm_layoutAttributes].frame);
                    if (self.ppm_reversed) {
                        dy+=[obj ppm_globalInsets].top;
                    }else{
                          dy+=[obj ppm_globalInsets].bottom;
                    }
                }
                
       
            }
            
            [group setPpm_groupFrame:CGRectMake(0, startY, s.width, dy-startY)];
            
        }
      
        
        
    
//        float statyY=dy;
//        
//        [self.loaderDisplayObject ppm_calculateInBackgroundOnSize:s withY:dy andIndexPath:[NSIndexPath indexPathForRow:0 inSection:self.ppm_items.count]];
//      
//
//        dy+=[self.loaderDisplayObject ppm_layoutAttributes].frame.size.height;
//        dy+=[self.loaderDisplayObject ppm_globalInsets].bottom;
//        
//        [self.loaderDisplayGroup setPpm_groupFrame:CGRectMake(0, statyY, s.width, dy-statyY)];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self.ppm_items addObjectsFromArray:realArray];
//            [self.ppm_items addObject:self.loaderDisplayObject]; 
            
            
            self.ppm_totalH=dy;
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
                    [gr addItemToGroup:obj reversed:self.ppm_reversed];
                    [realResultArray addObject:gr ];
                    [self _workWithItemsArray:itemsArray deltaIndex:gr.groupIndex realResultArray:realResultArray];
                    
                    [self _workWithItemsArray:itemsArray deltaIndex:group.groupIndex realResultArray:realResultArray];
                    return;
                }else{
                    
                    
//                    [group addItemToGroup:obj reversed:self.ppm_reversed];
                    [realResultArray addObject:group];
                }
                
            }

            if ([[group ppm_groupIndif] isEqualToString:[obj ppm_groupBy]]) {
                
                 [group addItemToGroup:obj reversed:self.ppm_reversed];
            }
            
            [self _workWithItemsArray:itemsArray deltaIndex:group.groupIndex realResultArray:realResultArray];
            
            
        }else{
            
            PPMGroup * gr = [[PPMGroup alloc] initWithGroupIndif:@"-1s" andGroupIndex:deltaIndex+1];
             [gr addItemToGroup:obj reversed:self.ppm_reversed];
            [realResultArray addObject:gr];
            [self _workWithItemsArray:itemsArray deltaIndex:gr.groupIndex realResultArray:realResultArray];
        }
        
        
  
        
    }
    
}


-(BOOL)ppm_isLoaderCellSection:(NSInteger)section{
    
    if (self.ppm_shouldShowLoadCell&& section==self.ppm_items.count-1) {
        return YES;
    }else return NO;
    
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

#pragma mark - 

-(void)setPpm_reversed:(BOOL)ppm_reversed{
    
   _ppm_reversed= ppm_reversed;
    [self.ppm_items removeAllObjects];
    self.ppm_currentIndex=0;
}

#pragma mark - lazy init
//-(PPMLoaderDisplayObject *)loaderDisplayObject{
//    if (!_loaderDisplayObject) {
//        _loaderDisplayObject=[[PPMLoaderDisplayObject alloc] init];
//    }
//    return _loaderDisplayObject;
//}
//-(id<PPMessengerContentDisplayGroupProt>)loaderDisplayGroup{
//    
//    if (!_loaderDisplayGroup) {
//        
//        
//        PPMLoaderDisplayObject * obj =[[PPMLoaderDisplayObject alloc] init];
//        
//      _loaderDisplayGroup=  [obj ppm_generateGroupWithGroupIndex:-1];
//        
//        [_loaderDisplayGroup addItemToGroup:obj];
//        
//    }
//    return _loaderDisplayGroup;
//    
//}
-(NSMutableArray *)ppm_items{
    if (!_ppm_items) {
        _ppm_items=[[NSMutableArray alloc] init];
    }
    return _ppm_items;
}

@end
