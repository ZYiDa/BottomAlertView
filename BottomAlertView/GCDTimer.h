//
//  GCDTimer.h
//  BottomAlertView
//
//  Created by 立元通信 on 2018/5/30.
//  Copyright © 2018年 zcz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCDTimer : NSObject

+ (instancetype)timerWithDelay:(NSTimeInterval)delay timeInterval:(NSTimeInterval)timeInterval block:(void(^)(void))block;
- (void)start;
- (void)pause;
- (void)cancel;

@end
