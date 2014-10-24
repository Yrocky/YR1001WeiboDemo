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
@property (nonatomic ,retain) NSMutableArray *buttons;
@property (nonatomic ,retain) UIButton *plusButton;
@property (nonatomic ,retain) YRCustomTabBarButton *selectedButton;
@end

@implementation YRCustomTabBar

- (id)init{
    
    self = [super init];
    if (self) {
        
        _buttons = [NSMutableArray array];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_os7"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted_os7"] forState:UIControlStateHighlighted];
        
        [plusButton addTarget:self action:@selector(onPlusButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_os7"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted_os7"] forState:UIControlStateHighlighted];
        
        [self addSubview:plusButton];
        self.plusButton = plusButton;

        _selectedButton = [[YRCustomTabBarButton alloc] init];
        _selectedButton.selected = YES;
    }
    return self;
}


#pragma mark - 暴漏的接口，为tabbar添加item使用的
- (void) customTaBarWithTabBarItem:(UITabBarItem *)item{
    
    YRCustomTabBarButton *buton = [[YRCustomTabBarButton alloc] init];
    [buton addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    buton.item = item;
    
    [self addSubview:buton];
    [_buttons addObject:buton];
    
    if (_buttons.count == 1) {
        [self onButtonClick:buton];
    }

}

#pragma mark - item的点击响应事件
- (void) onButtonClick:(YRCustomTabBarButton *)button{

    if ([self.delegate respondsToSelector:@selector(customTabBar:fromSelectButton:toButton:)]) {
        [self.delegate customTabBar:self fromSelectButton:_selectedButton.tag toButton:button.tag];
    }
    
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
    
}

#pragma mark -  对tabbar上面的item和加号按钮进行重新布局
- (void)layoutSubviews{

    [super layoutSubviews];
    
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    // 单独设置加好按钮的frame
    CGFloat plusButtonW = _plusButton.currentBackgroundImage.size.width;
    CGFloat plusButtonH = _plusButton.currentBackgroundImage.size.height;
    _plusButton.center = CGPointMake(w * 0.5, h * 0.5);
    _plusButton.bounds = CGRectMake(0, 0, plusButtonW, plusButtonH);
  
    // 利用循环设置item的frame
    for (int index = 0; index < _buttons.count; index ++) {
    
        YRCustomTabBarButton *button = _buttons[index];
        
        CGFloat buttonY = 0;
        CGFloat buttonW = w / self.subviews.count;
        CGFloat buttonH = h;
        CGFloat buttonX = index * buttonW;
        button.tag = index;
        
        if (index > 1) {// 当事第二个item的时候进行向右移动一个item的距离，留出来的距离放置加号button
            buttonX += buttonW;
        }
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
}
#pragma mark -  点击加号按钮的响应事件
- (void) onPlusButtonTapped:(UIButton *)plusButton{

    if ([self.delegate respondsToSelector:@selector(customTabbar:plusButtonDidClick:)]) {
        [self.delegate customTabbar:self plusButtonDidClick:plusButton];
    }
}

@end
