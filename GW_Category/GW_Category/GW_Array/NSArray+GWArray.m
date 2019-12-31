//
//  NSArray+GWArray.m
//  Zhuntiku（准题库）
//
//  Created by zdwx on 2019/12/18.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "NSArray+GWArray.h"
#import "NSObject+GWObject.h"
@implementation NSArray (GWArray)

+ (void)load {
    //只执行一次这个方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //替换 objectAtIndex
        NSString *objectAtIndex = @"objectAtIndex:";
        NSString *safe_array0_objectAtIndex_GW = @"safe_array0_objectAtIndex_GW:";
        NSString *safe_arrayI_objectAtIndex_GW = @"safe_arrayI_objectAtIndex_GW:";
        NSString *safe_single_objectAtIndex_GW = @"safe_single_objectAtIndex_GW:";
        [NSObject exchangeInstanceMethod_GW:NSClassFromString(@"__NSArray0") originalSelector:NSSelectorFromString(objectAtIndex) swizzledSelector:NSSelectorFromString(safe_array0_objectAtIndex_GW)];
        [NSObject exchangeInstanceMethod_GW:NSClassFromString(@"__NSSingleObjectArrayI") originalSelector:NSSelectorFromString(objectAtIndex) swizzledSelector:NSSelectorFromString(safe_single_objectAtIndex_GW)];
        [NSObject exchangeInstanceMethod_GW:NSClassFromString(@"__NSArrayI") originalSelector:NSSelectorFromString(objectAtIndex) swizzledSelector:NSSelectorFromString(safe_arrayI_objectAtIndex_GW)];
        
        // 替换 objectAtIndexedSubscript
        NSString *objectAtIndexedSubscript = @"objectAtIndexedSubscript:";
        NSString *safe_ArrayI_objectAtIndexedSubscript_GW = @"safe_ArrayI_objectAtIndexedSubscript_GW:";
        [NSObject exchangeInstanceMethod_GW:NSClassFromString(@"__NSArrayI") originalSelector:NSSelectorFromString(objectAtIndexedSubscript) swizzledSelector:NSSelectorFromString(safe_ArrayI_objectAtIndexedSubscript_GW)];
    });
}

#pragma mark --- 防止数组crash
/**
 取出NSArray 第index个 值 对应 __NSArrayI
 
 @param index 索引 index
 @return 返回值
 */
- (id)safe_arrayI_objectAtIndex_GW:(NSUInteger)index {
    if (index >= self.count){
        return nil;
    }
    return [self safe_arrayI_objectAtIndex_GW:index];
}


/**
 取出NSArray 第index个 值 对应 __NSSingleObjectArrayI
 
 @param index 索引 index
 @return 返回值
 */
- (id)safe_single_objectAtIndex_GW:(NSUInteger)index {
    if (index >= self.count){
        return nil;
    }
    return [self safe_single_objectAtIndex_GW:index];
}

/**
 取出NSArray 第index个 值 对应 __NSArray0
 
 @param index 索引 index
 @return 返回值
 */
- (id)safe_array0_objectAtIndex_GW:(NSUInteger)index {
    if (index >= self.count){
        return nil;
    }
    return [self safe_array0_objectAtIndex_GW:index];
}

/**
 取出NSArray 第index个 值 对应 __NSArrayI
 
 @param idx 索引 idx
 @return 返回值
 */
- (id)safe_ArrayI_objectAtIndexedSubscript_GW:(NSUInteger)idx {
    if (idx >= self.count){
        return nil;
    }
    return [self safe_ArrayI_objectAtIndexedSubscript_GW:idx];
}



- (BOOL)isEmpty_GW{
    if (!self || self.count < 1) {
        return YES;
    }
    return NO;
}

@end
