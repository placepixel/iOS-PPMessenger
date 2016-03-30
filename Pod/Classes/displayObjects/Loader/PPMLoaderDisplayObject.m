//
//  PPMLoaderDisplayObject.m
//  PPChatViewController
//
//  Created by Alex Padalko on 3/28/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMLoaderDisplayObject.h"
#import "PPMLoaderDisplayView.h"
@implementation PPMLoaderDisplayObject


-(UIEdgeInsets)ppm_contentInsets{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

-(CGSize)ppm_calculateContentSizeInBackgroundAvailableOnSize:(CGSize)size{
    
    return CGSizeMake(size.width, 44);
}

-(void)ppm_generateDisplayViewClass:(Class*)displayViewClass andIndifiter:(NSString**)indifiter andConfigurateBlock:(PPMessengerContentConfigurationBlock*)configurateBlock{
    
    
    *indifiter=@"ppm_laoder_i";
    *displayViewClass=[PPMLoaderDisplayView class];
    
    *configurateBlock=^(PPMLoaderDisplayView * viewToConfigurate){
        
        
//        [viewToConfigurate setSenderProfilePictureUrl:self.profilePictureUrl];
        
        
    };
    
    
}
-(NSString *)ppm_type{
    
    return @"PPMLoaderCellKind";
}
@end
