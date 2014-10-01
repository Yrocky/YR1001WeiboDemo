//
//  YRCustomTabBar.h
//  YRTestOne
//
//  Created by Rocky on 14-9-26.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YRCustomTabBar;
@protocol YRCustomTabBarDelegate <NSObject>

@optional
- (void) customTabBar:(YRCustomTabBar *)customTabBar fromSelectButton:(NSInteger)fromButon toButton:(NSInteger) toButton;

@end


@interface YRCustomTabBar : UIView
@property (nonatomic ,weak) id<YRCustomTabBarDelegate> delegate;
- (void) customTaBarWithTabBarItem:(UITabBarItem *)item;
@end
