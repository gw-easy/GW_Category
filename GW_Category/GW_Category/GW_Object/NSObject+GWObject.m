//
//  NSObject+GWObject.m
//  Zhuntiku（准题库）
//
//  Created by zdwx on 2019/12/19.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "NSObject+GWObject.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
@implementation NSObject (GWObject)

+ (void)exchangeInstanceOriginalSelector_GW:(SEL)originalSelector
                           swizzledSelector:(SEL)swizzledSelector {
    [self exchangeInstanceMethod_GW:[self class] originalSelector:originalSelector swizzledSelector:swizzledSelector];
}

+ (void)exchangeInstanceMethod_GW:(Class)selfClass
                           originalSelector:(SEL)originalSelector
                           swizzledSelector:(SEL)swizzledSelector {
    Method originalMethod = class_getInstanceMethod(selfClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(selfClass, swizzledSelector);
    BOOL didAddMethod = class_addMethod(selfClass,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(selfClass,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)methodSwizzling_GW:(SEL)systemMethodSel systemClass:(Class)systemClass exchangeMethodSel:(SEL)exchangeMethodSel exchangeClass:(Class)exchangeClass{
    //获取系统方法IMP
    Method sysMethod = class_getInstanceMethod(systemClass, systemMethodSel);
    //自定义方法的IMP
    Method exchangeMethod = class_getInstanceMethod(exchangeClass, exchangeMethodSel);
    //IMP相互交换，方法的实现也就互相交换了
    method_exchangeImplementations(exchangeMethod,sysMethod);
}

@end

#if GW_MemoryLeakDebug
@implementation NSObject (GWObject_MemoryLeak)
- (BOOL)GW_Dealloc {     
    NSString *className = NSStringFromClass([self class]);
    if ([[NSObject classNamesWhitelist] containsObject:className])
        return NO;
    
    NSNumber *senderPtr = objc_getAssociatedObject([UIApplication sharedApplication], gw_sendAction_sender_LastKey);
    if ([senderPtr isEqualToNumber:@((uintptr_t)self)])
        return NO;
    
    __weak id weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf assertNotDealloc];
    });
    
    return YES;
}

- (void)assertNotDealloc {
    NSLog(@"warning - 发生了内存泄漏 - dealloc wrong -  \n %@ ",[self gw_viewStack_array]);
}

- (void)GW_ReleaseObject{
    NSString *className = NSStringFromClass([self class]);
    [self setGw_viewStack_array:[[self gw_viewStack_array] arrayByAddingObject:className]];
    [self setGw_Objc_Ptrs:[[self gw_Objc_Ptrs] setByAddingObject:@((uintptr_t)self)]];
    [self GW_Dealloc];
}

- (void)GW_ReleaseChild:(id)child {
    if (!child) {
        return;
    }
    
    [self GW_ReleaseChildren:@[ child ]];
}

- (void)GW_ReleaseChildren:(NSArray *)children {
    NSSet *parentPtrs = [self gw_Objc_Ptrs];
    for (id child in children) {
        NSString *className = NSStringFromClass([child class]);
        [child setGw_viewStack_array:[[self gw_viewStack_array] arrayByAddingObject:className]];
        [child setGw_Objc_Ptrs:[parentPtrs setByAddingObject:@((uintptr_t)child)]];
        [child GW_Dealloc];
    }
}

- (NSArray *)gw_viewStack_array {
    NSArray *gw_viewStack_array = objc_getAssociatedObject(self, gw_viewStack_key);
    if (gw_viewStack_array) {
        return gw_viewStack_array;
    }
    
    NSString *className = NSStringFromClass([self class]);
    return @[ className ];
}

- (void)setGw_viewStack_array:(NSArray *)gw_viewStack_array {
    objc_setAssociatedObject(self, gw_viewStack_key, gw_viewStack_array, OBJC_ASSOCIATION_RETAIN);
}

- (NSSet *)gw_Objc_Ptrs {
    NSSet *gw_Objc_Ptrs = objc_getAssociatedObject(self, gw_Objc_Ptrs_key);
    if (!gw_Objc_Ptrs) {
        gw_Objc_Ptrs = [[NSSet alloc] initWithObjects:@((uintptr_t)self), nil];
    }
    return gw_Objc_Ptrs;
}

- (void)setGw_Objc_Ptrs:(NSSet *)gw_Objc_Ptrs {
    objc_setAssociatedObject(self, gw_Objc_Ptrs_key, gw_Objc_Ptrs, OBJC_ASSOCIATION_RETAIN);
}

+ (NSMutableSet *)classNamesWhitelist {
    static NSMutableSet *whitelist = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        whitelist = [NSMutableSet setWithObjects:
                     @"UIFieldEditor", // UIAlertControllerTextField
                     @"UINavigationBar",
                     @"_UIAlertControllerActionView",
                     @"_UIVisualEffectBackdropView",
                     nil];
        
        NSString *systemVersion = [UIDevice currentDevice].systemVersion;
        if ([systemVersion compare:@"10.0" options:NSNumericSearch] != NSOrderedAscending) {
            [whitelist addObject:@"UISwitch"];
        }
    });
    return whitelist;
}

+ (void)GW_addClassNamesToWhitelist:(NSArray *)classNames {
    [[self classNamesWhitelist] addObjectsFromArray:classNames];
}

@end
#endif
