//
//  PPMessengerContentProvider.m
//  PPChatViewController
//
//  Created by Alex Padalko on 3/23/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMessengerContentProvider.h"


#import "PPMMessage.h"
#import "PPMMessageDisplayObject.h"


#import <Firebase/Firebase.h>
@interface PPMessengerContentProvider ()

@property (nonatomic,retain)NSMutableArray * usersArray;
@end
@implementation PPMessengerContentProvider
-(instancetype)init{
    if (self=[super init]) {
        
        self.usersArray=[[NSMutableArray alloc] init];
        
        for (NSInteger a=0; a<3; a++) {
            [self.usersArray addObject:[NSString stringWithFormat:@"%ld",a]];
        }
        
    }
    return self;
}
-(BOOL)ppm_shouldBeInitialTopOriented{
    return YES;
}
-(void)ppm_loadItems:(NSInteger)skip limit:(NSInteger)limit fromTopToBot:(BOOL)fromTopToBot complitBlock:(void (^)(NSArray<PPMessengerContentDisplayObjectProt> *))complitBlock{
    
    
    NSMutableArray<PPMessengerContentDisplayObjectProt>  * items =(   NSMutableArray<PPMessengerContentDisplayObjectProt>  *)[[NSMutableArray alloc] init];
    
    
    NSString * path = [NSString stringWithFormat:@"https://ppmessenger.firebaseio.com/rooms/test"];
    Firebase *ref = [[Firebase alloc] initWithUrl:path];
    
    
    [[[ref queryOrderedByPriority] queryLimitedToFirst:10] observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        
        NSMutableArray * realArr = [[NSMutableArray alloc] init];
        NSLog(@"%@",snapshot.children);
        NSLog(@"%@",snapshot.value);
         NSLog(@"%ld",snapshot.childrenCount);
        for (NSString * key in snapshot.value) {
            
            [realArr addObject:[snapshot.value valueForKey:key]];
        }
        
        NSArray * result =  [PPMMessage createWithDataArray:realArr];
        
        NSArray * dispRes = [PPMMessageDisplayObject createWithMessages:result];
        
        complitBlock(dispRes);
        
    }];
    
    
//    for (NSInteger a=skip; a<skip+limit; a++) {
//        
//        NSString* text =[NSString stringWithFormat:@"text nassda %ld",a];
//        [items addObject:[[PPMTextMessageDisplayObject alloc] initWithTextMessage:[[PPMTextMessageObject alloc] initWithText:text andUserId:[self.usersArray objectAtIndex:arc4random()%self.usersArray.count]]]];
//        
//    }
//    
//    
//    complitBlock(items);
    
}


-(void)ppm_shoudSendTextMessageWithText:(NSString*)text{
    PPMMessage *  message = [PPMMessage createTextMessageWithContent:text];
    [self sendMessage:message];
  
//    for (NSInteger a= 0; a<40; a++) {
//          PPMMessage *  message = [PPMMessage createTextMessageWithContent:[NSString stringWithFormat:@"%@ %ld",text,a]];
//        [self sendMessage:message];
//    }
   
}

-(void)sendMessage:(id<PPMMessageProt>)message{
    
    
    
    NSDictionary * data = [message dictionaryRepresentation];
    
    NSString * path = [NSString stringWithFormat:@"https://ppmessenger.firebaseio.com/rooms/test/%@",[self genereateRandomId]];
    Firebase *ref = [[Firebase alloc] initWithUrl:path];
    
    [ref setValue:data];
}


-(NSString*)genereateRandomId{
    NSDate *d  =[NSDate date ];
    return [[NSString stringWithFormat:@"%f",[d timeIntervalSince1970]] stringByReplacingOccurrencesOfString:@"." withString:@"_"];
}
@end
