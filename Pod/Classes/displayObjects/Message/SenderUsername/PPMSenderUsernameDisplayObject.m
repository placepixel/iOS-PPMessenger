//
//  PPMSenderUsernameDisplayObject.m
//  PPChatViewController
//
//  Created by Alex Padalko on 3/25/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMSenderUsernameDisplayObject.h"
#import "PPMSenderUsernameDisplayView.h"
#import "PPMessengerTextHelper.h"
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
    *displayViewClass=[PPMSenderUsernameDisplayView class];
    
    *configurateBlock=^(PPMSenderUsernameDisplayView * viewToConfigurate){

        [viewToConfigurate setSenderUsername:[self senderUsername]];
    };
    
    
}
-(void)setSenderUsername:(NSString *)senderUsername{
     _senderUsername = [senderUsername hasPrefix:@"@"]?senderUsername:[NSString stringWithFormat:@"@%@",senderUsername];
}

#pragma mark - <PPMessengerContentDisplayObjectProt>
-(CGSize)ppm_calculateContentSizeInBackgroundAvailableOnSize:(CGSize)size{
    
    
    
    
    NSMutableAttributedString * str =[[NSMutableAttributedString alloc] initWithString:self.senderUsername attributes:@{
                                                                                                                        NSFontAttributeName:[UIFont systemFontOfSize:15]
                                                                                                                        }];
    
    
    CGSize s = [str ppm_sizeOfStringWithAvailableSize:size];
    
    return CGSizeMake(s.width, 30);
}
-(NSString *)ppm_type{
    return PPMessengerSenderUsername;
}
-(PPMDisplayLayoutType)ppm_layoutType{
    return PPMDisplayLayoutTypeDefault;
}

@end
