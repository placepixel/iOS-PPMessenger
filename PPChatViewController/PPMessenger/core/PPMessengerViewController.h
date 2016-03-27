//
//  PPMessengerViewController.h
//  PPChatViewController
//
//  Created by Alex Padalko on 3/22/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPMessengerInputAccessoryViewProt.h"
#import "PPMessengerCollectionView.h"
#import "PPMessengerCollectionViewLayout.h"

#import "PPMessengerContentProviderProt.h"
#import "PPMessengerContentConsumerProt.h"

#import "PPMessengerContentManagerProt.h"


#import "PPMessengerReusableViewProt.h"

#import "PPMessengerConstructionProt.h"
#import "PPMessengerContentDisplayObjectProt.h"
@interface PPMessengerViewController : UIViewController <PPMessengerInputAccessoryViewObserver,UICollectionViewDataSource,UICollectionViewDelegate>


@property (nonatomic,retain)id<PPMessengerContentManagerProt>contentManager;
@property (nonatomic,retain)id<PPMessengerContentConsumerProt>contentConsumer;

@property (nonatomic,retain)id<PPMessengerContentProviderProt>contentProvider;

@property (nonatomic,retain)PPMessengerCollectionView * contentView;
@property (nonatomic,retain)PPMessengerCollectionViewLayout * contentViewLayout;
@property (nonatomic,retain)UIView<PPMessengerInputAccessoryViewProt> * inputAccessoryView;
@property (nonatomic)BOOL keyboardIsVisible;




#pragma mark - setup methods

-(void)ppm_registerContructor:(id<PPMessengerConstructionProt>)construcor;


-(Class)ppm_classForInputAccesoryView;
-(Class)ppm_classForContentManager;
@end
