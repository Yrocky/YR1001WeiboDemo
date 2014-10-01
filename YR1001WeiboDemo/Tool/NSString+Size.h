//
//  NSString+Size.h
//  YR0914QQDemo
//
//  Created by qingyun on 14-9-14.
//  Copyright (c) 2014年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Size)

- (CGSize) sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

@end
