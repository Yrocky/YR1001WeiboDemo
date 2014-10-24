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

/** 在将登陆信息写进沙河的时候调用用户*/
#define kNSUD [NSUserDefaults standardUserDefaults]

/** 一个字典的key，也是写进沙河的，里面放的是关于用户的登陆信息*/
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

/** 取得系统通知*/
#define YRNSDC  [NSNotificationCenter defaultCenter]

/** 登陆成功和失败的通知名*/
#define kYRNotificationNameLogin @"notificationLogin"
#define kYRNotificationNameLogoff @"notificationLogoff"

/** 取得工程的代理*/
#define appDelegate ((YRAppDelegate*)[UIApplication sharedApplication].delegate)

/** view的宽高*/
#define kViewBoundsW self.view.bounds.size.width
#define kViewBoundsH self.view.bounds.size.height

/** 微博发送时间和来源的字体大小，以及用户姓名的字体大小*/
#define kCreatAndSourceFont [UIFont systemFontOfSize:11]
#define kScreenNameFont [UIFont systemFontOfSize:14.5]
/** 微博正文的字体大小*/
#define kTextFont [UIFont systemFontOfSize:13]

/** 自定义快速创建RGB颜色*/
#define YRColor(_R,_G,_B,_a) ([UIColor colorWithRed:(_R)/ 255.0 green:(_G) /255.0 blue:(_B) /255.0 alpha:(_a)])


#pragma mark -HomeViewController 

/**  间距*/
#define kGarp 6.18
/** 头像的宽高*/
#define kAvatarLargeWH 40
/** 用户姓名字体的大小*/
#define kScreenNameHeight 20
/** 发送时间和发送来源的位子高度限制 */
#define kContentH 15
/** 转发微博的内容宽度限制*/
#define kTextW (320 - 2 * kGarp)

/**  转发评论和点赞按钮的尺寸 */
#define kButtonW 50
#define kButtonH 15

/** 图片排列的时候的图片大小和图片间距*/
#define kImageWH 80
#define kPhotoMargin 10

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


static NSString * const kIconClickNoti = @"iconDidClick";

#pragma mark - requestDelegate
#define kSinaWeiboRequestGetResult @"requestResult"
#define kSinaWeiboRequestError @"error"
#endif


