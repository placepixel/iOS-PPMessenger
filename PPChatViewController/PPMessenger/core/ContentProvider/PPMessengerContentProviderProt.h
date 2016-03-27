//
//  PPChatContentProviderProt.h
//  PPChatViewController
//
//  Created by Alex Padalko on 3/22/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPMessengerContentDisplayObjectProt.h"
@protocol PPMessengerContentProviderProt;
@protocol PPMessengerContentProviderObserver <NSObject>

-(void)ppm_contentProvider:(id<PPMessengerContentProviderProt>)contentProvider didReciveNewItems:(NSArray<PPMessengerContentDisplayObjectProt>*)newItems;
@end
@protocol PPMessengerContentProviderProt <NSObject>
//@property (nonatomic,weak)id<PPMessengerContentProviderObserver> observer;

-(BOOL)ppm_shouldBeInitialTopOriented;
-(void)ppm_loadItems:(NSInteger)skip limit:(NSInteger)limit fromTopToBot:(BOOL)fromTopToBot complitBlock:(void(^)(NSArray<PPMessengerContentDisplayObjectProt>*))complitBlock;
@end
