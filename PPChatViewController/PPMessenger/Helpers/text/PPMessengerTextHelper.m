//
//  PPMessengerTextHelper.m
//  PPChatViewController
//
//  Created by Alex Padalko on 3/28/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMessengerTextHelper.h"

@implementation PPMessengerTextHelper

@end






@implementation NSMutableAttributedString (PPMSelectionFinder)

-(NSArray*)ppm_findAndSelect:(NSString*)finder color:(UIColor *)selectionColor font:(UIFont*)font removeFinder:(BOOL)removeFinder{
    
    
        NSError *error = nil;
    NSRegularExpression *regex;
    
    if ([finder isEqualToString:@"#"]) {
        regex=[NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"(#[^#\\.,?;\\s\"{}\\/<>\\]\\[()\\:@]*)"] options:NSRegularExpressionCaseInsensitive error:&error];
    }else
        regex= [NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"%@(\\w+\\.?(?:\\w+))",finder] options:0 error:&error];
    NSString * str=[self string];
    NSArray *matches = [regex matchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    
    NSMutableArray* result=[[NSMutableArray alloc] init];
    
    for (NSTextCheckingResult *match in matches) {
        
        
        NSRange wordRange = [match rangeAtIndex:1];
        
        
        if (wordRange.location+wordRange.length>str.length) {
            continue;
        }
        NSString* word ;
        
        NSRange realRange;
    
        if ([finder isEqualToString:@"#"]) {
            word = [str substringWithRange:NSMakeRange(wordRange.location+1, MAX(0,  wordRange.length-1))];
            
            
            
            
            realRange=   NSMakeRange(wordRange.location, wordRange.length);
            if (selectionColor) {
                [self addAttribute:NSForegroundColorAttributeName value:selectionColor range:realRange];
            }
            
            if (font) {
                [self addAttribute:NSFontAttributeName value:font range:realRange];
            }
         [result addObject:[PPMStringSelectionObject createWithRange:realRange color:selectionColor font:font type:finder andValue:word]];
        }else     if ([finder isEqualToString:@"@"]) {
            
            
            word = [str substringWithRange:wordRange];
            
            
            
            //                if (!removeFinder) {
            realRange=   NSMakeRange(wordRange.location-1, wordRange.length+1);
            //                }
            
            if (selectionColor) {
                [self addAttribute:NSForegroundColorAttributeName value:selectionColor range:realRange];
            }
            
            if (font) {
                [self addAttribute:NSFontAttributeName value:font range:realRange];
            }
            
            [result addObject:[PPMStringSelectionObject createWithRange:realRange color:selectionColor font:font type:finder andValue:word]];
        }
        
        
    
        
    }
    if (removeFinder) {
        [ [self mutableString] replaceOccurrencesOfString:finder withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, self.string.length)];
    }
    
    return result;

}

@end


@implementation NSAttributedString (PPMStringSize)

-(CGSize)ppm_sizeOfStringWithAvailableSize:(CGSize)size{
    
    CGRect rect = [self boundingRectWithSize:size
                                              options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                              context:nil];
    
    
    return rect.size;
}

@end
@implementation PPMStringSelectionObject
+(instancetype)createWithRange:(NSRange)r color:(UIColor *)color font:(UIFont *)font type:(NSString *)type andValue:(NSString *)value{
    
    PPMStringSelectionObject * rs=[[self alloc] init];
    
    rs.selectionColor=color;
    rs.selectionFont=font;
    rs.vlaue=value;
    rs.range=r;
    rs.type=type;
    
    return rs;
    
}

@end
