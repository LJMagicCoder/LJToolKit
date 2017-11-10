//
//  NSObject+LJAddProperty.m
//  FoundationDemo
//
//  Created by 宋立军 on 2017/9/13.
//  Copyright © 2017年 宋立军. All rights reserved.
//

#import "NSObject+LJAddProperty.h"
#import <objc/runtime.h>

@implementation NSObject (LJAddProperty)

- (void)lj_addStrongPropertyWithValue:(id)value withKey:(void *)key
{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN);
}

- (void)lj_addWeakPropertyWithValue:(id)value withKey:(void *)key
{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

- (id)lj_getValueForKey:(void *)key
{
    return objc_getAssociatedObject(self, key);
}

@end
