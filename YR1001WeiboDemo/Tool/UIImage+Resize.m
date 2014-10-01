//
//  UIImage+Resize.m
//  YR0914QQDemo
//
//  Created by qingyun on 14-9-14.
//  Copyright (c) 2014年 qingyun. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage (Resize)

/**
 *  创建一个拉伸好的图片
 *
 */

+ (UIImage *) imageWithName:(NSString *)imageName{

    UIImage *image = [UIImage imageNamed:imageName];
    
    CGFloat w = image.size.width * 0.5;
    CGFloat h = image.size.height * 0.5;
    
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w) resizingMode:UIImageResizingModeTile];
    
}

+ (UIImage *)imageWithName:(NSString *)imageName withTop:(CGFloat)top left:(CGFloat)left{
    
    
    UIImage *image = [UIImage imageNamed:imageName];
    
    CGFloat w = image.size.width * left;
    CGFloat h = image.size.height * top;
    
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w) resizingMode:UIImageResizingModeStretch];
    
    
    
//    + (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
//    {
//        UIImage *image = [self imageWithName:name];
//        return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
//    }
//
    
}

/**
 *  返回一个pop图片，
 *
 *  @param imageName 图片名
 *  @param frame     图片尺寸待设
 *
 */
+ (UIImageView *)popImageViewWithImageName:(NSString *)imageName frame:(CGRect)frame{
    
    UIImage *image = [UIImage imageWithName:imageName];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = frame;
    imageView.alpha = 0.8;
    return imageView;
}

@end
