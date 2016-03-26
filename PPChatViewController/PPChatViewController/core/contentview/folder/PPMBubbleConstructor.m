//
//  PPMBubbleConstructor.m
//  PPChatViewController
//
//  Created by Alex Padalko on 3/24/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMBubbleConstructor.h"
#import "PPMessengerBubbleReusableView.h"
@implementation PPMBubbleConstructor
-(UIEdgeInsets)globalInsets{
    
    return UIEdgeInsetsMake(5, 50, 5, 5);
}
-(UIEdgeInsets)contentInsets{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

-(CGSize)getAvailableContentSizeOnGlobalSize:(CGSize)globalSize{
    
    return CGSizeMake(globalSize.width-self.globalInsets.left-self.globalInsets.right-self.contentInsets.left-self.contentInsets.right, CGFLOAT_MAX);
    
}
-(Class)reusableViewClass{
    return [PPMessengerBubbleReusableView class];
}
-(NSString*)ppm_type{
    
    return PPMessengerBubble;
}
-(NSString *)ppm_groupType{
    return nil;
}
-(PPMDisplayLayoutType)ppm_layoutType{
    return PPMDisplayLayoutTypeDefault;

}
@end
