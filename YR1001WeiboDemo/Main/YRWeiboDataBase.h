//
//  YRWeiboDataBase.h
//  YR1001WeiboDemo
//
//  Created by Rocky on 14-10-5.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YRWeiboDataBase : NSObject
+ (instancetype) shareWeiboDataBase;

/**
 *  将单条微博保存到数据库中
 *
 *  当调用接口获得用户微博列表的时候进行微博的储存
 */
- (void) saveStatusToDataBase:(NSDictionary *)statusDict;
/**
 *  将获得的所有微博保存到数据库中
 *
 *  调用接口的时候进行微博数据的存储
 */
- (void) saveTimeLinesToDataBase:(NSArray *)timeLinesArray;
/**
 *  将获得的用户数据保存到数据库中
 *
 *  当存储微博数据的时候将微博用户的数据也进行存储
 */
- (void) saveUserInfoToDataBase:(NSDictionary *)userInfoDict withStatusID:(NSString *)statusID;
/**
 *  将获得的草稿数据保存到数据库中
 *
 *  当用户进行微博的草稿箱添加的时候进行存储
 */
- (void) saveTempStatusToDataBase:(NSDictionary *)tempStatusDict;
/**
 *  从数据库中获得微博数据
 *
 *  当进入应用的时候先从数据库请求数据，通过这个方法获取
 *
 */
- (NSArray *) queryTimeLinesFromDataBase;
/**
 *  从数据库中获得用户数据
 *
 *  
 *
 */
- (NSDictionary *) queryUserInfoFromDataBaseFromUserId:(NSString *)userId;
/**
 *  从数据库中获得草稿箱数据
 *
 *
 *
 */
- (NSArray *) queryTempStatusFromDataBase;

@end


/*
 
 //将单条微博数据保存到数据库里
 - (void)saveStatusToDataBase:(NSDictionary*)dicStatus;
 //将获取到的所有的微博数据保存到数据库
 - (void)saveTimelinesToDataBase:(NSArray*)timeLines;
 //将用户信息保存到数据库
 - (void)saveUserInfoToDataBase:(NSDictionary*)dicUserInfo withStatusID:(NSString*)statusID;
 //将草稿数据保存到数据库
 - (void)saveTempStatusToDrafts:(NSDictionary*)stemStatus;
 //从数据库里取出微博数据
 - (NSArray*)queryTimeLinesFromDataBase;
 //从数据库里取出用户信息数据
 - (NSArray*)queryUserInfoFromDataBase;
 //从草稿箱取出数据
 - (NSArray*)queryTempStatusFromDataBase;
 */