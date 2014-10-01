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

/**
 *  会员等级
 */
@property (nonatomic, assign) int mbrank;
/**
 *  会员类型
 */
@property (nonatomic, assign) int mbtype;
@end