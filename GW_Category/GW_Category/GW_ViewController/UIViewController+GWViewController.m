//
//  UIViewController+GWViewController.m
//  GW_Category
//
//  Created by zdwx on 2019/12/30.
//  Copyright © 2019 gw. All rights reserved.
//

#import "UIViewController+GWViewController.h"
#import "NSObject+GWObject.h"


@implementation UIViewController (GWViewController)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self exchangeInstanceMethod_GW:[self class] originalSelector:@selector(presentViewController:animated:completion:) swizzledSelector:@selector(GW_presentViewController:animated:completion:)];
    });
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

- (BOOL)canDismiss_GW{
    return self.presentingViewController?YES:NO;
}

- (BOOL)canPop_GW{
    if (self.navigationController && self.navigationController.childViewControllers.count > 1) {
        return YES;
    }
    return NO;
}

- (BOOL)isLastVC{
    return self.navigationController.childViewControllers.lastObject == self;
}

- (BOOL)isWillDisappearAndDeallocVC{
    if (self.presentingViewController && !self.presentedViewController) {
        if ([self canPop_GW] && [self isLastVC]) {
            return YES;
        }
        if (![self canPop_GW]) {
            return YES;
        }
//        return NO;
    }
    
    if ([self canPop_GW] && ![self isLastVC]) {
        
        return YES;
    }
//    if (self.presentingViewController && !self.presentedViewController && !self.navigationController) {
//        return YES;
//    }
//    if (self.navigationController && self.navigationController.childViewControllers && !self.presentingViewController) {
//        return ![self.navigationController.childViewControllers containsObject:self];
//    }
    return NO;
}

@end
