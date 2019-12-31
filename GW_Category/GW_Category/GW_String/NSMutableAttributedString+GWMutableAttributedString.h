//
//  NSMutableAttributedString+GWMutableAttributedString.h
//  Zhuntiku（准题库）
//
//  Created by zdwx on 2019/11/29.
//  Copyright © 2019 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN


@interface NSMutableAttributedString (GWMutableAttributedString)


/// 匹配字符，修改符合属性字符串
/// @param text 父文本
/// @param font 字体
/// @param textColor 字体颜色
/// @param InterceptString 截取字符串
+ (NSMutableAttributedString *)gw_stringText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor InterceptString:(NSString *)InterceptString;

+ (NSMutableAttributedString *)gw_stringText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor underLine:(NSUnderlineStyle)underLine InterceptString:(NSString *)InterceptString;

/// 查找子字符串在父字符串中的所有位置
/// @param text 父字符串
/// @param InterceptStr 截取字符串
/// @return 返回位置数组 NSValue
+ (NSMutableArray *)gw_calculateSubString:(NSString *)text InterceptStr:(NSString *)InterceptStr;
@end

NS_ASSUME_NONNULL_END
