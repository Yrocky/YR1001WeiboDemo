//
//  YRWeiboDataBase.m
//  YR1001WeiboDemo
//
//  Created by Rocky on 14-10-5.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import "YRWeiboDataBase.h"
#import "FMDatabase.h"

@interface YRWeiboDataBase ()
@property (nonatomic ,retain) FMDatabase *myWeiboDB;
@end

@implementation YRWeiboDataBase

// 写单例
+ (id)allocWithZone:(struct _NSZone *)zone{

    static YRWeiboDataBase *weiboDB;
    
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        
        weiboDB = [[super allocWithZone:zone] init];
    });
    
    return weiboDB;
}

+ (instancetype) shareWeiboDataBase{

    return [[self alloc] init];
}

- (id)init{

    self = [super init];
    if (self) {
       
//        NSString *bdName = [NSBundle mainBundle] pathForResource:<#(NSString *)#> ofType:<#(NSString *)#>
        NSString *dbPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:kDBName];
        
        _myWeiboDB = [FMDatabase databaseWithPath:dbPath];
        
        if(![_myWeiboDB open]){
        
            YRLog(@"打开失败");
        }else {
        
            YRLog(@"打开成功");
        }
    }
    return self;
}

#pragma mark - 保存数据

- (void)saveTimeLinesToDataBase:(NSArray *)timeLinesArray{

    for (NSDictionary *dict in timeLinesArray) {
        
        [self saveStatusToDataBase:dict];
    }
}

- (void)saveStatusToDataBase:(NSDictionary *)statusDict{

    NSString *insertInto = @"insert into  ";
    NSString *tableName = kStatustTableName;
    NSMutableString *sql = [NSMutableString string];
    [sql appendString:insertInto];
    [sql appendString:tableName];
    
    [sql appendString: @" (status_id , id ,text, source , created_at , idstr , pic_urls , reposts_count , comments_count , attitudes_count , user ,retweeted_status ) values (null,? ,?,?,?,?,?,?,?,?,?,?);"];
    
    // 这里的status_id是主键，不用对他进行赋值
    BOOL isInsertOK = [_myWeiboDB executeUpdate:sql,
                                                   [statusDict valueForKey:kStatustID],
                                                   [statusDict valueForKey:kStatusText],
                                                   [statusDict valueForKey:kStatusSource],
                                                   [statusDict valueForKey:kStatusCreateedAt],
                                                   [statusDict valueForKey:kStatusIdstr],
                                                   [statusDict valueForKey:kStatusPicUrls],
                                                   [statusDict valueForKey:kStatusRepostsCount],
                                                   [statusDict valueForKey:kStatusCommentsCount],
                                                   [statusDict valueForKey:kStatusAttitudesCount],
                                                   [statusDict valueForKey:kStatusUserInfo],
                                                   [statusDict valueForKey:kStatusRetweetedStatus]];
    
    if (!isInsertOK) {
    
        YRLog(@"进行数据插入失败");
        return;
    }
    
    // 将微博的发送用户进行储存
    [self saveUserInfoToDataBase:statusDict[kStatusUserInfo] withStatusID:statusDict[kStatustID]];
    
    // 将转发微博的信息进行存储
    if (statusDict[kStatusRetweetedStatus]) {
        [self saveStatusToDataBase:statusDict[kStatusRetweetedStatus]];
    }
    
}



- (void)saveUserInfoToDataBase:(NSDictionary *)userInfoDict withStatusID:(NSString *)statusID{

    NSString *insert = @"insert into ";
    NSString *tableName = @"T_USER ";
    NSMutableString *sql = [[NSMutableString alloc] initWithString:insert];
    [sql appendString:tableName];
    [sql appendString:@"(user_id , id ,idstr , status_id, screen_name , name , description , followers_count , statuses_count , avatar_large ,verified_reason , profile_image_url ) values (null ,? , ? ,? , ? , ? , ? , ? , ?, ? ,? ,?) ;"];
    
    // 这里由于user_id是增长的，所以不用对他进行赋值
    BOOL isInsertOK = [_myWeiboDB executeUpdate:sql ,
                           [userInfoDict valueForKey:kUserID],
                           [userInfoDict valueForKey:kUserIdstr],
                           statusID,
                           [userInfoDict valueForKey:kUserScreenName],
                           [userInfoDict valueForKey:kUserName],
                           [userInfoDict valueForKey:kUserDescription],
                           [userInfoDict valueForKey:kUserFollowersCount],
                           [userInfoDict valueForKey:kUserStatusesCount],
                           [userInfoDict valueForKey:kUserAvatarlager],
                           [userInfoDict valueForKey:kUserVerifiedReason],
                           [userInfoDict valueForKey:kUserProfileImageUrl]];
    if (!isInsertOK) {
        YRLog(@"插入失败");
    }
}

- (void)saveTempStatusToDataBase:(NSDictionary *)tempStatusDict{

    
}

#pragma mark - 取数据

