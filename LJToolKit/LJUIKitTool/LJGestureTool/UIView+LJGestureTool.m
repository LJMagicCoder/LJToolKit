//
//  UIView+LJGestureTool.m
//  GestureDemo
//
//  Created by 宋立军 on 2017/10/12.
//  Copyright © 2017年 宋立军. All rights reserved.
//

#import "UIView+LJGestureTool.h"
#import <objc/runtime.h>

static char kPinchMaxScale;
static char kPinchMinScale;

@implementation UIView (LJGestureTool)

//添加点击手势
- (nullable UITapGestureRecognizer *)lj_addTapGestureWithTarget:(nullable id)target
                                                         action:(nullable SEL)action
                                           numberOfTapsRequired:(NSUInteger)numberOfTapsRequired
{
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    tapGesture.numberOfTapsRequired = numberOfTapsRequired;
    [self addGestureRecognizer:tapGesture];
    
    return tapGesture;
}

//添加缩放手势
- (nullable UIPinchGestureRecognizer *)lj_addPinchGestureWithMaxScale:(CGFloat)maxScale
                                                             MinScale:(CGFloat)minScale
{
    //添加捏合手势
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(lj_pinchGestureRecognizer:)];
    [self addGestureRecognizer:pinchGesture];
    
    objc_setAssociatedObject(self, &kPinchMaxScale, @(maxScale), OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, &kPinchMinScale, @(minScale), OBJC_ASSOCIATION_ASSIGN);
    return pinchGesture;
}

//缩放事件处理
- (void)lj_pinchGestureRecognizer:(UIPinchGestureRecognizer *)pinch{
    
    CGFloat maxScale = [objc_getAssociatedObject(self, &kPinchMaxScale) floatValue];
    CGFloat minScale = [objc_getAssociatedObject(self, &kPinchMinScale) floatValue];
    
    if (pinch.state == UIGestureRecognizerStateChanged) {
        //取到缩放比率
        CGFloat scale = pinch.scale;
        if (scale > maxScale || scale < minScale) return;
        //缩放
        pinch.view.transform=CGAffineTransformMakeScale(scale, scale);
    }
}

//添加缩放手势(自定义)
- (nullable UIPinchGestureRecognizer *)lj_addPinchGestureWithTarget:(nullable id)target
                                                             action:(nullable SEL)action
{
    //添加捏合手势
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:pinchGesture];

    return pinchGesture;
}

//添加旋转手势
- (nullable UIRotationGestureRecognizer *)lj_addRotationGesture
{
    
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(lj_rotationGestureRecognizer:)];
    [self addGestureRecognizer:rotationGesture];

    return rotationGesture;
}

//旋转事件处理
- (void)lj_rotationGestureRecognizer:(UIRotationGestureRecognizer*)rotation{
    if(rotation.state==UIGestureRecognizerStateChanged) {
        //取到弧度
        CGFloat angle = rotation.rotation;
        //正在旋转
        rotation.view.transform = CGAffineTransformMakeRotation(angle);
    }
}

//添加旋转手势(自定义)
- (nullable UIRotationGestureRecognizer *)lj_addRotationGestureWithTarget:(nullable id)target
                                                                   action:(nullable SEL)action
{
    
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:rotationGesture];
    
    return rotationGesture;
}


//添加轻扫手势
- (nullable UISwipeGestureRecognizer *)lj_addSwipeGestureWithTarget:(nullable id)target
                                                             action:(nullable SEL)action
                                            numberOfTouchesRequired:(NSInteger)numberOfTouchesRequired
                                                          direction:(UISwipeGestureRecognizerDirection)direction
{
    //添加轻扫手势
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:target action:action];
    //设置属性，swipe也是有两种属性设置手指个数及轻扫方向**
    swipeGesture.numberOfTouchesRequired = numberOfTouchesRequired;
    //设置轻扫方向(默认是从左往右)
    swipeGesture.direction = direction;
    [self addGestureRecognizer:swipeGesture];

    return swipeGesture;
}

//添加拖动手势
- (nullable UIPanGestureRecognizer *)lj_addPanGesture {
    
    //添加拖动手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(lj_panGestureRecognizer:)];
    [self addGestureRecognizer:panGesture];

    return panGesture;
}

- (void)lj_panGestureRecognizer:(UIPanGestureRecognizer *)gesture {
    
    //手指所在的坐标
    CGPoint point = [gesture locationInView:[gesture.view superview]];
    gesture.view.center= point;
}

//添加拖动手势(自定义)
- (nullable UIPanGestureRecognizer *)lj_addPanGestureWithTarget:(nullable id)target
                                                         action:(nullable SEL)action
{
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:panGesture];

    return panGesture;
}

//添加长按手势
- (nullable UILongPressGestureRecognizer *)lj_addLongPressGestureWithMinimumPressDuration:(CFTimeInterval)minimumPressDuration
                                                                               stateBlock:(void (^_Nonnull)(UIGestureRecognizerState state))block
{
    //添加长按手势
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(lj_longPressGestureRecognizer:)];
    objc_setAssociatedObject(self, @selector(lj_longPressGestureRecognizer:), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    //设置最短时间
    longPressGesture.minimumPressDuration = minimumPressDuration;
    [self addGestureRecognizer:longPressGesture];
    
    return longPressGesture;
}

- (void)lj_longPressGestureRecognizer:(UILongPressGestureRecognizer *)gesture {
    
    void (^stateBlock)(UIGestureRecognizerState state) = objc_getAssociatedObject(self, _cmd);
    stateBlock(gesture.state);
}

//添加长按手势(自定义)
- (nullable UILongPressGestureRecognizer *)lj_addLongPressGestureWithTarget:(nullable id)target
                                                                     action:(nullable SEL)action
                                                       minimumPressDuration:(CFTimeInterval)minimumPressDuration
{
    //添加长按手势
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:target action:action];
    //设置最短时间
    longPressGesture.minimumPressDuration = minimumPressDuration;
    [self addGestureRecognizer:longPressGesture];
    return longPressGesture;
}

//添加边缘滑入手势
- (nullable UIScreenEdgePanGestureRecognizer *)lj_addScreenEdgePanGestureWithTarget:(nullable id)target
                                                                             action:(nullable SEL)action
                                                                              edges:(UIRectEdge)edges
{
    
    UIScreenEdgePanGestureRecognizer *screenEdgePanGesture = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:target action:action];
    //设置哪个方向边缘滑入
    screenEdgePanGesture.edges = edges;
    [self addGestureRecognizer:screenEdgePanGesture];

    return screenEdgePanGesture;
}

@end
