//
//  CustomTitleButton.m
//  FPWeibot
//
//  Created by qingyun on 14-9-25.
//  Copyright (c) 2014年 qingyun. All rights reserved.
//

#import "CustomTitleButton.h"


#define kImageW 20

@implementation CustomTitleButton

+ (instancetype)titleButton{

    return [[self alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        // 设置文字和图片的排列
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.contentMode = UIViewContentModeLeft;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageWithName: @"navigationbar_background"] forState:UIControlStateHighlighted];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down_os7"] forState:UIControlStateNormal];
        
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{

    
    CGFloat imageY = 0;
    CGFloat imageW = kImageW;
    CGFloat imageH = contentRect.size.height;
    CGFloat imageX = contentRect.size.width - imageW ;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{

    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW = contentRect.size.width - kImageW;
    CGFloat titleH = contentRect.size.height;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state{

    CGSize titleSize = CGSizeMake(MAXFLOAT, self.frame.size.height);
    CGFloat titleW = [title sizeWithFont:kTextFont maxSize:titleSize].width + kImageW + 10;
    
    CGRect frame = self.frame;
    frame.size.width = titleW;
    self.frame = frame;
    
    [super setTitle:title forState:state];
}
@end
