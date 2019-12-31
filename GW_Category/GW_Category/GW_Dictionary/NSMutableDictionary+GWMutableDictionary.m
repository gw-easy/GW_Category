//
//  NSMutableDictionary+GWMutableDictionary.m
//  Zhuntiku（准题库）
//
//  Created by zdwx on 2019/12/18.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "NSMutableDictionary+GWMutableDictionary.h"
#import "NSObject+GWObject.h"
@implementation NSMutableDictionary (GWMutableDictionary)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 替换 removeObjectForKey:
        NSString *tmpRemoveStr = @"removeObjectForKey:";
        NSString *safeMutable_GW_removeObjectForKey = @"safeMutable_GW_removeObjectForKey:";
        [NSObject exchangeInstanceMethod_GW:NSClassFromString(@"__NSDictionaryM") originalSelector:NSSelectorFromString(tmpRemoveStr) swizzledSelector:NSSelectorFromString(safeMutable_GW_removeObjectForKey)];
        
        // 替换 setObject:forKey:
        NSString *tmpSetStr = @"setObject:forKey:";
        NSString *safeMutable_GW_setObject = @"safeMutable_GW_setObject:forKey:";
        [NSObject exchangeInstanceMethod_GW:NSClassFromString(@"__NSDictionaryM") originalSelector:NSSelectorFromString(tmpSetStr) swizzledSelector:NSSelectorFromString(safeMutable_GW_setObject)];
    });
}

#pragma mark --- 防止字典crash

/**
 根据akey 移除 对应的 键值对
 
 @param aKey key
 */
- (void)safeMutable_removeObjectForKey:(id<NSCopying>)aKey {
    if (!aKey) {
        return;
    }
    [self safeMutable_removeObjectForKey:aKey];
}

/**
 将键值对 添加 到 NSMutableDictionary 内
 
 @param anObject 值
 @param aKey 键
 */
- (void)safeMutable_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (!anObject) {
        return;
    }
    if (!aKey) {
        return;
    }
    return [self safeMutable_setObject:anObject forKey:aKey];
}
@end
