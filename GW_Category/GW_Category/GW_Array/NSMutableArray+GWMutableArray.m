//
//  NSMutableArray+GWMutableArray.m
//  Zhuntiku（准题库）
//
//  Created by zdwx on 2019/12/18.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "NSMutableArray+GWMutableArray.h"
#import "NSObject+GWObject.h"
@implementation NSMutableArray (GWMutableArray)
+ (void)load {
    //只执行一次这个方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //替换 objectAtIndex:
        NSString *tmpGetStr = @"objectAtIndex:";
        NSString *safeMutable_GW_objectAtIndex = @"safeMutable_GW_objectAtIndex:";
        [NSObject exchangeInstanceMethod_GW:NSClassFromString(@"__NSArrayM") originalSelector:NSSelectorFromString(tmpGetStr) swizzledSelector:NSSelectorFromString(safeMutable_GW_objectAtIndex)];
        
        //替换 removeObjectsInRange:
        NSString *tmpRemoveStr = @"removeObjectsInRange:";
        NSString *safeMutable_GW_removeObjectsInRange = @"safeMutable_GW_removeObjectsInRange:";
        [NSObject exchangeInstanceMethod_GW:NSClassFromString(@"__NSArrayM") originalSelector:NSSelectorFromString(tmpRemoveStr) swizzledSelector:NSSelectorFromString(safeMutable_GW_removeObjectsInRange)];
        
        //替换 insertObject:atIndex:
        NSString *tmpInsertStr = @"insertObject:atIndex:";
        NSString *safeMutable_GW_insertObject = @"safeMutable_GW_insertObject:atIndex:";
        [NSObject exchangeInstanceMethod_GW:NSClassFromString(@"__NSArrayM") originalSelector:NSSelectorFromString(tmpInsertStr) swizzledSelector:NSSelectorFromString(safeMutable_GW_insertObject)];
        
        //替换 removeObject:inRange:
        NSString *tmpRemoveRangeStr = @"removeObject:inRange:";
        NSString *safeMutable_GW_removeObject = @"safeMutable_GW_removeObject:inRange:";
        [NSObject exchangeInstanceMethod_GW:NSClassFromString(@"__NSArrayM") originalSelector:NSSelectorFromString(tmpRemoveRangeStr) swizzledSelector:NSSelectorFromString(safeMutable_GW_removeObject)];
        
        // 替换 objectAtIndexedSubscript
        NSString *tmpSubscriptStr = @"objectAtIndexedSubscript:";
        NSString *safeMutable_GW_objectAtIndexedSubscript = @"safeMutable_GW_objectAtIndexedSubscript:";
        [NSObject exchangeInstanceMethod_GW:NSClassFromString(@"__NSArrayM") originalSelector:NSSelectorFromString(tmpSubscriptStr) swizzledSelector:NSSelectorFromString(safeMutable_GW_objectAtIndexedSubscript)];
    });
}

#pragma mark --- 防止数组crash
/**
 取出NSArray 第index个 值
 
 @param index 索引 index
 @return 返回值
 */
- (id)safeMutable_GW_objectAtIndex:(NSUInteger)index {
    if (index >= self.count){
        return nil;
    }
    return [self safeMutable_GW_objectAtIndex:index];
}

/**
 NSMutableArray 移除 索引 index 对应的 值
 
 @param range 移除 范围
 */
- (void)safeMutable_GW_removeObjectsInRange:(NSRange)range {
    
    if (range.location > self.count) {
        return;
    }
    
    if (range.length > self.count) {
        return;
    }
    
    if ((range.location + range.length) > self.count) {
        return;
    }
    
    return [self safeMutable_GW_removeObjectsInRange:range];
}


/**
 在range范围内， 移除掉anObject
 
 @param anObject 移除的anObject
 @param range 范围
 */
- (void)safeMutable_GW_removeObject:(id)anObject inRange:(NSRange)range {
    if (range.location > self.count) {
        return;
    }
    
    if (range.length > self.count) {
        return;
    }
    
    if ((range.location + range.length) > self.count) {
        return;
    }
    
    if (!anObject){
        return;
    }
    return [self safeMutable_GW_removeObject:anObject inRange:range];
}

/**
 NSMutableArray 插入 新值 到 索引index 指定位置
 
 @param anObject 新值
 @param index 索引 index
 */
- (void)safeMutable_GW_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (index > self.count) {
        return;
    }
    
    if (!anObject){
        return;
    }
    
    [self safeMutable_GW_insertObject:anObject atIndex:index];
}


/**
 取出NSArray 第index个 值 对应 __NSArrayI
 
 @param idx 索引 idx
 @return 返回值
 */
- (id)safeMutable_GW_objectAtIndexedSubscript:(NSUInteger)idx {
    if (idx >= self.count){
        return nil;
    }
    return [self safeMutable_GW_objectAtIndexedSubscript:idx];
}
@end
