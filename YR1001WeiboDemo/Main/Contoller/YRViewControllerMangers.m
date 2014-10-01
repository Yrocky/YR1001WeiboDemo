//
//  YRViewControllerMangers.m
//  YRTestOne
//
//  Created by Rocky on 14-9-26.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import "YRViewControllerMangers.h"
#import "YRGuideViewController.h"
#import "YRLoginViewController.h"
#import "YRMainViewController.h"


@implementation YRViewControllerMangers

+(void)presentViewCotrllerWithType:(YRViewControllerMangerType)viewControllerMangerType{

    UIViewController *viewController = [[[self alloc] init] contentWithType: viewControllerMangerType];
    UIWindow *window = [[[UIApplication sharedApplication]delegate] window];
    window.rootViewController = viewController;
}

- (UIViewController *) contentWithType:(YRViewControllerMangerType)type{

    UIViewController *viewController = nil;
    switch (type) {
        case YRViewControllerMangerTypeGuideViewController:
            viewController = [[YRGuideViewController alloc] init];
            break;
        case YRViewControllerMangerTypeLognViewController:
            viewController = [[YRLoginViewController alloc] init];
            break;
        case YRViewControllerMangerTypeMainViewController:
            viewController = [[YRMainViewController alloc] init];
            break;
        default:
            break;
    }
    
    return viewController;
}

@end
