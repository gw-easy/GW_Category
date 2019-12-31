//
//  NSDate+GWDate.h
//  Zhuntiku（准题库）
//
//  Created by zdwx on 2019/11/28.
//  Copyright © 2019 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (GWDate)

#pragma mark - 时间 - 秒
/// 当前时间 - 秒
+ (NSTimeInterval)gw_currentTime;

/// 指定时间 - 秒
/// @param time 指定时间
+ (NSTimeInterval)gw_currentTimeToAppointTime:(NSTimeInterval)time;


#pragma mark - 时间戳

///yyyy-MM-dd hh:mm:ss 年-月-日 时:分:秒

/// 时间戳 - 年-月-日 时:分:秒
/// @param timeStamp 时间-秒
+ (NSString *)gw_exchange_yMd_hms_Timestamp:(NSTimeInterval)timeStamp;


/// 时间戳 - 时:分:秒
/// @param timeStamp 时间-秒
+ (NSString *)gw_exchange_hms_Timestamp:(NSTimeInterval)timeStamp;

/// 时间戳 - 自定义
/// @param timeStamp 时间-秒
/// @param format 格式
+ (NSString *)gw_exchangeTimestamp:(NSTimeInterval)timeStamp withFormat:(NSString *)format;

@end

NS_ASSUME_NONNULL_END
