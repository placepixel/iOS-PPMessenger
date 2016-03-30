//
//  PPMMessageTextContentDisplayView.m
//  PPChatViewController
//
//  Created by Alex Padalko on 3/28/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMMessageTextContentDisplayView.h"
@interface PPMMessageTextContentDisplayView ()
@property (nonatomic,retain)UITextView * textContentView;
@property (nonatomic,retain)  NSTextContainer * tc;
@property (nonatomic,retain)UILabel * textLabel;

@end
@implementation PPMMessageTextContentDisplayView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame: frame]) {
        
//        NSTextStorage* textStorage = [[NSTextStorage alloc] init];
//        NSLayoutManager* layoutManager = [NSLayoutManager new];
//        [textStorage addLayoutManager:layoutManager];
//      NSTextContainer * tc= [[NSTextContainer alloc] initWithSize:CGSizeZero];
//        [layoutManager addTextContainer:  tc];
//        self.tc=tc;
//        self.textContentView=[[UITextView alloc] initWithFrame:CGRectZero textContainer:tc];
//        [self.textContentView setScrollEnabled:NO];
//        [self.textContentView setEditable:NO];
//        [self addSubview:self.textContentView];
        
        self.textLabel=[[UILabel alloc] init];
        [self.textLabel setNumberOfLines:0];
        
        [self.textLabel setBackgroundColor:[UIColor orangeColor]];
        
        [self addSubview:self.textLabel];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.textLabel setFrame:self.bounds];
//    [self.textContentView setFrame:self.bounds];
//    [self.tc setSize:self.bounds.size];
}
-(void)setTextContent:(NSAttributedString *)textContent{
        _textContent=textContent;
    [self.textLabel setAttributedText:textContent];

//    [self.textContentView setAttributedText:textContent];
}
@end
