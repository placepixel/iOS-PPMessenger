//
//  PPChatCollectionViewLayout.m
//  PPChatViewController
//
//  Created by Alex Padalko on 3/22/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMessengerCollectionViewLayout.h"
@interface PPMessengerCollectionViewLayout ()

@property (nonatomic,retain)NSMutableArray * layouts;
@property (nonatomic)CGSize contentSize;

@end
@implementation PPMessengerCollectionViewLayout
-(CGSize)collectionViewContentSize{
    return [self.delegate ppml_getContentSize];
}
-(void)prepareLayout{
    [super prepareLayout];
    NSLog(@"asd");
    
//    NSInteger sections = [self.collectionView numberOfSections];
//    self.layouts=[[NSMutableArray alloc] init];
//    float dy = 0 ;
//    
//    for (NSInteger i = 0 ; i< sections; i++) {
//        
//        id<PPMessengerContentDisplayGroupProt> group = [self.delegate ppml_getGropForSection:i];
//        
////        NSLog(@"!%@-%ld",[group ppm_groupIndif],[group numberOfItemsInGroup]);
//        NSInteger items = [group numberOfItemsInGroup];
//        
//        BOOL didSetupTopEdge=NO;
//        
//        float topEdge=0;
//        float leftEdge=0;
//        float di=0;
//        
//        BOOL shouldBreak=NO;
//        NSMutableArray * dynamicViews=[[NSMutableArray alloc] init];
//        for (NSInteger gi=0; gi<items; gi++) {
//            
//            id<PPMessengerContentDisplayObjectProt> disp = [group  dispObjectForIndex:gi];
//            id<PPMessengerConstructionProt> constructor = [self.delegate ppml_getConstructorForType:[disp ppm_type]];
//            if ([constructor ppm_layoutType]==PPMDisplayLayoutTypeDefault) {
//                
//                
//                dy += [constructor globalInsets].top;
//       
//             
//               
//                UICollectionViewLayoutAttributes * attr = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:[disp ppm_type] withIndexPath:[NSIndexPath indexPathForItem:di inSection:i]];
//                
//                attr.frame=CGRectMake([constructor globalInsets].left, dy, [disp ppm_size].width+[constructor contentInsets].left+[constructor contentInsets].right, [disp ppm_size].height+[constructor contentInsets].top+[constructor contentInsets].bottom);
//                
//                if (!didSetupTopEdge) {
//                    didSetupTopEdge=YES;
//                    topEdge=dy;
//                    leftEdge=attr.frame.origin.y;
//                }else{
//                     leftEdge=MIN(attr.frame.origin.x, leftEdge);
//                }
//                
//               
//                
//                //            NSLog(@"%@",NSStringFromCGRect(attr.frame));
//                [self.layouts addObject:attr];
//                
//                dy+=attr.frame.size.height+[constructor globalInsets].bottom;
//                
//           
//                
//            }else if ([constructor ppm_layoutType]==PPMDisplayLayoutTypeHeader){
//                           UICollectionViewLayoutAttributes * attr = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:[disp ppm_type] withIndexPath:[NSIndexPath indexPathForItem:di inSection:i]];
//                [dynamicViews addObject:@{@"disp":disp,@"constructor":constructor,@"attr":attr}];
//                
//                [self.layouts addObject:attr];
//            }
//             di++;
//        }
//        
//        float bottomEdge = dy;
//        
//        if (topEdge>self.collectionView.contentOffset.y+self.collectionView.frame.size.height) {
//            shouldBreak=YES;
//            
//        }else if (bottomEdge<self.collectionView.contentOffset.y){
//            continue;
//        }
//        
//        float visibleOrigin = self.collectionView.contentOffset.y;
//        
////        if (i==2) {
//            for (NSDictionary * dict in dynamicViews) {
//                UICollectionViewLayoutAttributes * attr = [dict valueForKey:@"attr"];
//                id<PPMessengerContentDisplayObjectProt> disp = [dict valueForKey:@"disp"];
//                id<PPMessengerConstructionProt> constructor =[dict valueForKey:@"constructor"];
//                CGSize s =  CGSizeMake([disp ppm_size].width+[constructor contentInsets].left+[constructor contentInsets].right, [disp ppm_size].height+[constructor contentInsets].top+[constructor contentInsets].bottom);
//                
//                attr.frame=CGRectMake([constructor globalInsets].left, MIN(MAX(topEdge, self.collectionView.contentOffset.y), bottomEdge-s.height),s.width,s.height );
////                NSLog(@"%@",NSStringFromCGRect(attr
////                                               .frame));
////                NSLog(@"%f",self.collectionView.contentOffset.y);
//            }
////        }
//        
//   
//        
//        
//
//        if (shouldBreak) {
//            dy+=100;
//            break;
//        }
//        
//        
//        
//  
//        
//    }
//    
//    self.contentSize=CGSizeMake(self.collectionView.frame.size.width, 100000);
    
    CGRect visibleRect = CGRectMake(0, self.collectionView.contentOffset.y, self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    self.layouts=[[NSMutableArray alloc] init];
    NSArray * arr = [self.delegate ppml_getAllGroups];
    for (id<PPMessengerContentDisplayGroupProt> group in arr) {
        if (CGRectIntersectsRect([group ppm_groupFrame], visibleRect)) {
            
            [group ppm_updateGroupWithOffset:self.collectionView.contentOffset.y];
            [self.layouts addObjectsFromArray:[group ppm_getAllLayouts]];
        }
    }
    
    
    

}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray * resultArray =[[NSMutableArray alloc] init];
    return self.layouts;
    
    NSArray * arr = [self.delegate ppml_getAllGroups];
    
    for (id<PPMessengerContentDisplayGroupProt> group in arr) {
        if (CGRectIntersectsRect([group ppm_groupFrame], rect)) {
            
            
            [resultArray addObjectsFromArray:[group ppm_getAllLayouts]];
        }
    }

    
    return resultArray;
}
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    return nil;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
@end
