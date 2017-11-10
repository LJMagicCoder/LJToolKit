//
//  UIView+LJMBProgressHUDTool.h
//  LJMBProgressHUDDemo
//
//  Created by 宋立军 on 2017/7/13.
//  Copyright © 2017年 宋立军. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ProgressHUDCompletionBlock)();

@interface UIView (LJMBProgressHUDTool)

- (void)showMBProgressHUD;

- (void)hiddenMBProgressHUD;

- (void)showWithLabelText:(NSString *)labelText hideAfterDelay:(NSTimeInterval)delay;

- (void)showWithLabelText:(NSString *)labelText
          detailLabelText:(NSString *)detailsLabelText
           hideAfterDelay:(NSTimeInterval)delay
               completion:(ProgressHUDCompletionBlock)completionBlock;

- (void)showWithLabelText:(NSString *)labelText
          detailLabelText:(NSString *)detailsLabelText
           hideAfterDelay:(NSTimeInterval)delay
              customImage:(UIImage *)image
               completion:(ProgressHUDCompletionBlock)completionBlock;

- (void)showWithLabelText:(NSString *)labelText
          detailLabelText:(NSString *)detailsLabelText
           hideAfterDelay:(NSTimeInterval)delay
               customView:(UIView *)customView
               completion:(ProgressHUDCompletionBlock)completionBlock;

@end
