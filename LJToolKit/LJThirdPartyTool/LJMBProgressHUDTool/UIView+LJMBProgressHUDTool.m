//
//  UIView+LJMBProgressHUDTool.m
//  LJMBProgressHUDDemo
//
//  Created by 宋立军 on 2017/7/13.
//  Copyright © 2017年 宋立军. All rights reserved.
//

#import "UIView+LJMBProgressHUDTool.h"
#import <MBProgressHUD/MBProgressHUD.h>

@implementation UIView (LJMBProgressHUDTool)

- (void)showMBProgressHUD {
    [MBProgressHUD showHUDAddedTo:self animated:YES];
}

- (void)hiddenMBProgressHUD {
    [MBProgressHUD hideHUDForView:self animated:YES];
}

- (void)showWithLabelText:(NSString *)labelText hideAfterDelay:(NSTimeInterval)delay {
    [self showWithLabelText:labelText
            detailLabelText:nil
             hideAfterDelay:delay
                 customView:nil
                 completion:nil
     ];
}

- (void)showWithLabelText:(NSString *)labelText
          detailLabelText:(NSString *)detailsLabelText
           hideAfterDelay:(NSTimeInterval)delay
               completion:(ProgressHUDCompletionBlock)completionBlock {
    
    [self showWithLabelText:labelText
            detailLabelText:detailsLabelText
             hideAfterDelay:delay
                 customView:nil
                 completion:completionBlock
     ];
}

- (void)showWithLabelText:(NSString *)labelText
          detailLabelText:(NSString *)detailsLabelText
           hideAfterDelay:(NSTimeInterval)delay
              customImage:(UIImage *)image
               completion:(ProgressHUDCompletionBlock)completionBlock {
    
    [self showWithLabelText:labelText
            detailLabelText:detailsLabelText
             hideAfterDelay:delay
                 customView:[[UIImageView alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]]
                 completion:completionBlock
     ];
}

- (void)showWithLabelText:(NSString *)labelText
          detailLabelText:(NSString *)detailsLabelText
           hideAfterDelay:(NSTimeInterval)delay
               customView:(UIView *)customView
               completion:(ProgressHUDCompletionBlock)completionBlock {
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    hud.removeFromSuperViewOnHide = YES;
    
    if (![customView isEqual:[NSNull null]] && customView) {
        
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = customView;
        if (labelText || labelText.length || ![labelText isEqual:[NSNull null]])   hud.labelText = labelText;
        if (detailsLabelText || detailsLabelText.length || ![detailsLabelText isEqual:[NSNull null]])   hud.detailsLabelText = detailsLabelText;
    }else if (!labelText || !labelText.length || [labelText isEqual:[NSNull null]]) {
        
        hud.mode = MBProgressHUDModeIndeterminate;
    }else{
        
        hud.mode = MBProgressHUDModeText;
        hud.labelText = labelText;
        if (detailsLabelText || detailsLabelText.length || ![detailsLabelText isEqual:[NSNull null]])   hud.detailsLabelText = detailsLabelText;
    }
    if (completionBlock)    hud.completionBlock = completionBlock;
    
    [self addSubview:hud];
    dispatch_async(dispatch_get_main_queue(), ^{
        [hud show:YES];
        if (delay > 0)  [hud hide:YES afterDelay:delay];
    });
}

@end
