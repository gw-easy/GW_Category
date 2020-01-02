//
//  UIApplication+GWApplication.m
//  GW_Category
//
//  Created by zdwx on 2020/1/2.
//  Copyright © 2020 gw. All rights reserved.
//

#import "UIApplication+GWApplication.h"
#import "NSObject+GWObject.h"
#import <objc/runtime.h>

@implementation UIApplication (GWApplication)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
#ifdef GW_MemoryLeakDebug
        [self exchangeInstanceMethod_GW:[self class] originalSelector:@selector(sendAction:to:from:forEvent:) swizzledSelector:@selector(gw_sendAction:to:from:forEvent:)];
#endif
    });
}

- (BOOL)gw_sendAction:(SEL)action to:(nullable id)target from:(nullable id)sender forEvent:(nullable UIEvent *)event{
    objc_setAssociatedObject(self, gw_sendAction_sender_LastKey, @((uintptr_t)sender), OBJC_ASSOCIATION_RETAIN);
    return [self gw_sendAction:action to:target from:sender forEvent:event];
}

@end
