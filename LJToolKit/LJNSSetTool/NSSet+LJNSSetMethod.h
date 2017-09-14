//
//  NSSet+LJNSSetMethod.h
//  FoundationDemo
//
//  Created by 宋立军 on 2017/9/13.
//  Copyright © 2017年 宋立军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSSet (LJNSSetMethod)

- (NSArray *)lj_map:(id (^)(id object))block;

- (void)lj_each:(void (^)(id))block;

- (void)lj_eachWithIndex:(void (^)(id, int))block;

- (NSArray *)lj_select:(BOOL (^)(id object))block;

@end
