//
//  NSObject+LJRuntimeMethod.m
//  FoundationDemo
//
//  Created by 宋立军 on 2017/9/13.
//  Copyright © 2017年 宋立军. All rights reserved.
//

#import "NSObject+LJRuntimeMethod.h"
#import <objc/runtime.h>

@implementation NSObject (LJRuntimeMethod)

BOOL method_swizzle(Class class, SEL firstSEL, SEL secondSEL)
{
    if (!class || !firstSEL || !secondSEL) return NO;
    Method firstMethod = class_getInstanceMethod(class, firstSEL);
    Method secondMethod = class_getInstanceMethod(class, secondSEL);
    if (!firstMethod || !secondMethod) return NO;
    method_exchangeImplementations(firstMethod, secondMethod);
    return YES;
}

+ (BOOL)lj_methodSwizzle:(SEL)firstSEL Method:(SEL)secondSEL {
    return method_swizzle(self, firstSEL, secondSEL);
}

- (BOOL)lj_superRespondsToSelector:(SEL)selector
{
    return [self.superclass instancesRespondToSelector:selector];
}

@end
