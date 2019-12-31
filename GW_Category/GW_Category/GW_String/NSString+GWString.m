//
//  NSString+GWString.m
//  Zhuntiku（准题库）
//
//  Created by zdwx on 2019/11/27.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "NSString+GWString.h"

@implementation NSString (GWString)

#pragma mark - 计算高度

- (CGFloat)gw_stringSizeWithFont:(CGFloat)font maxWidth:(CGFloat)maxWidth{
    return [self gw_stringSizeWithFont:[UIFont systemFontOfSize:font] maxSize:CGSizeMake(maxWidth, MAXFLOAT)].height;
}

- (CGSize)gw_stringSizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *attrs = @{NSFontAttributeName:font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

#pragma mark - 拼接url

- (NSString *)gw_stringAppentUrlForDictionary:(NSDictionary *)dict{
    if ([self gw_isEmptyString]) {
        return self;
    }
    NSString *mStr = self;
    for (NSString *key in dict.allKeys) {
        mStr = [mStr gw_stringAppentUrlForValue:dict[key] key:key];
    }
    return mStr;
}

-(NSString *)gw_stringAppentUrlForValue:(NSString *)value key:(NSString *)key{
    if ([self gw_isEmptyString]) {
        return self;
    }
    NSString *string = self;
    NSRange range = [string rangeOfString:@"?"];
    if (range.location != NSNotFound) {//找到了
        //如果?是最后一个直接拼接参数
        if (string.length == (range.location + range.length)) {
            NSLog(@"最后一个是?");
            string = [string stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,value]];
        }else{//如果不是最后一个需要加&
            if([string hasSuffix:@"&"]){//如果最后一个是&,直接拼接
                string = [string stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,value]];
            }else{//如果最后不是&,需要加&后拼接
                string = [string stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",key,value]];
            }
        }
    }else{//没找到
        if([string hasSuffix:@"&"]){//如果最后一个是&,去掉&后拼接
            string = [string substringToIndex:string.length-1];
        }
        string = [string stringByAppendingString:[NSString stringWithFormat:@"?%@=%@",key,value]];
    }
    return string.copy;
}

#pragma mark - 转码
- (NSString *)gw_stringEscapesUsingEncodingUTF8{
    if ([self gw_isEmptyString]) {
        return self;
    }
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

#pragma mark - 删除首尾空白
- (NSString *)gw_stringByTrimmingWhiteSpace{
    if ([self gw_isEmptyString]) {
        return self;
    }
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark - 判断是否为空
- (BOOL)gw_isEmptyString{
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

#pragma mark - 验证个人信息
- (BOOL)gw_isMobileNumber{
    if ([self gw_isEmptyString]) {
        return NO;
    }
    NSString *pattern = @"^1+\\d{10}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:self];
}

- (BOOL)gw_checkPassword{
    if ([self gw_isEmptyString]) {
        return NO;
    }
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:self];
}

- (BOOL)gw_checkHasChinese{
    if ([self gw_isEmptyString]) {
        return NO;
    }
    for (int i=0; i<self.length; i++) {
        unichar ch = [self characterAtIndex:i];
        if (0x4E00 <= ch  && ch <= 0x9FA5) {
            return YES;
        }
    }
    return NO;
}

//四舍不五入
- (NSString *)gw_notRounding:(double)price afterPoint:(int)position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;

    ouncesDecimal = [[NSDecimalNumber alloc] initWithDouble:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}
@end
