//
//  NSObject+LJRuntimeMethod.h
//  FoundationDemo
//
//  Created by 宋立军 on 2017/9/13.
//  Copyright © 2017年 宋立军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LJRuntimeMethod)

//交换方法
+ (BOOL)lj_methodSwizzle:(SEL)firstSEL Method:(SEL)secondSEL;

- (BOOL)lj_superRespondsToSelector:(SEL)selector;

@end
