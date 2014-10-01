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
@end
