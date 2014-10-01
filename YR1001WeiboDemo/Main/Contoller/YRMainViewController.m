//
//  YRMainViewController.m
//  YRTestOne
//
//  Created by Rocky on 14-9-26.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import "YRMainViewController.h"
#import "YRHomeViewController.h"
#import "YRMessageViewController.h"
#import "YRMeViewController.h"
#import "YRCustomTabBar.h"


@interface YRMainViewController () <YRCustomTabBarDelegate>

@property (nonatomic ,retain) YRCustomTabBar *customTabBar;
@end

@implementation YRMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

//            self.view.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setCustomTabBar];
    
    YRHomeViewController *home = [[YRHomeViewController alloc] init];
    [self viewController:home title:@"首页" imageName:@"tabbar_home_os7" selectedImageName:@"tabbar_home_selected_os7"];
    
    YRMessageViewController *message = [[YRMessageViewController alloc] init];
    [self viewController:message title:@"信息" imageName:@"tabbar_message_center_os7" selectedImageName:@"tabbar_message_center_selected_os7"];
    
    YRMeViewController *me = [[YRMeViewController alloc] init];
    [self viewController:me title:@"我" imageName:@"tabbar_profile_os7" selectedImageName:@"tabbar_profile_selected_os7"];
}

- (void) viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    for (UIView *view in  self.tabBar.subviews) {
        if ([view isKindOfClass:[UIControl class]]) {
            [view removeFromSuperview];
        }
    }
    
}
- (void) setCustomTabBar{

    _customTabBar = [[YRCustomTabBar alloc] init];
    _customTabBar.frame = self.tabBar.bounds;
//    _customTabBar.backgroundColor = [UIColor grayColor];
    _customTabBar.delegate = self;
    [self.tabBar addSubview:_customTabBar];
    
}

- (void)customTabBar:(YRCustomTabBar *)customTabBar fromSelectButton:(NSInteger)fromButon toButton:(NSInteger)toButton{

    self.selectedIndex = toButton;
}

- (void) viewController:(UIViewController *)viewControlller title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedName{
    
    viewControlller.title = title;
    viewControlller.tabBarItem.image = [UIImage imageNamed:imageName];
    viewControlller.tabBarItem.selectedImage = [UIImage imageNamed:selectedName];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewControlller];
    
    [self addChildViewController:navigationController];
    
    [_customTabBar customTaBarWithTabBarItem:viewControlller.tabBarItem];
}



@end
