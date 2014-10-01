//
//  ContentDefin.h
//  YRTestOne
//
//  Created by Rocky on 14-9-26.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#ifndef YRTestOne_ContentDefin_h
#define YRTestOne_ContentDefin_h

#define kEverLuanched  @"everLuanched"
#define kFirstLuanched @"firstLuanch"


#define kNSUD [NSUserDefaults standardUserDefaults]


#define kAuthSinaWeiboAuthData  @"SinaWeiboAuthData"

#define kAuthAccessTokenKey     @"AcessTokenKey"
#define kAuthUserIDKey          @"UserIDKey"
#define kAuthExpirationDateKey  @"ExpirationDateKey"

#define kAuthRefreshToken       @"refreshToken"

// 这里必须使用自己的微博开发者密钥
#define kAppKey @"2111856559"
#define kAppSecret @"08a7725120acebd2828500ae8bb56310"
// 回调页面
#define kAppRedirectURI @"http://api.weibo.com/oauth2/default.html"

#define YRNSDC  [NSNotificationCenter defaultCenter]

#define kYRNotificationNameLogin @"notificationLogin"
#define kYRNotificationNameLogoff @"notificationLogoff"

#define appDelegate ((YRAppDelegate*)[UIApplication sharedApplication].delegate)


#define kViewBoundsW self.view.bounds.size.width
#define kViewBoundsH self.view.bounds.size.height


#define kCreatAndSourceFont [UIFont systemFontOfSize:11]
#define kScreenNameFont [UIFont systemFontOfSize:14.5]

#define kTextFont [UIFont systemFontOfSize:13]

#define YRColor(_R,_G,_B,_a) ([UIColor colorWithRed:(_R)/ 255.0 green:(_G) /255.0 blue:(_B) /255.0 alpha:(_a)])

#endif
