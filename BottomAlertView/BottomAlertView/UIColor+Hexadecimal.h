//
//  UIColor+Hexadecimal.h
//  
//
//  Created by  on 16/9/8.
//  Copyright © 2016年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hexadecimal)

+ (UIColor*) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor*) colorWithHex:(NSInteger)hexValue;
+ (NSString *) hexFromUIColor: (UIColor*)color;
+ (UIColor *) colorWithHexString: (NSString *)color;
@end
