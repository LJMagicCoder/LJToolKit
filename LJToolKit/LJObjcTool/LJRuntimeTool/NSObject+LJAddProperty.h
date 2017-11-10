//
//  NSObject+LJAddProperty.h
//  FoundationDemo
//
//  Created by 宋立军 on 2017/9/13.
//  Copyright © 2017年 宋立军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LJAddProperty)

- (void)lj_addStrongPropertyWithValue:(id)value withKey:(void *)key;

- (void)lj_addWeakPropertyWithValue:(id)value withKey:(void *)key;

- (id)lj_getValueForKey:(void *)key;

@end
