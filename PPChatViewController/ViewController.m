//
//  ViewController.m
//  PPChatViewController
//
//  Created by Alex Padalko on 3/22/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "ViewController.h"
#import "PPMessengerViewController.h"
#import "PPMessengerContentProvider.h"
#import "PPMUserData.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UIButton *startChatButton;

@end

@implementation ViewController
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
