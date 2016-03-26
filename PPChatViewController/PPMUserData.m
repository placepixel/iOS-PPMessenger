//
//  PPMUserData.m
//  PPChatViewController
//
//  Created by Alex Padalko on 3/25/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMUserData.h"

@implementation PPMUserData
static PPMUserData * inst;

@synthesize username=_username;
@synthesize profilePictureUrlStr=_profilePictureUrlStr;
@synthesize userId=_userId;
+(instancetype)sharedInstance{
    
    if (!inst) {
        inst=[[PPMUserData alloc] init];
    }
    return inst;
    
}

-(instancetype)init{
    if (self=[super init]) {
         self.profilePictureUrlStr=@"http://zblogged.com/wp-content/uploads/2015/11/17.jpg";
    }
    return self;
}

-(void)setUserId:(NSString *)userId{
    _userId=userId;
    [[NSUserDefaults standardUserDefaults] setValue:userId forKey:@"ppm_userId"];
}
-(NSString *)userId{
    
    if (!_userId) {
        _userId=[[NSUserDefaults standardUserDefaults] valueForKey:@"ppm_userId"];
    }
    return _userId;
}
-(void)setProfilePictureUrlStr:(NSString *)profilePictureUrlStr{
    _profilePictureUrlStr=profilePictureUrlStr;
    [[NSUserDefaults standardUserDefaults] setValue:profilePictureUrlStr forKey:@"ppm_profilePictureUrlStr"];
}
-(NSString *)profilePictureUrlStr{
    
    if (!_profilePictureUrlStr) {
        _profilePictureUrlStr=[[NSUserDefaults standardUserDefaults] valueForKey:@"ppm_profilePictureUrlStr"];
    }
    return _profilePictureUrlStr;
}
-(void)setUsername:(NSString *)username{
    _username=username;
    self.userId=username;
    [[NSUserDefaults standardUserDefaults] setValue:username forKey:@"ppm_username"];
}
-(NSString *)username{
    
    if (!_username) {
        _username=[[NSUserDefaults standardUserDefaults] valueForKey:@"ppm_username"];
    }
    return _username;
}

@end
