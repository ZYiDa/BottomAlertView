//
//  BottomAlertView.h
//  BottomAlertView
//
//  Created by  on 2018/5/29.
//  Copyright © 2018年 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UserConstant.h"
#import "UIColor+Hexadecimal.h"
#import "UIView+Category.h"
#import "UIGestureRecognizer+Block.h"

@interface AlertBaseView : UIView

@end


@interface BottomAlertView : NSObject

+ (void)showAlertWithMessage:(NSString *)message andTapAction:(void(^)(void))tapAction;
+ (void)dismissAlertWithDelay:(NSTimeInterval)delayTime complete:(void(^)(void))complete;
+ (void)dismissAlertWithComplete:(void(^)(void))complete;

@end


