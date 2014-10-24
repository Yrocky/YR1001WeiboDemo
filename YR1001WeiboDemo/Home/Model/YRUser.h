//
//  YRUser.h
//  YR1001WeiboDemo
//
//  Created by Rocky on 14-10-1.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YRUser : NSObject

// 这里的属性起名要跟加载的字典中的键一样，这样才可以使用第三方框架
/**
 *  用户的ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  用户的昵称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  用户的头像
 */
@property (nonatomic, copy) NSString *profile_image_url;
@property (nonatomic ,copy) NSString *avatar_large;
/**
 *  会员等级
 */
@property (nonatomic, assign) int mbrank;
/**
 *  会员类型
 */
@property (nonatomic, assign) int mbtype;
/**
 *  用户描述
 */
@property (nonatomic ,retain) NSString *description;
/**
 *  粉丝数
 */
@property (nonatomic ,assign) long followers_count;
/**
 *  关注数
 */
@property (nonatomic ,assign) long friends_count;
/**
 *  发的微博数
 */
@property (nonatomic ,assign) long statuses_count;
/**
 *   收藏数
 */
@property (nonatomic ,assign) int favourites_count;
/**
 *  认证原因
 */
@property (nonatomic ,retain) NSString *verified_reason;
@end