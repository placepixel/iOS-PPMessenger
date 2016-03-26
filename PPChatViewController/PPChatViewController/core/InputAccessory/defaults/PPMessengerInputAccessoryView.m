//
//  PPMessengerInputAccessoryView.m
//  PPChatViewController
//
//  Created by Alex Padalko on 3/23/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMessengerInputAccessoryView.h"
@interface PPMessengerInputAccessoryView ()

@property (nonatomic)float currentTextViewHeight;

@property (nonatomic)float currentHeight;
@property (nonatomic)float initialHeight;

@property (nonatomic)float lineHeight;

@property (nonatomic,retain) NSTextContainer * textContainer;

@property (nonatomic)NSInteger numberOfLines;
@property (nonatomic)NSInteger maxNumberOflines;
@property (nonatomic)float maxHeight;

////


@property (nonatomic,retain)UIButton * sendButton;

@end
@implementation PPMessengerInputAccessoryView
@synthesize ppm_inputTextView=_ppm_inputTextView;
@synthesize ppm_observer=_ppm_observer;

-(instancetype)initWithHeight:(float)height andObserver:(id<PPMessengerInputAccessoryViewObserver>)observer{
    if (self=[super initWithFrame:CGRectZero]) {
        
        
        
        
        
             [self setBackgroundColor:[[UIColor redColor] colorWithAlphaComponent:0.5]];
             [self setPpm_observer:observer];
              self.initialHeight=height;

                 [self ppm_inputTextView];
        
        self.numberOfLines=1;
        self.maxNumberOflines=5;
        self.textViewFont=[UIFont systemFontOfSize:18];
        
  
   
        
        NSLog(@"%f",self.ppm_inputTextView.textContainerInset.bottom);
        NSLog(@"%f",self.ppm_inputTextView.textContainerInset.top);
        
//        self.textViewInstets=UIEdgeInsetsMake(6, 8, 6, 8);
   
        
        self.sendButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.sendButton setBackgroundColor:[UIColor whiteColor]];
        [self.sendButton setTitle:@"send" forState:UIControlStateNormal];
        
        [self.sendButton addTarget:self action:@selector(onTextSendButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.sendButton];
    
    }
    return self;
    
}
#pragma mark -
-(BOOL)isFirstResponder{
    return [self.ppm_inputTextView isFirstResponder];
}
-(BOOL)becomeFirstResponder{
    return [self.ppm_inputTextView becomeFirstResponder];
}
#pragma mark - 
-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    [self.sendButton setFrame:CGRectMake(self.frame.size.width-44-8, 0, self.frame.size.height, self.frame.size.height)];
    [_ppm_inputTextView setFrame:UIEdgeInsetsInsetRect(self.bounds,self.textViewInstets)];
//    [self.textContainer setSize:CGSizeMake(_ppm_inputTextView.frame.size.width, self.ppm_inputTextView.frame.size.height-16)];
}

#pragma mark - actions

-(void)onTextSendButton:(UIButton*)button{
    
    BOOL shouldClean=NO;
    BOOL shouldResignResonder=NO;
    
    [self.delegate ppmiav_accessoryView:self wantsToSendText:self.ppm_inputTextView.text shouldClean:&shouldClean shouldResingResponder:&shouldResignResonder];
    
    if (shouldClean) {
        self.ppm_inputTextView.text=@"";
    }
    
    if (shouldResignResonder) {
        [self.ppm_inputTextView resignFirstResponder];
    }
    
}

#pragma mark -
-(void)setCurrentHeight:(float)currentHeight{
    if (currentHeight==_currentHeight) {
        NSLog(@"same HEIGHT");
        return;
    }
    _currentHeight=MAX(self.initialHeight, currentHeight);
    NSLog(@"%f",currentHeight);
    
    
    [self.ppm_observer ppm_inputAccesoryView:self didChangeHeight:currentHeight];
    
}
-(void)setInitialHeight:(float)initialHeight{
    _initialHeight=initialHeight;
    
    self.currentHeight=initialHeight;
}
#pragma mark -
-(float)ppm_height{
    return self.currentHeight;
}
-(void)setLineHeight:(float)lineHeight{
    
    _lineHeight=lineHeight;
    
    float totalH = lineHeight;//+self.ppm_inputTextView.textContainerInset.top+self.ppm_inputTextView.textContainerInset.bottom;
   
    float offset = (self.initialHeight-totalH)/2;
    self.maxHeight=self.maxNumberOflines*lineHeight;
    self.textViewInstets=UIEdgeInsetsMake(offset, 8, offset, 8+44+8);
    self.currentTextViewHeight= totalH;
}
-(void)setTextViewFont:(UIFont *)textViewFont{
    
    _textViewFont=textViewFont;
  
    [self.ppm_inputTextView setFont:textViewFont];
    self.lineHeight=textViewFont.lineHeight;

    
    
}
-(void)setCurrentTextViewHeight:(float)currentTextViewHeight{
    if (currentTextViewHeight==_currentTextViewHeight) {
        return;
    }
    _currentTextViewHeight=currentTextViewHeight;
    
    
    float realHeight =  MIN(currentTextViewHeight,self.maxHeight);

 
    self.currentHeight=realHeight+self.textViewInstets.top+self.textViewInstets.bottom;
    
    if (currentTextViewHeight==realHeight) {
        //        self.ppm_inputTextView.scrollEnabled=NO;
        [self.ppm_inputTextView setContentOffset:CGPointMake(0, self.lineHeight) animated:NO];
    }else{
        //        self.ppm_inputTextView.scrollEnabled=YES;
    }
}
#pragma mark - <UITextViewDelegate>
-(void)textViewDidChange:(UITextView *)textView{
    CGRect usedFrame = [textView.layoutManager usedRectForTextContainer:textView.textContainer];
    
    NSLog(@"%@",NSStringFromCGRect(usedFrame));
    
    self.numberOfLines=usedFrame.size.height/self.lineHeight;
    

    
    
    self.currentTextViewHeight=usedFrame.size.height;
 
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    NSLog(@"%@",text);
    

    
    return YES;
    
}

#pragma mark- lazy init
-(UITextView *)ppm_inputTextView{
    if (!_ppm_inputTextView) {
        
//        NSTextStorage* textStorage = [[NSTextStorage alloc] init];
//        NSLayoutManager* layoutManager = [NSLayoutManager new];
//        [textStorage addLayoutManager:layoutManager];
//        self.textContainer= [[NSTextContainer alloc] initWithSize:CGSizeZero];
//        [layoutManager addTextContainer:     self.textContainer];
        
        _ppm_inputTextView=[[UITextView alloc] init];
       
        [_ppm_inputTextView setTextContainerInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        [_ppm_inputTextView setDelegate:self];
        [_ppm_inputTextView setBackgroundColor:[UIColor grayColor]];
        [self addSubview:_ppm_inputTextView];
    }
    return _ppm_inputTextView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
