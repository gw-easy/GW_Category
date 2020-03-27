//
//  NSString+GWString.h
//  Zhuntiku（准题库）
//
//  Created by zdwx on 2019/11/27.
//  Copyright © 2019 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSString (GWString)


#pragma mark - 计算高度

/// 计算文字高度 - 返回高度 
/// @param font 字体大小
/// @param maxWidth 最大宽度
- (CGFloat)gw_stringSizeWithFont:(CGFloat)font maxWidth:(CGFloat)maxWidth;

/// 计算文字高度 - 返回size
/// @param font 字体大小
/// @param maxSize 尺寸
- (CGSize)gw_stringSizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;


#pragma mark - 拼接url

/// 拼接url - 字典
/// @param dict 数据
- (NSString *)gw_stringAppentUrlForDictionary:(NSDictionary *)dict;

/// 拼接url - 单一
/// @param value value
/// @param key key
- (NSString *)gw_stringAppentUrlForValue:(NSString *)value key:(NSString *)key;

#pragma mark - 替换成属性字符串 - 局部文本替换
/// 匹配字符，给字符添加属性
/// @param needReplaceString 需要匹配的字符串
/// @param font 字体
/// @param textColor 字体颜色
/// @param underLine 下划线
- (NSMutableAttributedString *)gw_stringNeedReplaceString:(NSString *)needReplaceString Font:(nullable UIFont *)font textColor:(nullable UIColor *)textColor underLine:(NSUnderlineStyle)underLine;


/// 匹配字符，给字符添加属性
/// @param needReplaceString  需要匹配的字符串
/// @param dict 属性字典
- (NSMutableAttributedString *)gw_stringNeedReplaceString:(NSString *)needReplaceString dict:(nullable NSDictionary *)dict;

/// 查找子字符串在父字符串中的所有位置
/// @param needReplaceString 截取字符串
/// @return 返回位置数组 NSValue（NSRange）
- (NSMutableArray *)gw_calculateNeedReplaceStringStr:(NSString *)needReplaceString;

#pragma mark - 转码

/// 转码 - urf8 - url
- (NSString *)gw_stringEscapesUsingEncodingUTF8;

#pragma mark - 删除首尾空白 空格
- (NSString *)gw_stringByTrimmingWhiteSpace;

#pragma mark - 判断是否为空
- (BOOL)gw_isEmptyString;

#pragma mark - 验证个人信息

/// 验证手机号 - 只验证是否是11位和首位是不是1
- (BOOL)gw_isMobileNumber;

/// 验证密码 - 密码只包含字母，数字，字符中至少两种
- (BOOL)gw_checkPassword;

/// 验证是否包含中文
- (BOOL)gw_checkHasChinese;

/// 四舍不五入 获取字符小数点
/// @param price 数值
/// @param position 保留小数点多少位
- (NSString *)gw_notRounding:(double)price afterPoint:(int)position;
@end

NS_ASSUME_NONNULL_END
