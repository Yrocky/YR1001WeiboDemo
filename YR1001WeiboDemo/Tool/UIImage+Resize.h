//
//  UIImage+Resize.h
//  YR0914QQDemo
//
//  Created by qingyun on 14-9-14.
//  Copyright (c) 2014年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resize)

+ (UIImage *) imageWithName:(NSString *)image;

+ (UIImageView *) popImageViewWithImageName:(NSString *)imageName frame:(CGRect)frame;

@end
