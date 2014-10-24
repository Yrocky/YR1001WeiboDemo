//
//  YRChooseButton.m
//  YR1001WeiboDemo
//
//  Created by YeungRocky on 14-10-12.
//  Copyright (c) 2014年 YeungRocky. All rights reserved.
//

#import "YRChooseButton.h"

#define kScale 0.8
@implementation YRChooseButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

//        self.tintAdjustmentMode = uiviewti
        self.imageView.contentMode = UIViewContentModeCenter;
//        self.backgroundColor = [UIColor orangeColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
//        self.adjustsImageWhenHighlighted = NO;
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    }
    return self;
}

- (CGRect) imageRectForContentRect:(CGRect)contentRect{

    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * kScale;
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    return CGRectMake(imageX, imageY, imageW, imageH);
}


- (CGRect)titleRectForContentRect:(CGRect)contentRect{

    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height * (1 - kScale);
    CGFloat titleX = 0;
    CGFloat titleY = contentRect.size.height * kScale;

    return CGRectMake(titleX, titleY, titleW, titleH);
}

+ (YRChooseButton *) createChooseButtonWithImage:(NSString *)image withTitle:(NSString *)title {

    YRChooseButton *chooseButton = [[self alloc] init];
    
    [chooseButton setTitle:title forState:UIControlStateHighlighted];
    [chooseButton setTitle:title forState:UIControlStateNormal];
    
    [chooseButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [chooseButton setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    
    return chooseButton;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
#warning 调用父类的touch方法
    [super touchesBegan:touches withEvent:event];//
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformMakeScale(1.2, 1.2);
    }];

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [super touchesEnded:touches withEvent:event];
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformIdentity;
    }];

}
@end
