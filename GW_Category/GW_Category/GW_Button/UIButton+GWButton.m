//
//  UIButton+GWButton.m
//  Zhuntiku（准题库）
//
//  Created by zdwx on 2019/12/9.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "UIButton+GWButton.h"

@implementation UIButton (GWButton)


- (void)gw_changeBtnTitle:(NSString *)title titleColor:(UIColor *)titleColor imageName:(NSString *)imageName backColor:(UIColor *)backColor backImageName:(NSString *)backImageName{
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    
    if (CGColorEqualToColor(titleColor.CGColor,[UIColor whiteColor].CGColor)) {
        UIImage *btnI = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self setImage:btnI forState:UIControlStateNormal];
    }else{
        UIImage *btnI = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [self setImage:btnI forState:UIControlStateNormal];
        [self setTintColor:titleColor];
    }
    
    if (backImageName) {
        UIImage *backI = [[UIImage imageNamed:backImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [self setTintColor:backColor];
        [self setBackgroundImage:backI forState:UIControlStateNormal];
    }else{
        [self setBackgroundImage:nil forState:UIControlStateNormal];
    }

}
@end
