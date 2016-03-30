//
//  PPMessengerContentProvider.h
//  PPChatViewController
//
//  Created by Alex Padalko on 3/23/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPMessengerContentProviderProt.h"
#import "PPMessengerContentConsumerProt.h"
@interface PPMessengerContentProvider : NSObject <PPMessengerContentProviderProt,PPMessengerContentConsumerProt>

@end
