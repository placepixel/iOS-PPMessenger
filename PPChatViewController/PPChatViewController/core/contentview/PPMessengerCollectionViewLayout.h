//
//  PPChatCollectionViewLayout.h
//  PPChatViewController
//
//  Created by Alex Padalko on 3/22/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPMessengerContentDisplayObjectProt.h"
#import "PPMessengerConstructionProt.h"
@protocol PPMessengerCollectionViewLayoutDelegate <NSObject>
-(CGSize)ppml_getContentSize;
-(NSArray<PPMessengerContentDisplayGroupProt>*)ppml_getAllGroups;
-(id<PPMessengerContentDisplayGroupProt>)ppml_getGropForSection:(NSInteger)section;
-(id<PPMessengerConstructionProt>)ppml_getConstructorForType:(NSString*)type;
@end
@interface PPMessengerCollectionViewLayout : UICollectionViewLayout
@property (nonatomic,weak) id <PPMessengerCollectionViewLayoutDelegate> delegate;
@end
