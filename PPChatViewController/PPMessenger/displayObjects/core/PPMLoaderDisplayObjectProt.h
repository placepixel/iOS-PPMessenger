//
//  PPMLoaderDisplayObjectProt.h
//  PPChatViewController
//
//  Created by Alex Padalko on 3/28/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPMessengerContentDisplayObjectProt.h"
typedef NS_ENUM (NSInteger,PPMLoaderDisplayObjectState){
    PPMLoaderDisplayObjectStateNone,
    PPMLoaderDisplayObjectStateLoading,
    PPMLoaderDisplayObjectStateFail,
};

@protocol PPMLoaderDisplayObjectProt <PPMessengerContentDisplayObjectProt>


@property (nonatomic)PPMLoaderDisplayObjectState ppm_loadState;
@end
