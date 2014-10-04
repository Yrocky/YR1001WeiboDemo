//
//  YRSinaWeiboDelegate.m
//  YRTestOne
//
//  Created by Rocky on 14-9-28.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import "YRSinaWeiboDelegate.h"

@implementation YRSinaWeiboDelegate
/**
 *  微博登陆
 *
 */
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo{

// 登陆成功的时候进行两件事，第一件是，发送一个通知给登陆界面，进行界面的跳转
    [YRNSDC postNotificationName:kYRNotificationNameLogin object:nil];
// 第二件是，进行储存信息
    [self storeAuthData:sinaweibo];

}

- (void) storeAuthData:(SinaWeibo *)sinaWeibo{

    NSDictionary *authData ;
    authData = [NSDictionary dictionaryWithObjectsAndKeys:sinaWeibo.userID,kAuthUserIDKey,
                                                          sinaWeibo.expirationDate,kAuthExpirationDateKey,
                                                          sinaWeibo.accessToken,kAuthAccessTokenKey,
                                                          nil];
    [kNSUD setValue:authData forKey:kAuthSinaWeiboAuthData];
    [kNSUD synchronize];
    
}

/**
 *  微博登出
 *
 */
- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo{
    
    // 发送登出通知
    [YRNSDC postNotificationName:kYRNotificationNameLogoff object:self];
    
    // 进行授权信息的移除
    [kNSUD removeObjectForKey:kAuthSinaWeiboAuthData];
    [kNSUD synchronize];
}
@end
