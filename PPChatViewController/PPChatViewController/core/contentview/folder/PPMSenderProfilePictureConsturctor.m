//
//  PPMSenderProfilePictureConsturctor.m
//  PPChatViewController
//
//  Created by Alex Padalko on 3/24/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMSenderProfilePictureConsturctor.h"
#import "PPMSenderProfilePictureReusableView.h"
@implementation PPMSenderProfilePictureConsturctor
-(UIEdgeInsets)globalInsets{
    
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
-(UIEdgeInsets)contentInsets{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(CGSize)getAvailableContentSizeOnGlobalSize:(CGSize)globalSize{
    
    return CGSizeMake(globalSize.width-self.globalInsets.left-self.globalInsets.right-self.contentInsets.left-self.contentInsets.right, CGFLOAT_MAX);
    
}
-(Class)reusableViewClass{
    return [PPMSenderProfilePictureReusableView class];
}
-(NSString*)ppm_type{
    
    return PPMessengerSenderProfilePicture;
}
-(NSString *)ppm_groupType{
    return nil;
}
-(PPMDisplayLayoutType)ppm_layoutType{
    return PPMDisplayLayoutTypeHeader;
    
}
@end
