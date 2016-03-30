//
//  PPMContentDisplayObject.m
//  PPChatViewController
//
//  Created by Alex Padalko on 3/25/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMContentDisplayObject.h"
#import "PPMGroup.h"
#import "PPMReusableView.h"
@implementation PPMContentDisplayObject


#pragma mark - PPMessengerConstructionProt


@synthesize ppm_contentInsets=_ppm_contentInsets;



-(Class)ppm_reusableViewClass{
    return [PPMReusableView class];
}
-(PPMDisplayLayoutType)ppm_layoutType{
    return PPMDisplayLayoutTypeDefault;
}
-(UIEdgeInsets)ppm_globalInsets{
    return UIEdgeInsetsZero;
}


-(CGSize)getAvailableContentSizeOnGlobalSize:(CGSize)globalSize{
    
    return CGSizeMake(globalSize.width-[self ppm_globalInsets].left-[self ppm_globalInsets].right-self.ppm_contentInsets.left-self.ppm_contentInsets.right, CGFLOAT_MAX);
    
}

#pragma mark - <PPMessengerContentDisplayObjectProt>
@synthesize ppm_contentSize=_ppm_contentSize;
@synthesize ppm_layoutAttributes=_ppm_layoutAttributes;


-(void)ppm_generateDisplayViewClass:(Class*)displayViewClass andIndifiter:(NSString**)indifiter andConfigurateBlock:(PPMessengerContentConfigurationBlock*)configurateBlock{
    
    
}
-(id<PPMessengerContentDisplayGroupProt>)ppm_generateGroupWithGroupIndex:(NSInteger)groupIndex{
    
    return [[PPMGroup alloc] initWithGroupIndif:[self ppm_groupBy] andGroupIndex:groupIndex];
}
-(NSString *)ppm_groupBy{
    
    return nil;
}


-(CGSize)ppm_calculateContentSizeInBackgroundAvailableOnSize:(CGSize)size{
    return size;
}

-(UICollectionViewLayoutAttributes*)ppm_calculateInBackgroundOnSize:(CGSize)size withY:(float)y andIndexPath:(NSIndexPath*)indexPath reversed:(BOOL)reversed{
    

//    if (self.ppm_layoutAttributes) {
//        return self.ppm_layoutAttributes;
//    }
    
    CGSize contentSize = [self getAvailableContentSizeOnGlobalSize:size];
    self.ppm_contentSize=[self ppm_calculateContentSizeInBackgroundAvailableOnSize:contentSize];
    
    
    self.ppm_layoutAttributes =  [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:[self ppm_type] withIndexPath:indexPath];
    
    if (reversed) {
        self.ppm_layoutAttributes.frame=CGRectMake(
                                                   [self ppm_globalInsets].left,
                                                   [self ppm_globalInsets].bottom+y,
                                                   self.ppm_contentSize.width+[self ppm_contentInsets].left+[self ppm_contentInsets].right ,
                                                   
                                                   self.ppm_contentSize.height+[self ppm_contentInsets].top+[self ppm_contentInsets].bottom);
    }else{
        self.ppm_layoutAttributes.frame=CGRectMake(
                                                   [self ppm_globalInsets].left,
                                                   [self ppm_globalInsets].top+y,
                                                   self.ppm_contentSize.width+[self ppm_contentInsets].left+[self ppm_contentInsets].right ,
                                                   
                                                   self.ppm_contentSize.height+[self ppm_contentInsets].top+[self ppm_contentInsets].bottom);
    }

    
    
    return   self.ppm_layoutAttributes;
}


-(NSString *)ppm_type{
    return PPMessengerOtherUserBubble;
}



@end
