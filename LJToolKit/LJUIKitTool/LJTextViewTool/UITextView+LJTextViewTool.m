//
//  UITextView+LJTextViewTool.m
//  TextViewToolDemo
//
//  Created by 宋立军 on 2017/7/12.
//  Copyright © 2017年 宋立军. All rights reserved.
//

#import "UITextView+LJTextViewTool.h"
#import <objc/runtime.h>

@interface PlaceholderLabel : UILabel @end

@implementation PlaceholderLabel : UILabel

-(void)setText:(NSString *)text {
    [super setText:text];
    
    CGFloat defaultSpacing = 5;
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(CGRectGetWidth([self superview].frame) - defaultSpacing, CGFLOAT_MAX)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName:self.font}
                                          context:nil];
    self.frame = CGRectMake(defaultSpacing, defaultSpacing + 2, rect.size.width, rect.size.height);
}

@end

static char maxLength;

static char maxBlock;

@implementation UITextView (LJTextViewTool)

- (UILabel *)placeholderLabel {
    UILabel *placeholderLabel = objc_getAssociatedObject(self, _cmd);
    if (!placeholderLabel) {
        
        PlaceholderLabel *placeholderLabel = [[PlaceholderLabel alloc] init];
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.textColor = [UIColor lightGrayColor];
        placeholderLabel.font = self.font ? self.font : [UIFont systemFontOfSize:17];
        placeholderLabel.hidden = self.text.length > 0 ? YES : NO;
        placeholderLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:placeholderLabel];
        
        [self addObserver:self forKeyPath:@"font" options:NSKeyValueObservingOptionNew context:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewChanged:) name:UITextViewTextDidChangeNotification object:self];
        
        self.placeholderLabel = placeholderLabel;
    }
    return placeholderLabel;
}

- (void)setPlaceholderLabel:(UILabel *)placeholderLabel {
    objc_setAssociatedObject(self, @selector(placeholderLabel), placeholderLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self && [keyPath isEqualToString:@"font"]){
        self.placeholderLabel.font = [change objectForKey:@"new"];
        self.placeholderLabel.text = self.placeholderLabel.text;    //重新设置一遍Label大小
    }
}

- (void)dealloc {
    if (objc_getAssociatedObject(self, @selector(placeholderLabel))) {
        [self removeObserver:self forKeyPath:@"font"];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
    }
}

#pragma mark - NSNotification
- (void)textViewChanged:(NSNotification *)notification {
    
    NSInteger max = [objc_getAssociatedObject(self, &maxLength) integerValue];
    void(^block)() = objc_getAssociatedObject(self, &maxBlock);
    
    if (max && self.text.length > max) {
        self.text = [self.text substringToIndex:max];
        if (block) block();
    }
    self.placeholderLabel.hidden = self.text.length;
}

#pragma mark - 最大输入数
- (void)lj_maxTextLength:(NSInteger)length arriveMax:(void(^)())block {
    if (length > 0) objc_setAssociatedObject(self, &maxLength, @(length), OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, &maxBlock, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


@end
