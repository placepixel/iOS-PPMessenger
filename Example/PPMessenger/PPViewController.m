//
//  PPViewController.m
//  PPMessenger
//
//  Created by Alex Padalko on 03/30/2016.
//  Copyright (c) 2016 Alex Padalko. All rights reserved.
//

#import "PPViewController.h"

#import "PPMessengerViewController.h"
#import "PPMessengerContentProvider.h"
#import "PPMUserData.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface PPViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UIButton *startChatButton;

@end

@implementation PPViewController
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    
    
    
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    [self.usernameTextField setText:[PPMUserData sharedInstance].username];
    
    
    [self.profilePicture sd_setImageWithURL:[NSURL URLWithString:[[PPMUserData sharedInstance] profilePictureUrlStr]] placeholderImage:nil];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onStartChat:(id)sender {
    
    if (self.usernameTextField.text.length==0) {
        return;
    }
    
    [[PPMUserData sharedInstance] setUsername:self.usernameTextField.text];
    PPMessengerViewController * m =  [[PPMessengerViewController alloc] init];
    PPMessengerContentProvider * cp =[[PPMessengerContentProvider alloc] init];
    [m setContentProvider:cp];
    [m setContentConsumer:cp];
    
    
    UINavigationController * nav =[[UINavigationController alloc] initWithRootViewController:m];
    [nav.navigationBar setTranslucent:NO];
    
    
    [self presentViewController:nav animated:YES completion:^{
        
    }];
    
}
@end