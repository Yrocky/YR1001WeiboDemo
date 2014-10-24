//
//  YRCancelButton.m
//  YR1001WeiboDemo
//
//  Created by YeungRocky on 14-10-12.
//  Copyright (c) 2014年 YeungRocky. All rights reserved.
//

#import "YRCancelButton.h"

@implementation YRCancelButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

+ (YRCancelButton *) cancelButtonWithImage:(NSString *)image {

    YRCancelButton *cancelButton = [[YRCancelButton alloc] init];
    
    [cancelButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [cancelButton setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_below_background"] forState:UIControlStateNormal];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_below_background"] forState:UIControlStateHighlighted];
    return cancelButton;
}

@end
