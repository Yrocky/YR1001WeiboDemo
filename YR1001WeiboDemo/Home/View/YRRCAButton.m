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
        NSString  *countTitle = [NSString stringWithFormat:@"%d",count];
    
        if (count >= 10000) {// 大于1w，不显示实际值
            countTitle = [NSString stringWithFormat:@"%.1f万",count / 10000.0];
        }
        // 将出现的1.0中的.0换成1，也就是说不显示.0
        title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        
        [self setTitle:countTitle forState:UIControlStateHighlighted];
        [self setTitle:countTitle forState:UIControlStateNormal];
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
