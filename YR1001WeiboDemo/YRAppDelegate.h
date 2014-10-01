//
//  YRAppDelegate.h
//  YRTestOne
//
//  Created by Rocky on 14-9-26.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YRSinaWeiboDelegate;
@class SinaWeibo;

@interface YRAppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic ,retain) SinaWeibo *sinaWeibo;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) YRSinaWeiboDelegate *sinaWeiboDelegate;

@end
