//
//  NSObject+GWObject.m
//  Zhuntiku（准题库）
//
//  Created by zdwx on 2019/12/19.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "NSObject+GWObject.h"
#import <objc/runtime.h>
@implementation NSObject (GWObject)

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