- (NSArray *)queryTimeLinesFromDataBase{
    
    NSMutableArray *array = nil;
    
    NSString *select = @"select ";
    NSMutableString *sql = [NSMutableString string];
    [sql appendString:select];
    
    [sql appendString:@" status_id , id , text , source , created_at , idstr , pic_urls , reposts_count , comments_count , attitudes_count , user , retweeted_status from T_STATUS;"];
    
    array = [NSMutableArray array];
    
    FMResultSet *reslut = [_myWeiboDB executeQuery:sql];
    
    while ([reslut next]) {
        
        NSDictionary *userInfo = [reslut objectForColumnIndex:10];
        if (userInfo == nil) {// 这个在后面会用到
            return nil;
        }
        NSDictionary *statusInfo = [reslut objectForColumnIndex:11];
        if (statusInfo != nil) {// 转发微博不为空就在数组中创建转发微博
            [array addObject:@{kStatusStatusID: [reslut objectForColumnIndex:0],
                               kStatustID: [reslut objectForColumnIndex:1],
                               kStatusText: [reslut objectForColumnIndex:2],
                               kStatusSource: [reslut objectForColumnIndex:3],
                               kStatusCreateedAt: [reslut objectForColumnIndex:4],
                               kStatusIdstr: [reslut objectForColumnIndex:5],
                               kStatusPicUrls: [reslut objectForColumnIndex:6],
                               kStatusRepostsCount: [reslut objectForColumnIndex:7],
                               kStatusCommentsCount: [reslut objectForColumnIndex:8],
                               kStatusAttitudesCount: [reslut objectForColumnIndex:9],
                               kStatusUserInfo: userInfo,
                               kStatusRetweetedStatus: statusInfo}];
        }else{
            [array addObject:@{kStatusStatusID: [reslut objectForColumnIndex:0],
                               kStatustID: [reslut objectForColumnIndex:1],
                               kStatusText: [reslut objectForColumnIndex:2],
                               kStatusSource: [reslut objectForColumnIndex:3],
                               kStatusCreateedAt: [reslut objectForColumnIndex:4],
                               kStatusIdstr: [reslut objectForColumnIndex:5],
                               kStatusPicUrls: [reslut objectForColumnIndex:6],
                               kStatusRepostsCount: [reslut objectForColumnIndex:7],
                               kStatusCommentsCount: [reslut objectForColumnIndex:8],
                               kStatusAttitudesCount: [reslut objectForColumnIndex:9],
                               kStatusUserInfo: userInfo}];
        }
        
    }
    
    return array;
}

- (NSDictionary *) queryStatusInfoWithStatusId:(NSString *)statusId{


    NSString *select = @"select ";
    NSMutableString *sql = [[NSMutableString alloc] initWithString:select];
    [sql appendString:@" id ,idstr , created_at , text , source , reposts_count , comments_count , attitudes_count  from t_status where id = ?"];
    FMResultSet *result = [_myWeiboDB executeQuery:sql,statusId];
    
    NSDictionary *dict = [NSDictionary dictionary];
    
    while ([result next]) {
        
        dict = @{kStatustID: [result objectForColumnIndex:0],
                 kStatusIdstr: [result objectForColumnIndex:1],
                 kStatusCreateedAt: [result objectForColumnIndex:2],
                 kStatusText: [result objectForColumnIndex:3],
                 kStatusSource: [result objectForColumnIndex:4],
                 kStatusRepostsCount: [result objectForColumnIndex:5],
                 kStatusCommentsCount: [result objectForColumnIndex:6],
                 kStatusAttitudesCount: [result objectForColumnIndex:7]};
        
    }
    
    return dict;
}


- (NSDictionary *)queryUserInfoFromDataBaseFromUserId:(NSString *)userId{// 传进来的是主键么？？不是！！！！
    
    NSString *select = @"select";
    NSMutableString *sql = [[NSMutableString alloc] initWithString:select];
    
    [sql appendString:@" user_id , id ,idstr , status_id, screen_name , name , description , followers_count , statuses_count , avatar_large ,verified_reason , profile_image_url  from t_user  where id = ?;"];
    FMResultSet *result = [_myWeiboDB executeQuery:sql,userId];
    
    NSDictionary *dict = nil;
    
    while([result next]) {
        
        dict = @{kUserUserId: [result objectForColumnIndex:0],
                 kUserID: [result objectForColumnIndex:1],
                 kUserStatusId: [result objectForColumnIndex:2],
                 kUserScreenName: [result objectForColumnIndex:3],
                 kUserName: [result objectForColumnIndex:4],
                 kUserDescription:[result objectForColumnIndex:5],
                 kUserFollowersCount:[result objectForColumnIndex:6],
                 kUserStatusesCount: [result objectForColumnIndex:7],
                 kUserAvatarlager: [result objectForColumnIndex:8],
                 kUserVerifiedReason : [result objectForColumnIndex:9],
                 kUserProfileImageUrl: [result objectForColumnIndex:10]};
        
            }
    return dict;
}

- (NSArray *)queryTempStatusFromDataBase{
    
    return nil;
}

- (void)dealloc{

    [_myWeiboDB close];
}
@end
