//
//  YRRCAButton.m
//  YRTestOne
//
//  Created by Rocky on 14-9-29.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import "YRRCAButton.h"

@implementation YRRCAButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.imageView.contentMode = UIViewContentModeRight;
        self.titleLabel.contentMode = UIViewContentModeLeft;
        self.titleLabel.font = kCreatAndSourceFont;
        self.adjustsImageWhenHighlighted = NO;// 不要再高亮状态下调整图片样式
//        self.titleEdgeInsets = UIEdgeInsetsMake(0, 100, 0, 0);
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    }
    return self;
}

- (void)setCount:(int)count andImage:(NSString *)imageName title:(NSString *)title{
    
    if (count == 0) {
        
        [self setTitle:title forState:UIControlStateHighlighted];
        [self setTitle:title forState:UIControlStateNormal];
    }else {
    
        [self setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateHighlighted];
        [self setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateNormal];
    }
    
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    
}
- (CGRect) imageRectForContentRect:(CGRect)contentRect{

    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = contentRect.size.width * 0.5;
    CGFloat imageH = contentRect.size.height;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
    
}

- (CGRect) titleRectForContentRect:(CGRect)contentRect{

    
    CGFloat titleX = contentRect.size.width * 0.5 + 5;
    CGFloat titleY = 0;
    CGFloat titleW = contentRect.size.width * 0.5;
    CGFloat titleH = contentRect.size.height;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
    
}


@end
