//
//  PPMSenderProfilePictureDispObj.m
//  PPChatViewController
//
//  Created by Alex Padalko on 3/24/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMSenderProfilePictureDisplayObject.h"
#import "PPMSenderProfilePictureView.h"
@implementation PPMSenderProfilePictureDisplayObject
//@synthesize ppm_size=_ppm_size;


-(instancetype)init{
    if (self=[super init]) {
//           _ppm_size=CGSizeMake(40,40);
    }
    return self;
}

-(UIEdgeInsets)ppm_globalInsets{
    
    return UIEdgeInsetsMake(5+28, 5, 5, 5);
}
-(UIEdgeInsets)ppm_contentInsets{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(void)ppm_generateDisplayViewClass:(Class*)displayViewClass andIndifiter:(NSString**)indifiter andConfigurateBlock:(PPMessengerContentConfigurationBlock*)configurateBlock{
    
    
    *indifiter=@"ppm_sender_prof_i";
    *displayViewClass=[PPMSenderProfilePictureView class];
    
    *configurateBlock=^(PPMSenderProfilePictureView * viewToConfigurate){
    
        
        [viewToConfigurate setSenderProfilePictureUrl:self.profilePictureUrl];
        
        
    };
    
    
}
-(PPMDisplayLayoutType)ppm_layoutType{
    return PPMDisplayLayoutTypeHeader;
}
#pragma mark - <PPMessengerContentDisplayObjectProt>
-(CGSize)ppm_calculateContentSizeInBackgroundAvailableOnSize:(CGSize)size{
    return CGSizeMake(40, 40);
}

-(NSString *)ppm_type{
    return PPMessengerSenderProfilePicture;
}

@end
