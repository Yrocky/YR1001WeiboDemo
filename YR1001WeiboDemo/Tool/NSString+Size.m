//
//  NSString+Size.m
//  YR0914QQDemo
//
//  Created by qingyun on 14-9-14.
//  Copyright (c) 2014年 qingyun. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize{

    
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    
}

+ (NSString *) stringWithCount:(long)count{

    NSString *friendStr;

    if (count > 10000l) {
        count = count / 10000;
        friendStr = [NSString stringWithFormat:@"%ld万",count];
    }else{
        
        friendStr = [NSString stringWithFormat:@"%ld",count];
    }
    return friendStr;
}
@end
