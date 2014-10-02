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


#pragma mark -HomeViewController 

/** 中间试图中button箭头向下的tag */
#define kDownImageTag 0
/** 中间视图中button箭头向上的tag */
#define kUpImageTag 1
/** 右边pop出现的tag */
#define kPopRightImageTag 1
/** 左边pop出现的tag*/
#define kPopLeftImageTag 1
/** 中间pop试图的宽度 */
#define kPopTitleImageW 150
/** 中间pop试图的高度*/
#define kPopTitleImaheH 300
/** 所有pop试图的Y坐标值 */
#define kPopImageY 35
/** pop出的左视图和右视图的宽 */
#define kPopRightAndLeftImageW 200
/**  pop出的左视图和右视图的高 */
#define kPopRightAndLeftImageH 200

#endif
