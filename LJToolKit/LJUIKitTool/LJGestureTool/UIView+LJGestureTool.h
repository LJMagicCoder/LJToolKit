//
//  UIView+LJGestureTool.h
//  GestureDemo
//
//  Created by 宋立军 on 2017/10/12.
//  Copyright © 2017年 宋立军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LJGestureTool)

/*!
 @method
 @brief 添加点击手势
 @param target 目标
 @param action 方法
 @param numberOfTapsRequired 点击次数
 */
- (nullable UITapGestureRecognizer *)lj_addTapGestureWithTarget:(nullable id)target
                                                         action:(nullable SEL)action
                                           numberOfTapsRequired:(NSUInteger)numberOfTapsRequired;

/*!
 @method
 @brief 添加缩放手势
 @param maxScale 缩放最大比例
 @param minScale 缩放最小比例
 */
- (nullable UIPinchGestureRecognizer *)lj_addPinchGestureWithMaxScale:(CGFloat)maxScale
                                                             MinScale:(CGFloat)minScale;

/*!
 @method
 @brief 添加缩放手势(自定义)
 @param target 目标
 @param action 方法
 */
- (nullable UIPinchGestureRecognizer *)lj_addPinchGestureWithTarget:(nullable id)target
                                                             action:(nullable SEL)action;

/*!
 @method
 @brief 添加旋转手势
 */
- (nullable UIRotationGestureRecognizer *)lj_addRotationGesture;

/*!
 @method
 @brief 添加旋转手势(自定义)
 @param target 目标
 @param action 方法
 */
- (nullable UIRotationGestureRecognizer *)lj_addRotationGestureWithTarget:(nullable id)target
                                                                   action:(nullable SEL)action;

/*!
 @method
 @brief 添加轻扫手势
 @param target 目标
 @param action 方法
 @param numberOfTouchesRequired 轻扫手指个数
 @param direction 轻扫方向(默认从左往右)
 */
- (nullable UISwipeGestureRecognizer *)lj_addSwipeGestureWithTarget:(nullable id)target
                                                             action:(nullable SEL)action
                                            numberOfTouchesRequired:(NSInteger)numberOfTouchesRequired
                                                          direction:(UISwipeGestureRecognizerDirection)direction;

/*!
 @method
 @brief 添加拖动手势
 */
- (nullable UIPanGestureRecognizer *)lj_addPanGesture;

/*!
 @method
 @brief 添加拖动手势(自定义)
 @param target 目标
 @param action 方法
 */
- (nullable UIPanGestureRecognizer *)lj_addPanGestureWithTarget:(nullable id)target
                                                         action:(nullable SEL)action;


/*!
 @method
 @brief 添加长按手势
 */
- (nullable UILongPressGestureRecognizer *)lj_addLongPressGestureWithMinimumPressDuration:(CFTimeInterval)minimumPressDuration
                                                                               stateBlock:(void (^_Nonnull)(UIGestureRecognizerState state))block;

/*!
 @method
 @brief 添加长按手势(自定义)
 @param target 目标
 @param action 方法
 */
- (nullable UILongPressGestureRecognizer *)lj_addLongPressGestureWithTarget:(nullable id)target
                                                                     action:(nullable SEL)action
                                                       minimumPressDuration:(CFTimeInterval)minimumPressDuration;

/*!
 @method
 @brief 添加边缘滑入手势
 @param target 目标
 @param action 方法
 @param edges 滑入方向
 */
- (nullable UIScreenEdgePanGestureRecognizer *)lj_addScreenEdgePanGestureWithTarget:(nullable id)target
                                                                             action:(nullable SEL)action
                                                                              edges:(UIRectEdge)edges;


@end
