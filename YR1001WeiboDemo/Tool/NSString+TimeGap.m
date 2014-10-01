//
//  NSString+TimeGap.m
//  YRTestOne
//
//  Created by Rocky on 14-9-29.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import "NSString+TimeGap.h"

@implementation NSString (TimeGap)

+ (NSString *) created_atStringWithStandardDateString:(NSString *)dateString{
    
    // 设置时间显示格式的类
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EE MMM dd HH:mm:ss ZZZ yyyy"];
    
    NSDate *dateFromString = [dateFormatter dateFromString:dateString];
    
    NSTimeInterval interval = [dateFromString timeIntervalSinceNow];
    
    int timeGap = abs((int)interval / 60);
    
    NSString *timeGapString = timeGap < 3 ? @"刚刚" : ([NSString stringWithFormat: @"%d分钟之前",timeGap]);
    
    return timeGapString;
}

/*
 
 NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
 [dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss ZZZ yyyy"];
 NSDate *dateFromString = [dateFormatter dateFromString:[statusInfo objectForKey:@"created_at"]];
 NSTimeInterval interval = [dateFromString timeIntervalSinceNow];
 //    abs 是求参数的绝对值
 createTime.text =[ NSString stringWithFormat:@"%d分钟之前",abs((int) interval / 60) ];
*/

@end
