//
//  UIBarButtonItem+Custom.m
//  YRTestOne
//
//  Created by Rocky on 14-9-28.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import "UIBarButtonItem+Custom.h"

@implementation UIBarButtonItem (Custom)


+ (UIBarButtonItem *)itemWithNormalImageName:(NSString *)normalImageName highlightedImageName:(NSString *)higlightedImageName andTarget:(id)target action:(SEL)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setBackgroundImage:[UIImage imageWithName:normalImageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithName:higlightedImageName] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.bounds = (CGRect){CGPointZero,button.currentBackgroundImage.size};
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
@end
