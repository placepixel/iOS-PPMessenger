//
//  PPMessengerConstructionProt.h
//  PPChatViewController
//
//  Created by Alex Padalko on 3/24/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPMessengerDefaults.h"
#import "PPMReusableView.h"
typedef NS_ENUM(NSInteger,PPMDisplayLayoutType){
    
    PPMDisplayLayoutTypeDefault,
    PPMDisplayLayoutTypeHeader,
};
@protocol PPMessengerConstructionProt <NSObject>


-(Class)ppm_reusableViewClass;
@property (nonatomic)UIEdgeInsets ppm_contentInsets;
-(PPMDisplayLayoutType)ppm_layoutType;
-(NSString*)ppm_type;
-(UIEdgeInsets)ppm_globalInsets;
-(CGSize)getAvailableContentSizeOnGlobalSize:(CGSize)globalSize;

@end
