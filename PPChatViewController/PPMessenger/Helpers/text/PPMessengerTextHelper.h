//
//  PPMessengerTextHelper.h
//  PPChatViewController
//
//  Created by Alex Padalko on 3/28/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface PPMStringSelectionObject : NSObject
+(instancetype)createWithRange:(NSRange)r color:(UIColor*)color font:(UIFont*)font type:(NSString*)type andValue:(NSString*)value;
@property (nonatomic)NSRange range;
@property (nonatomic,retain)UIColor * selectionColor;
@property (nonatomic,retain)UIFont * selectionFont;
@property (nonatomic,retain)NSString * type;
@property (nonatomic,retain)NSString * vlaue;
@end
@interface PPMessengerTextHelper : NSObject

@end

@interface NSMutableAttributedString (PPMSelectionFinder)

-(NSArray*)ppm_findAndSelect:(NSString*)finder color:(UIColor *)selectionColor font:(UIFont*)font removeFinder:(BOOL)removeFinder;

@end
@interface NSAttributedString (PPMStringSize)
-(CGSize)ppm_sizeOfStringWithAvailableSize:(CGSize)size;
@end
