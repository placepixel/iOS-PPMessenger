//
//  PPMSenderUsernameDisplayObject.m
//  PPChatViewController
//
//  Created by Alex Padalko on 3/25/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMSenderUsernameDisplayObject.h"
#import "PPMSenderUsernameDisplayView.h"

@implementation PPMSenderUsernameDisplayObject
-(instancetype)init{
    if (self=[super init]) {
        //           _ppm_size=CGSizeMake(40,40);
    }
    return self;
}

-(UIEdgeInsets)ppm_globalInsets{
    
    return UIEdgeInsetsMake(10, 55, 0, 10);
}
-(UIEdgeInsets)ppm_contentInsets{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(void)ppm_generateDisplayViewClass:(Class*)displayViewClass andIndifiter:(NSString**)indifiter andConfigurateBlock:(PPMessengerContentConfigurationBlock*)configurateBlock{
    
    
    *indifiter=@"ppm_sender_username_i";
    *displayViewClass=[UIButton class];
    
    *configurateBlock=^(UIButton * viewToConfigurate){
        [viewToConfigurate setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [viewToConfigurate setTitle:self.senderUsername forState:UIControlStateNormal];
    };
    
    
}

#pragma mark - <PPMessengerContentDisplayObjectProt>
-(CGSize)ppm_calculateContentSizeInBackgroundAvailableOnSize:(CGSize)size{
    return CGSizeMake(100, 28);
}
-(NSString *)ppm_type{
    return PPMessengerSenderUsername;
}

@end
