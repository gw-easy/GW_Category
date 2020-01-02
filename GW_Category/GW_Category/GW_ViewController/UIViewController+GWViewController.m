//
//  UIViewController+GWViewController.m
//  GW_Category
//
//  Created by zdwx on 2019/12/30.
//  Copyright © 2019 gw. All rights reserved.
//

#import "UIViewController+GWViewController.h"
#import "NSObject+GWObject.h"
#import <objc/runtime.h>

@implementation UIViewController (GWViewController)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self exchangeInstanceMethod_GW:[self class] originalSelector:@selector(presentViewController:animated:completion:) swizzledSelector:@selector(GW_presentViewController:animated:completion:)];
        
        [self exchangeInstanceOriginalSelector_GW:@selector(viewWillAppear:) swizzledSelector:@selector(gw_viewWillAppear:)];
        [self exchangeInstanceOriginalSelector_GW:@selector(viewDidDisappear:) swizzledSelector:@selector(gw_viewDidDisappear:)];
        [self exchangeInstanceOriginalSelector_GW:@selector(dismissViewControllerAnimated:completion:) swizzledSelector:@selector(gw_dismissViewControllerAnimated:completion:)];
    });
}

- (void)gw_viewWillAppear:(BOOL)animated{
    [self gw_viewWillAppear:animated];
    objc_setAssociatedObject(self, gw_VC_HasPop_key, @(NO), OBJC_ASSOCIATION_RETAIN);
}

- (void)gw_viewDidDisappear:(BOOL)animated{
    [self gw_viewDidDisappear:animated];
#if GW_MemoryLeakDebug
    if ([objc_getAssociatedObject(self, gw_VC_HasPop_key) boolValue]) {
        [self GW_Dealloc];
    }
#endif
}

- (void)gw_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    UIViewController *dismissedViewController = nil;
    if (self.navigationController && self.navigationController.childViewControllers.count > 1) {
        dismissedViewController = self.navigationController.childViewControllers.firstObject;
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    if (!dismissedViewController) {
        dismissedViewController = self.presentedViewController;
    }
    if (!dismissedViewController) {
        dismissedViewController = self;
    }
    if (!dismissedViewController) return;
    [dismissedViewController gw_dismissViewControllerAnimated:flag completion:completion];
#if GW_MemoryLeakDebug
    [dismissedViewController GW_Dealloc];
#endif
}

#if GW_MemoryLeakDebug
- (BOOL)GW_Dealloc {
    if (![super GW_Dealloc]) {
        return NO;
    }
    [self GW_ReleaseChildren:self.childViewControllers];
    if (![self isKindOfClass:[UINavigationController class]] && ![self isKindOfClass:[UIPageViewController class]] && ![self isKindOfClass:[UITabBarController class]]) {
        [self GW_ReleaseChild:self.presentedViewController];
        if (self.isViewLoaded) {
            [self GW_ReleaseChild:self.view];
        }
    }
    return YES;
}
#endif

- (BOOL)isDidDisappearAndDeallocVC{
    return [objc_getAssociatedObject(self, gw_VC_HasPop_key) boolValue];
}

- (void)GW_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
//    兼容ios 13
    if (![viewControllerToPresent isKindOfClass:[UIImagePickerController class]]) {
        viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
    }
//    防止相册控制器crash
    if ([viewControllerToPresent isKindOfClass:[UIImagePickerController class]]) {
        viewControllerToPresent.modalPresentationStyle = UIModalPresentationCustom;
    }
    [self GW_presentViewController:viewControllerToPresent animated:flag completion:completion];
}






@end
