//
//  UITouch+GWTouch.m
//  GW_Category
//
//  Created by zdwx on 2020/1/2.
//  Copyright © 2020 gw. All rights reserved.
//

#import "UITouch+GWTouch.h"
#import "NSObject+GWObject.h"
#import <objc/runtime.h>
@implementation UITouch (GWTouch)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
#ifdef GW_MemoryLeakDebug
        [self exchangeInstanceMethod_GW:[self class] originalSelector:@selector(setView:) swizzledSelector:@selector(gw_setView:)];
#endif
    });
}

#pragma mark - 检测leak
- (void)gw_setView:(UIView *)view{
    [self gw_setView:view];
    if (view) {
        objc_setAssociatedObject([UIApplication sharedApplication],
                                 gw_sendAction_sender_LastKey,
                                 @((uintptr_t)view),
                                 OBJC_ASSOCIATION_RETAIN);
    }
}



@end
