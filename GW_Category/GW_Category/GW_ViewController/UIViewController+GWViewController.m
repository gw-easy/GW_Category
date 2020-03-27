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
        
        [self exchangeInstanceOriginalSelector_GW:@selector(viewDidLoad) swizzledSelector:@selector(gw_viewDidLoad)];
        [self exchangeInstanceOriginalSelector_GW:@selector(viewDidDisappear:) swizzledSelector:@selector(gw_viewDidDisappear:)];
        [self exchangeInstanceOriginalSelector_GW:@selector(dismissViewControllerAnimated:completion:) swizzledSelector:@selector(gw_dismissViewControllerAnimated:completion:)];
    });
}

- (void)gw_viewDidLoad{
    [self gw_viewDidLoad];
    [self setGw_isDidDisappearAndDeallocVC:NO];
}

- (void)gw_viewDidDisappear:(BOOL)animated{
    [self gw_viewDidDisappear:animated];
#if GW_MemoryLeakDebug
    if (self.gw_isDidDisappearAndDeallocVC) {
        [self GW_Dealloc];
    }
#endif
}

- (void)gw_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    UIViewController *dismissedViewController = self;
    if (!self.presentedViewController && self.presentingViewController) {
//        self.navigationController
        dismissedViewController = [self dismissNavVC:self needDealloc:NO];
        if (dismissedViewController.presentingViewController) {
            [dismissedViewController setGw_isDidDisappearAndDeallocVC:YES];
        }
    }
    [dismissedViewController gw_dismissViewControllerAnimated:flag completion:completion];
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


- (void)gw_dismissToViewController:(NSString *)className animated:(BOOL)animated{
    [[self getRootController:className] dismissViewControllerAnimated:animated completion:nil];
}
 
-(void)gw_dismissToRootViewControllerAnimated:(BOOL)animated{
    [[self getRootController:nil] dismissViewControllerAnimated:animated completion:nil];
}

//privacy
- (UIViewController*)getRootController:(NSString*)className{
    if (!className) {
        //直接跳转到根视图控制器
        UIViewController *presentingVc = self;
        while (presentingVc.presentingViewController) {
            presentingVc = [presentingVc dismissNavVC:presentingVc needDealloc:YES];
            presentingVc = presentingVc.presentingViewController;
        }
        return presentingVc;
    }
    
    Class cName = NSClassFromString(className);
    if (!cName){
        return nil;
    }
    
    UIViewController *presentingVc = self;
    while (presentingVc.presentingViewController) {
        presentingVc = [self dismissNavVC:presentingVc needDealloc:YES];
        presentingVc = presentingVc.presentingViewController;
        if ([presentingVc isKindOfClass:[UINavigationController class]]) {
            for (UIViewController *subVC in presentingVc.childViewControllers) {
                if ([subVC isMemberOfClass:cName]) {
                    return presentingVc;
                }
            }
        }
        if ([presentingVc isMemberOfClass:cName]) {
            break;
        }
    }
    return presentingVc;
 
}

- (UIViewController *)dismissNavVC:(UIViewController *)vc needDealloc:(BOOL)needDealloc{
    UIViewController *dismissedViewController = nil;
    UINavigationController *dismissNavVC = vc.navigationController;
    
    if (!dismissNavVC && [vc isKindOfClass:[UINavigationController class]]) {
        dismissNavVC = (UINavigationController *)vc;
    }
    if (dismissNavVC && dismissNavVC.childViewControllers.count > 0) {
        dismissedViewController = dismissNavVC.childViewControllers.firstObject;
        [dismissNavVC popToRootViewControllerAnimated:NO];
    }
    if (!dismissedViewController) {
        dismissedViewController = vc;
    }
    if (needDealloc) {
        [dismissedViewController setGw_isDidDisappearAndDeallocVC:YES];
    }
    return dismissedViewController;
}

#pragma mark - isDidDisappearAndDeallocVC
- (void)setGw_isDidDisappearAndDeallocVC:(BOOL)gw_isDidDisappearAndDeallocVC{
     objc_setAssociatedObject(self, @selector(gw_isDidDisappearAndDeallocVC), @(gw_isDidDisappearAndDeallocVC), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)gw_isDidDisappearAndDeallocVC{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

#pragma mark - presentViewController
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
