#import "UIGestureRecognizer+Block.h"
#import <objc/runtime.h>

static const int targetKey;

@implementation UIGestureRecognizer (Block)

+ (instancetype)recognizeWithAction:(GestrueBlock)gestrueBlock{
    __weak typeof(self) weakSelf = self;
    return [[weakSelf alloc]initWithActon:gestrueBlock];
}

- (instancetype)initWithActon:(GestrueBlock)gestrueBlock{
    self = [self init];
    [self addActonWithBlock:gestrueBlock];
    [self addTarget:self action:@selector(invoke:)];
    return self;
}

- (void)addActonWithBlock:(GestrueBlock)block{
    //第一步，设置关联对象
    if (block) {
        objc_setAssociatedObject(self, &targetKey, block, OBJC_ASSOCIATION_COPY);
    }
}

- (void)invoke:(id)sender{
    //取出关联对象
    GestrueBlock block = objc_getAssociatedObject(self, &targetKey);
    if (block) {
        block(sender);
    }
}
@end
