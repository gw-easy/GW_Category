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

/**
 检查导航控制器是否存在某个子控制器
 existC 存在的控制器
 */
- (BOOL)GW_ExistNavSubVC:(Class)existC;

/**
 pop到指定控制器
 popC pop的控制器
 */
- (void)GW_PopToVC:(Class)popC;
@end

NS_ASSUME_NONNULL_END
