//
//  UIBarButtonItem+BackButton.m
//  FPWeibot
//
//  Created by qingyun on 14-9-26.
//  Copyright (c) 2014年 qingyun. All rights reserved.
//

#import "UIBarButtonItem+BackButton.h"

@implementation UIBarButtonItem (BackButton)

+ (UIBarButtonItem *)backButtonWithTarget:(id)target action:(SEL)action{

    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 30, 40);
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"navigationbar_back_os7"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"navigationbar_back_highlighted_os7"] forState:UIControlStateHighlighted];
    
    return [[UIBarButtonItem alloc] initWithCustomView:backButton];
}
@end
