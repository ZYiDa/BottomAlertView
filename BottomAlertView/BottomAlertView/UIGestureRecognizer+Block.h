#import <UIKit/UIKit.h>

typedef void(^GestrueBlock)(id gestrueRecognize);
@interface UIGestureRecognizer (Block)

+ (instancetype)recognizeWithAction:(GestrueBlock)gestrueBlock;

@end
