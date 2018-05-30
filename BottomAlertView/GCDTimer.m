//
//  GCDTimer.m
//  BottomAlertView
//
//  Created by 立元通信 on 2018/5/30.
//  Copyright © 2018年 zcz. All rights reserved.
//

#import "GCDTimer.h"
@interface GCDTimer()
@property (nonatomic, strong) dispatch_source_t timer;

- (instancetype)initWithDelay:(NSTimeInterval)delay timeInterval:(NSTimeInterval)timeInterval block:(void(^)(void))block;
@end
@implementation GCDTimer

+ (instancetype)timerWithDelay:(NSTimeInterval)delay timeInterval:(NSTimeInterval)timeInterval block:(void (^)(void))block{
    return [[self alloc] initWithDelay:delay timeInterval:timeInterval block:block];
}

- (instancetype)initWithDelay:(NSTimeInterval)delay timeInterval:(NSTimeInterval)timeInterval block:(void (^)(void))block{
    self = [super init];
    if (self) {
        dispatch_queue_t queue = dispatch_get_main_queue();
        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
        uint64_t interval = (uint64_t)(timeInterval * NSEC_PER_SEC);
        dispatch_source_set_timer(self.timer, start, interval, 0);
        dispatch_source_set_event_handler(self.timer, ^{
            if (block) {
                block();
            }
        });
    }
    return self;
}

- (void)start{
    if (self.timer) {
        dispatch_resume(self.timer);
    }
    
}
- (void)pause{
    if (self.timer) {
        dispatch_suspend(self.timer);
    }
}
- (void)cancel{
    if (dispatch_cancel(self.tim) {
        dispatch_cancel(self.timer);
    }
}
@end
