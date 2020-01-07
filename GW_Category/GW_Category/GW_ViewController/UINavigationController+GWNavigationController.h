//
//  UINavigationController+GWNavigationController.h
//  GW_Category
//
//  Created by zdwx on 2020/1/2.
//  Copyright © 2020 gw. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (GWNavigationController)


/// 移除子控制器
/// @param removeC 需要移除的类
- (void)GW_RemoveNavSubVC:(Class)removeC;

@end

NS_ASSUME_NONNULL_END
