//
//  NSSet+LJNSSetMethod.m
//  FoundationDemo
//
//  Created by 宋立军 on 2017/9/13.
//  Copyright © 2017年 宋立军. All rights reserved.
//

#import "NSSet+LJNSSetMethod.h"

@implementation NSSet (LJNSSetMethod)

- (NSArray *)lj_map:(id (^)(id object))block {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    
    [self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        id mapObject = block(obj);
        if(mapObject) {
            [array addObject:mapObject];
        }
    }];
    return array;
}

- (void)lj_each:(void (^)(id))block {
    [self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        block(obj);
    }];
}

- (void)lj_eachWithIndex:(void (^)(id, int))block {
    __block int count = 0;
    [self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        block(obj, count);
        count ++;
    }];
}

- (NSArray *)lj_select:(BOOL (^)(id object))block {
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    
    [self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        if (block(obj)) {
            [array addObject:obj];
        }
    }];
    return array;
}

@end
