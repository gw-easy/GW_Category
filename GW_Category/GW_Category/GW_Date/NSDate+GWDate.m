//
//  NSDate+GWDate.m
//  Zhuntiku（准题库）
//
//  Created by zdwx on 2019/11/28.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "NSDate+GWDate.h"

@implementation NSDate (GWDate)
#pragma mark - 时间 - 秒

+ (NSTimeInterval)gw_currentTime{
    return [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970];
}

+ (NSTimeInterval)gw_currentTimeToAppointTime:(NSTimeInterval)time{
    return [self gw_currentTime] - time;
}

#pragma mark - 时间戳
+ (NSString *)gw_exchange_yMd_hms_Timestamp:(NSTimeInterval)timeStamp{
    return [self gw_exchangeTimestamp:timeStamp withFormat:@"yyyy-MM-dd hh:mm:ss"];
}

+ (NSString *)gw_exchange_hms_Timestamp:(NSTimeInterval)timeStamp{
    return [self gw_exchangeTimestamp:timeStamp withFormat:@"hh:mm:ss"];
}

+ (NSString *)gw_exchangeTimestamp:(NSTimeInterval)timeStamp withFormat:(NSString *)format{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:format];
    [df setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Beijing"]];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    return [df stringFromDate:date];
}

@end
