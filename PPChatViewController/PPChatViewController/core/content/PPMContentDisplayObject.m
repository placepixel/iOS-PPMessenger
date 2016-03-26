//
//  PPMContentDisplayObject.m
//  PPChatViewController
//
//  Created by Alex Padalko on 3/25/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMContentDisplayObject.h"

@implementation PPMContentDisplayObject
@synthesize ppm_contentSize=_ppm_contentSize;
@synthesize ppm_layoutAttributes=_ppm_layoutAttributes;
@synthesize ppm_displayContentView=_ppm_displayContentView;
@synthesize ppm_contentInsets=_ppm_contentInsets;
#pragma mark - <PPMessengerContentDisplayObjectProt>

-(id<PPMessengerContentDisplayGroupProt>)ppm_generateGroupWithGroupIndex:(NSInteger)groupIndex{
    
    return nil;
}
-(NSString *)ppm_groupBy{
    
    return nil;
}

-(CGSize)ppm_calculateContentSizeInBackgroundOnSize:(CGSize)size{
    

    return size;
    
}

-(UICollectionViewLayoutAttributes*)ppm_calculateInBackgroundOnSize:(CGSize)size constructor:(id<PPMessengerConstructionProt>)constructor withY:(float)y andIndexPath:(NSIndexPath*)indexPath{
    
    
    
    
    CGSize contentSize = [constructor getAvailableContentSizeOnGlobalSize:size];
    
    self.ppm_contentSize=[self ppm_calculateContentSizeInBackgroundOnSize:contentSize];
    
    
    self.ppm_layoutAttributes =  [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:[self ppm_type] withIndexPath:indexPath];
    self.ppm_layoutAttributes.frame=CGRectMake(
                                               [constructor globalInsets].left,
                                               [constructor globalInsets].top+y,
                                               self.ppm_contentSize.width+[constructor contentInsets].left+[constructor contentInsets].right ,
                                               
                                               self.ppm_contentSize.height+[constructor contentInsets].top+[constructor contentInsets].bottom);
    
    
    return   self.ppm_layoutAttributes;
}
-(UIView*)ppm_displayview{
    return nil;
}
-(BOOL)ppm_allowToGroup{
    return YES;
}
-(NSString *)ppm_fromUserId{
    return nil;
}
-(NSString *)ppm_fromUserUsername{
    
    return nil;
}


-(NSString *)ppm_type{
    return PPMessengerOtherUserBubble;
}
-(NSString*)ppm_groupType{
    return PPMessengerOtherUserMessagesGroup;
}
@end
