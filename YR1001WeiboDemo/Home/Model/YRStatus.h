//
//  YRStatus.h
//  YRTestOne
//
//  Created by Rocky on 14-9-29.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YRUser;
@class YRStatus;

@interface YRStatus : NSObject

/**
 *  微博的内容(文字)
 */
@property (nonatomic, copy) NSString *text;
/**
 *  微博的来源
 */
@property (nonatomic, copy) NSString *source;
/**
 *  微博的时间
 */
@property (nonatomic, copy) NSString *created_at;
/**
 *  微博的ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  微博的配图
 */
@property (nonatomic ,retain) NSArray *pic_urls;// 需要一个方法，将这个数组转化成相应的模型类

/**
 *  微博的转发数
 */
@property (nonatomic, assign) int reposts_count;
/**
 *  微博的评论数
 */
@property (nonatomic, assign) int comments_count;
/**
 *  微博的表态数(被赞数)
 */
@property (nonatomic, assign) int attitudes_count;

/**
 *  微博的作者
 */
@property (nonatomic, strong) YRUser *user;
/**
 *  被转发的微博
 */
@property (nonatomic, strong) YRStatus *retweeted_status;


@end