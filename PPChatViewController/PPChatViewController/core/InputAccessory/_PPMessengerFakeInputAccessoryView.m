//
//  _PPChatFakeInputAccessoryView.m
//  PPChatViewController
//
//  Created by Alex Padalko on 3/22/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "_PPMessengerFakeInputAccessoryView.h"

@implementation _PPMessengerFakeInputAccessoryView

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    return [self.realInputView hitTest:point withEvent:event];
    
}
-(instancetype)initWithDelegate:(id<_PPMessengerFakeInputAccessoryViewDelegate>)delegate{
    if (self=[super initWithFrame:CGRectZero]) {
        self.delegate=delegate;
        [self setBackgroundColor:[UIColor greenColor]];
        [self setUserInteractionEnabled:NO];
    }
    return self;
}
-(void)willMoveToSuperview:(UIView *)newSuperview{
    BOOL shoudlAddObservers=NO;
    if (![self.superview isEqual:newSuperview]) {
        if (self.superview) {
            [self.superview removeObserver:self forKeyPath:@"center" context:nil];
        }
        shoudlAddObservers=YES;
    }
    if (!self.superview) {
        shoudlAddObservers=YES;
    }
    [super willMoveToSuperview:newSuperview];
    
    if (shoudlAddObservers) {
        
        [newSuperview addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionNew context:nil];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    [self.delegate _ppm_fakeInput:self superViewDidChangeFrame:self.superview.frame];
    
}
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight) {
            constraint.constant = frame.size.height;
            break;
        }
    }
}
@end
