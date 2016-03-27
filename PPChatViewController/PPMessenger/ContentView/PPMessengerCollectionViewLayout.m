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
    return self.layouts;
}
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    return nil;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
@end
