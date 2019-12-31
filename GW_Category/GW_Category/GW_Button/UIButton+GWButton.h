//
//  UIButton+GWButton.h
//  Zhuntiku（准题库）
//
//  Created by zdwx on 2019/12/9.
//  Copyright © 2019 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (GWButton)

#pragma mark - 改变按钮颜色


/// 改变按钮颜色
/// @param title 标题
/// @param titleColor 标题颜色
/// @param imageName 图片名
/// @param backColor 背景颜色
/// @param backImageName 背景图片
- (void)gw_changeBtnTitle:(NSString *)title titleColor:(UIColor *)titleColor imageName:(NSString *)imageName backColor:(UIColor *)backColor backImageName:(NSString *)backImageName;
@end

NS_ASSUME_NONNULL_END
