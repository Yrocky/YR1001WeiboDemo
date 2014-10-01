//
//  YRAppDelegate.m
//  YRTestOne
//
//  Created by Rocky on 14-9-26.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "YRAppDelegate.h"
#import "YRSinaWeiboDelegate.h"

@interface YRAppDelegate ()


@end
static BOOL isRemberPassword ;

@implementation YRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    isRemberPassword = NO;
    
    if (![kNSUD boolForKey:kEverLuanched]){
        [kNSUD setBool:YES forKey:kFirstLuanched];
        [kNSUD setBool:YES forKey:kEverLuanched];
        
    }else{
        [kNSUD setBool:NO forKey:kFirstLuanched];
    }
    [kNSUD synchronize];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    _sinaWeiboDelegate = [[YRSinaWeiboDelegate alloc] init];
    _sinaWeibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:_sinaWeiboDelegate];
    
    // 在这里对保存的数据进行提取，得到里面的授权信息
    NSDictionary *sinWeiboUserInfo = [kNSUD valueForKey:kAuthSinaWeiboAuthData];
    if ([sinWeiboUserInfo valueForKey:kAuthUserIDKey] &&
        [sinWeiboUserInfo valueForKey:kAuthAccessTokenKey] &&
        [sinWeiboUserInfo valueForKey:kAuthExpirationDateKey]) {
        
        _sinaWeibo.accessToken = [sinWeiboUserInfo valueForKey:kAuthAccessTokenKey];
        _sinaWeibo.expirationDate = [sinWeiboUserInfo valueForKey:kAuthExpirationDateKey];
        _sinaWeibo.userID = [sinWeiboUserInfo valueForKey:kAuthUserIDKey];
    }
    
    if ([kNSUD boolForKey:kFirstLuanched]) {
        [YRViewControllerMangers presentViewCotrllerWithType:YRViewControllerMangerTypeGuideViewController];
    }else{
        
        // 在这里进行微博对象是否进行了登陆，如果已经登陆就直接进入首页，不然就进入登陆界面
        if ([_sinaWeibo isLoggedIn]) {
            
            [YRViewControllerMangers presentViewCotrllerWithType:YRViewControllerMangerTypeMainViewController];
        }else{
            
            [YRViewControllerMangers presentViewCotrllerWithType:YRViewControllerMangerTypeLognViewController];
        }
    }
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}
@end