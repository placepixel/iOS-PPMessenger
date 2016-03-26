//
//  PPMSenderProfilePictureDispObj.m
//  PPChatViewController
//
//  Created by Alex Padalko on 3/24/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMSenderProfilePictureDisplayObject.h"

@implementation PPMSenderProfilePictureDisplayObject
//@synthesize ppm_size=_ppm_size;


-(instancetype)init{
    if (self=[super init]) {
//           _ppm_size=CGSizeMake(40,40);
    }
    return self;
}

#pragma mark - <PPMessengerContentDisplayObjectProt>
-(CGSize)ppm_calculateContentSizeInBackgroundOnSize:(CGSize)size{
    return CGSizeMake(40, 40);
}
//-(CGSize)ppm_calculateInBackgroundOnSize:(CGSize)size{
//    
//    _ppm_size=CGSizeMake(40,40);
//    return _ppm_size;
//}

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
    return PPMessengerSenderProfilePicture;
}
-(NSString*)ppm_groupType{
    return nil;
}
@end
