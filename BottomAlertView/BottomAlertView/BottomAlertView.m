//
//  BottomAlertView.m
//  BottomAlertView
//
//  Created by 立元通信 on 2018/5/29.
//  Copyright © 2018年 zcz. All rights reserved.
//


#import "BottomAlertView.h"


#pragma mark -- AlertBaseView
typedef void(^GestrueBlcok)(void);
@interface AlertBaseView()
{
    BOOL isShow;
}
@property (nonatomic,strong) UILabel * contentLabel;
@property (nonatomic,strong) UIButton * closeButton;
@property (nonatomic,copy) GestrueBlcok gestrueDidStart;
@property (nonatomic,copy) GestrueBlcok gestrueDidEnd;
@property (nonatomic,copy) GestrueBlcok gestrueDidEndWithTimerInvalidate;
- (instancetype)init;
- (void)show;
- (void)dismiss;
@end

@implementation AlertBaseView

- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(kMarginLeft,
                                                                 kMarginTop,
                                                                 self.width - (kMarginLeft + kMarginRight),
                                                                 self.height - kMarginTop*2)];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:14.0f];
        [self addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (UIButton *)closeButton{
    if (_closeButton == nil) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [_closeButton setFrame:CGRectMake(self.width - ButtonWidth, 0, ButtonWidth, self.height)];
        [_closeButton setImageEdgeInsets:UIEdgeInsetsMake(5, 0, self.height - ButtonWidth - 5, 0)];
        [_closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_closeButton];
    }
    return _closeButton;
}

- (void)closeAction{
    if (self.gestrueDidEndWithTimerInvalidate) {
        self.gestrueDidEndWithTimerInvalidate();
    }
    [self dismiss];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        //
        isShow = YES;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        self.layer.shadowOpacity = 0.8f;
        self.layer.shadowRadius = 5.f;
        self.layer.shadowOffset = CGSizeMake(0,0);

    }
    return self;
}

#pragma mark -- show
- (void)show{
    /*
     *UIView 动画里面的 self 引用没必要替换为 weakSelf 引用
     */
    [self recognizeConfigs];
    [self showConfigs];
    if (isShow) {
        [UIView animateWithDuration:1.0f
                              delay:0
             usingSpringWithDamping:0.5f
              initialSpringVelocity:1.0f
                            options:UIViewAnimationOptionLayoutSubviews
                         animations:^{
                             CGFloat x = kScreenWidth/2;
                             CGFloat y = isIphoneX?(kScreenHeight - ( 34 + 49 + 10 + AlertHeight/2)):(kScreenHeight - (49 + 10 + AlertHeight/2));
                             self.center = CGPointMake(x, y);
                             [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
                         }
                         completion:nil];
    }
    
}

#pragma mark -- dismiss
- (void)dismiss{
    isShow = NO;
    [UIView animateWithDuration:0.5f
                          delay:0
         usingSpringWithDamping:0.8f
          initialSpringVelocity:1.0f
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         self.center = CGPointMake(kScreenWidth/2, kScreenHeight+AlertHeight);
                     }
                     completion:^(BOOL finished) {
                         self->isShow = YES;
                         [self removeFromSuperview];
                     }];
}

#pragma mark -- dismissWithNoAnimation
- (void)dismissWithNoAnimation{
    [UIView animateWithDuration:1
                     animations:^{
                         self.center = CGPointMake(kScreenWidth/2, kScreenHeight+AlertHeight);
                         [self removeFromSuperview];
                     }];
}

#pragma mark -- UI Config
- (void)showConfigs{
    self.contentLabel.backgroundColor = [UIColor whiteColor];
    self.contentLabel.textColor = [UIColor blackColor];
    self.closeButton.backgroundColor = [UIColor whiteColor];
}

