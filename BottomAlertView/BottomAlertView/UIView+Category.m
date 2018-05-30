//
//  UIView+Category.m
//  CommonCategory
//
//  Created by  on 2018/5/7.
//  Copyright © 2018年 zcz. All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Category)
/*
 *x
 */
- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x{
    return self.frame.origin.x;
}

/*
 *y
 */
- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

/*
 *width
 */
- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width{
    return self.frame.size.width;
}

/*
 *height
 */
- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height{
    return self.frame.size.height;
}

/*
 *center x
 */
- (void)setPointX:(CGFloat)pointX{
    CGPoint point = self.center;
    point.x = pointX;
    self.center = point;
}

- (CGFloat)pointX{
    return self.center.x;
}

/*
 *center y
 */
- (void)setPointY:(CGFloat)pointY{
    CGPoint point = self.center;
    point.y = pointY;
    self.center = point;
}

- (CGFloat)pointY{
    return self.center.y;
}

/*
 *size
 */
- (void)setViewSize:(CGSize)viewSize{
    CGRect frame = self.frame;
    frame.size = viewSize;
    self.frame = frame;
}

- (CGSize)viewSize{
    return self.frame.size;
}

/*
 *origin
 */
- (void)setViewOrigin:(CGPoint)viewOrigin{
    CGRect frame = self.frame;
    frame.origin = viewOrigin;
    self.frame = frame;
}

- (CGPoint)viewOrigin{
    return self.frame.origin;
}
@end
