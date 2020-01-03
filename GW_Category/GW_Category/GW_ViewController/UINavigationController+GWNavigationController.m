//
//  UINavigationController+GWNavigationController.m
//  GW_Category
//
//  Created by zdwx on 2020/1/2.
//  Copyright © 2020 gw. All rights reserved.
//

#import "UINavigationController+GWNavigationController.h"
#import "NSObject+GWObject.h"
#import <objc/runtime.h>
#import "UIViewController+GWViewController.h"
@implementation UINavigationController (GWNavigationController)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self exchangeInstanceOriginalSelector_GW:@selector(pushViewController:animated:) swizzledSelector:@selector(gw_pushViewController:animated:)];
        [self exchangeInstanceOriginalSelector_GW:@selector(popViewControllerAnimated:) swizzledSelector:@selector(gw_popViewControllerAnimated:)];
        [self exchangeInstanceOriginalSelector_GW:@selector(popToViewController:animated:) swizzledSelector:@selector(gw_popToViewController:animated:)];
        [self exchangeInstanceOriginalSelector_GW:@selector(popToRootViewControllerAnimated:) swizzledSelector:@selector(gw_popToRootViewControllerAnimated:)];
    });
}

- (void)gw_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
#if GW_MemoryLeakDebug
    if (self.splitViewController) {
        id detailViewController = objc_getAssociatedObject(self, gw_splitVC_HasPop_key);
        if ([detailViewController isKindOfClass:[UIViewController class]]) {
            [detailViewController GW_Dealloc];
            objc_setAssociatedObject(self, gw_splitVC_HasPop_key, nil, OBJC_ASSOCIATION_RETAIN);
        }
    }
#endif
    [self gw_pushViewController:viewController animated:animated];
}

- (UIViewController *)gw_popViewControllerAnimated:(BOOL)animated{
    UIViewController *poppedViewController = [self gw_popViewControllerAnimated:animated];
    
    if (!poppedViewController) {
        return nil;
    }
#if GW_MemoryLeakDebug
    if (self.splitViewController &&
        self.splitViewController.viewControllers.firstObject == self &&
        self.splitViewController == poppedViewController.splitViewController) {
        objc_setAssociatedObject(self, gw_splitVC_HasPop_key, poppedViewController, OBJC_ASSOCIATION_RETAIN);
        return poppedViewController;
    }
#endif
    [poppedViewController setGw_isDidDisappearAndDeallocVC:YES];
    return poppedViewController;
}

- (NSArray<UIViewController *> *)gw_popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIViewController *popVC = self.topViewController;
    NSArray<UIViewController *> *poppedViewControllers = [self gw_popToViewController:viewController animated:animated];
    for (UIViewController *viewController in poppedViewControllers) {
        [viewController setGw_isDidDisappearAndDeallocVC:YES];
        if (popVC == viewController) {
            continue;
        }
        [viewController viewDidDisappear:NO];
    }
    return poppedViewControllers;
}

- (NSArray<UIViewController *> *)gw_popToRootViewControllerAnimated:(BOOL)animated{
    UIViewController *popVC = self.topViewController;
    NSArray<UIViewController *> *poppedViewControllers = [self gw_popToRootViewControllerAnimated:animated];
    for (UIViewController *viewController in poppedViewControllers) {
        [viewController setGw_isDidDisappearAndDeallocVC:YES];
        if (popVC == viewController) {
            continue;
        }
        [viewController viewDidDisappear:NO];
    }
    return poppedViewControllers;
}

@end
