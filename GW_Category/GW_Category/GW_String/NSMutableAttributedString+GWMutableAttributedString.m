//
//  NSMutableAttributedString+GWMutableAttributedString.m
//  Zhuntiku（准题库）
//
//  Created by zdwx on 2019/11/29.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "NSMutableAttributedString+GWMutableAttributedString.h"

@implementation NSMutableAttributedString (GWMutableAttributedString)

+ (NSMutableAttributedString *)gw_stringText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor InterceptString:(NSString *)InterceptString{
    NSArray *interceptArr = [self gw_calculateSubString:text InterceptStr:InterceptString];
    NSMutableAttributedString *muAttrStr = [[NSMutableAttributedString alloc] initWithString:text];
    for (NSValue *value in interceptArr) {
        NSRange range = [value rangeValue];
        if (font) {
            [muAttrStr addAttribute:NSFontAttributeName value:font range:range];
        }
        if (textColor) {
            [muAttrStr addAttribute:NSForegroundColorAttributeName value:textColor range:range];
        }
    }
    return muAttrStr;
}

+ (NSMutableAttributedString *)gw_stringText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor underLine:(NSUnderlineStyle)underLine InterceptString:(NSString *)InterceptString{
    NSArray *interceptArr = [self gw_calculateSubString:text InterceptStr:InterceptString];
    NSMutableAttributedString *muAttrStr = [[NSMutableAttributedString alloc] initWithString:text];
    for (NSValue *value in interceptArr) {
        NSRange range = [value rangeValue];
        if (font) {
            [muAttrStr addAttribute:NSFontAttributeName value:font range:range];
        }
        if (textColor) {
            [muAttrStr addAttribute:NSForegroundColorAttributeName value:textColor range:range];
        }
        if (underLine && underLine != NSUnderlineStyleNone) {
            [muAttrStr addAttribute:NSUnderlineStyleAttributeName value:@(underLine) range:range];
        }
    }
    
    
    return muAttrStr;
}

+ (NSMutableArray *)gw_calculateSubString:(NSString *)text InterceptStr:(NSString *)InterceptStr{
    int location = 0;
    NSMutableArray *locationArr = [NSMutableArray new];
    NSRange range = [text rangeOfString:InterceptStr];
    if (range.location == NSNotFound){
        return locationArr;
    }
    //声明一个临时字符串,记录截取之后的字符串
    NSString *subStr = [text copy];
    while (range.location != NSNotFound) {
        [locationArr addObject:[NSValue valueWithRange:range]];
        if (location == 0) {
            location += range.location;
        } else {
            location += range.location + InterceptStr.length;
        }
        //记录位置
        NSNumber *number = [NSNumber numberWithUnsignedInteger:location];
        [locationArr addObject:number];
        //每次记录之后,把找到的字串截取掉
        subStr = [subStr substringFromIndex:range.location + range.length];
//        NSLog(@"subStr %@",subStr);
        range = [subStr rangeOfString:InterceptStr];
//        NSLog(@"rang %@",NSStringFromRange(range));
    }
    return locationArr;
}
@end
