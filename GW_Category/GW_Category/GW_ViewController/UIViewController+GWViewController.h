//
//  UIViewController+GWViewController.h
//  GW_Category
//
//  Created by zdwx on 2019/12/30.
//  Copyright © 2019 gw. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (GWViewController)


/// 在viewDidDisappear实现 返回ture 则表示控制器应该销毁了，可在此将定时器或者其他引用进行销毁操作
- (BOOL)isDidDisappearAndDeallocVC;

@end

NS_ASSUME_NONNULL_END
