//
//  PPMessengerConstructionProt.h
//  PPChatViewController
//
//  Created by Alex Padalko on 3/24/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPMessengerDefaults.h"

typedef NS_ENUM(NSInteger,PPMDisplayLayoutType){
    
    PPMDisplayLayoutTypeDefault,
    PPMDisplayLayoutTypeHeader,
};
@protocol PPMessengerConstructionProt <NSObject>


-(Class)reusableViewClass;

-(UIEdgeInsets)globalInsets;
-(UIEdgeInsets)contentInsets;

-(CGSize)getAvailableContentSizeOnGlobalSize:(CGSize)globalSize;


-(NSString*)ppm_type;
-(NSString*)ppm_groupType;


-(PPMDisplayLayoutType)ppm_layoutType;
@end
