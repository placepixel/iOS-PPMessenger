//
//  PPMSenderProfilePictureView.m
//  PPChatViewController
//
//  Created by Alex Padalko on 3/25/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMSenderProfilePictureView.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface PPMSenderProfilePictureView ()

@property (nonatomic,retain)UIImageView * imageView;

@end
@implementation PPMSenderProfilePictureView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor purpleColor]];
    }
    return self;
}

-(void)setSenderProfilePictureUrl:(NSString *)senderProfilePictureUrl{
    _senderProfilePictureUrl=senderProfilePictureUrl;
    
    
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:senderProfilePictureUrl] placeholderImage:nil];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.imageView setFrame:self.bounds];
}
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView=[[UIImageView alloc] init];
        [self addSubview:_imageView];
    }
    return _imageView;
}
@end
