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
        [self exchangeInstanceOriginalSelector_GW:@selector(setViewControllers:animated:) swizzledSelector:@selector(gw_setViewControllers:animated:)];
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
    NSArray<UIViewController *> *poppedViewControllers = [self gw_popToViewController:viewController animated:animated];
    for (UIViewController *viewController in poppedViewControllers) {
        [viewController setGw_isDidDisappearAndDeallocVC:YES];
        [viewController viewDidDisappear:NO];
    }
    return poppedViewControllers;
}

- (NSArray<UIViewController *> *)gw_popToRootViewControllerAnimated:(BOOL)animated{
    NSArray<UIViewController *> *childArray = self.childViewControllers;
    NSArray<UIViewController *> *poppedViewControllers = [self gw_popToRootViewControllerAnimated:animated];
    if (childArray && (childArray.count - poppedViewControllers.count != 1)) {
        poppedViewControllers = [childArray subarrayWithRange:NSMakeRange(1, childArray.count-1)];
    }
    for (UIViewController *viewController in poppedViewControllers) {
        [viewController setGw_isDidDisappearAndDeallocVC:YES];
        [viewController viewDidDisappear:NO];
    }
    return poppedViewControllers;
}

- (void)gw_setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated{
    if (!viewControllers || viewControllers.count < 1) {
        return;
    }
    NSPredicate * filterPredicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",viewControllers];
    NSArray * reslutFilteredArray = [self.viewControllers filteredArrayUsingPredicate:filterPredicate];
    for (UIViewController *viewController in reslutFilteredArray) {
        [viewController setGw_isDidDisappearAndDeallocVC:YES];
        [viewController viewDidDisappear:NO];
    }
    [self gw_setViewControllers:viewControllers animated:animated];
}

//销毁子控制器
- (void)GW_RemoveNavSubVC:(Class)removeC{
    if (self.viewControllers) {
        NSMutableArray *array = self.viewControllers.mutableCopy;
        for (UIViewController *troll in array) {
            if ([troll isKindOfClass:removeC]) {
                [array removeObject:troll];
                break;
            }
        }
        [self setViewControllers:array animated:NO];
    }
}



@end
