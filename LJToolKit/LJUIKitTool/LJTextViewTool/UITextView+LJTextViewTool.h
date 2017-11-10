//
//  UITextView+LJTextViewTool.h
//  TextViewToolDemo
//
//  Created by 宋立军 on 2017/7/12.
//  Copyright © 2017年 宋立军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (LJTextViewTool)

@property (nonatomic, strong ,readonly) UILabel *placeholderLabel;

- (void)lj_maxTextLength:(NSInteger)length arriveMax:(void(^)())block;

@end