#pragma mark -- 配置手势操作
- (void)recognizeConfigs{
    __weak typeof(self) weakSelf = self;
    UIPanGestureRecognizer *panGestrue = [UIPanGestureRecognizer recognizeWithAction:^(id gestrueRecognize) {
        UIPanGestureRecognizer *recognizer = (UIPanGestureRecognizer *)gestrueRecognize;
        CGPoint translation     = [recognizer translationInView:self];
        CGPoint viewNewPoint    = CGPointMake(recognizer.view.center.x + translation.x,recognizer.view.center.y + translation.y);
        CGFloat y = isIphoneX?(kScreenHeight - ( 34 + 49 + 10 + AlertHeight/2)):(kScreenHeight - (49 + 10 + AlertHeight/2));
        //TODO:给拖拽控件设置范围
        viewNewPoint.y          = y;//固定 y 值，控件只能在水平方向上移动
        recognizer.view.center  = viewNewPoint;
        [recognizer setTranslation:CGPointZero inView:[UIApplication sharedApplication].keyWindow];
        
        switch (recognizer.state) {
            case UIGestureRecognizerStateBegan:
                {
                    NSLog(@"手势已经开始");
                    if (weakSelf.gestrueDidStart) {
                        weakSelf.gestrueDidStart();//手势开始时，暂停定时器
                    }
                }
                break;
            case UIGestureRecognizerStateEnded:
                {
                    NSLog(@"手势已经结束");
                    if (recognizer.view.center.x < 30 || recognizer.view.center.x > kScreenWidth - 30) {
                        [self dismissWithNoAnimation];
                        if (weakSelf.gestrueDidEndWithTimerInvalidate) {//手势结束，且 alert 消失，此时销毁定时器
                            weakSelf.gestrueDidEndWithTimerInvalidate();
                        }
                    }else{
                        [UIView animateWithDuration:0.5
                                         animations:^{
                                             recognizer.view.center = CGPointMake(kScreenWidth/2, self.center.y);
                                         }];
                        if (weakSelf.gestrueDidEnd) {//手势结束，但 alert 没有消失，此时继续开始计时操作
                            weakSelf.gestrueDidEnd();
                        }
                    }
                }
                break;
            default:
                break;
        }
    }];
    panGestrue.cancelsTouchesInView = NO;
    [self addGestureRecognizer:panGestrue];
}
@end

#pragma mark -- BottomAlertView

@interface BottomAlertView()
@property (nonatomic,strong) AlertBaseView *baseView;
@property (nonatomic, strong) dispatch_source_t timer;
@end

@implementation BottomAlertView

+ (BottomAlertView *)shareView{
    static BottomAlertView *shareView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareView = [[BottomAlertView alloc]init];
        shareView.baseView = [[AlertBaseView alloc]init];
        shareView.baseView.userInteractionEnabled = YES;
    });
    return shareView;
}

#pragma mark -- showAlert
+ (void)showAlertWithMessage:(NSString *)message andTapAction:(void (^)(void))tapAction{
    BottomAlertView *bSelf = [BottomAlertView shareView];
    
    /*
     *每次 show 之前，暂停上一次的定时器
     */
    if (bSelf.timer) {
        dispatch_cancel(bSelf.timer);
    }
    [[UIApplication sharedApplication].keyWindow addSubview:bSelf.baseView];
    bSelf.baseView.frame = CGRectMake(0, 0, kScreenWidth - kMarginLeft * 2, AlertHeight);
    bSelf.baseView.center = CGPointMake(kScreenWidth/2, kScreenHeight + AlertHeight);
    bSelf.baseView.contentLabel.text = message;
    [bSelf.baseView show];
    if (tapAction) {
        [bSelf.baseView addGestureRecognizer:[UITapGestureRecognizer recognizeWithAction:^(id gestrueRecognize) {
            tapAction();
        }]];
    }
}

#pragma mark -- 默认的 dismiss,是立即执行的
+ (void)dismissAlertWithComplete:(void (^)(void))complete{
    BottomAlertView *bSelf = [BottomAlertView shareView];
    [bSelf.baseView dismiss];
    if (complete) {
        complete();
    }
}

#pragma mark -- 延迟执行的 dismiss，延迟时间由使用者自己设定
+ (void)dismissAlertWithDelay:(NSTimeInterval)delayTime complete:(void (^)(void))complete{
    BottomAlertView *bSelf = [BottomAlertView shareView];
    __weak typeof(bSelf) weakSelf = bSelf;
    /*
     *每次启动定时器，先销毁之前的定时器
     */
//    if (bSelf.timer) {
//        dispatch_cancel(bSelf.timer);
//    }
    if (delayTime < 1) {
        delayTime = 1;
    }
    
    __block NSTimeInterval userDelayTime = delayTime;
    dispatch_queue_t queue = dispatch_get_main_queue();
    bSelf.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(1.0 * NSEC_PER_SEC);
    dispatch_source_set_timer(bSelf.timer, start, interval, 0);
    dispatch_source_set_event_handler(bSelf.timer, ^{
        NSLog(@"=== %f ===",userDelayTime);
        if (userDelayTime == 0) {
            // 取消定时器
            dispatch_cancel(weakSelf.timer);
            [weakSelf.baseView dismiss];
            if (complete) {
                complete();
            }
        }
        userDelayTime--;
    });
    
    // 启动定时器
    dispatch_resume(bSelf.timer);
    
    [bSelf.baseView setGestrueDidStart:^{
        //手势开始，暂停定时器
        dispatch_suspend(weakSelf.timer);
    }];
    [bSelf.baseView setGestrueDidEnd:^{
        //手势结束，但 alert 没有消失，此时启动定时器
        dispatch_resume(weakSelf.timer);
    }];
    [bSelf.baseView setGestrueDidEndWithTimerInvalidate:^{
        //手势结束，alert 也已经消失，此时销毁定时器
        dispatch_cancel(weakSelf.timer);
        if (complete) {
            complete();
        }
    }];
}
@end

