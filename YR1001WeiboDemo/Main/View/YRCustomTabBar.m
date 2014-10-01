//
//  YRCustomTabBar.m
//  YRTestOne
//
//  Created by Rocky on 14-9-26.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import "YRCustomTabBar.h"
#import "YRCustomTabBarButton.h"

@interface YRCustomTabBar ()

@property (nonatomic ,retain) YRCustomTabBarButton *selectedButton;
@end

@implementation YRCustomTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        _selectedButton = [[YRCustomTabBarButton alloc] init];
        _selectedButton.selected = YES;
    }
    return self;
}



- (void) customTaBarWithTabBarItem:(UITabBarItem *)item{
    
    NSLog(@"hello world");
    
    YRCustomTabBarButton *buton = [[YRCustomTabBarButton alloc] init];
    [buton addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    buton.item = item;
    
    [self addSubview:buton];
    if (self.subviews.count == 1) {
        [self onButtonClick:buton];
    }

}

- (void) onButtonClick:(YRCustomTabBarButton *)button{

    if ([self.delegate respondsToSelector:@selector(customTabBar:fromSelectButton:toButton:)]) {
        [self.delegate customTabBar:self fromSelectButton:_selectedButton.tag toButton:button.tag];
    }
    
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
    
}

- (void)layoutSubviews{

    [super layoutSubviews];
    for (int index = 0; index < self.subviews.count; index ++) {
    
        YRCustomTabBarButton *button = self.subviews[index];
        
        CGFloat buttonY = 0;
        CGFloat buttonW = self.frame.size.width / self.subviews.count;
        CGFloat buttonH = self.frame.size.height;
        CGFloat buttonX = index * buttonW;
        button.tag = index;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
}



@end
