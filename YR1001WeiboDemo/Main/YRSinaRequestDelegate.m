//
//  YRSinaRequestDelegate.m
//  YR1001WeiboDemo
//
//  Created by Rocky on 14-10-9.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import "YRSinaRequestDelegate.h"

@interface YRSinaRequestDelegate ()

@property (nonatomic ,retain) NSDictionary *resultDict;

@end
@implementation YRSinaRequestDelegate


+ (instancetype) shareSinaWeiboResuestDelegate{

    return [[self alloc] init];
}

+ (id)allocWithZone:(struct _NSZone *)zone{

    static YRSinaRequestDelegate *instance;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        // 这里用Super
        instance = [super allocWithZone:zone];
    });
    
    return instance;
}

- (void) request:(NSString *)urlString withParams:(NSMutableDictionary *)params httpMethod:(NSString *)method{

    [appDelegate.sinaWeibo requestWithURL:urlString params:params httpMethod:method delegate:self];
    
}

#pragma mark - sinaWeiboRequestDelegate


- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{

    // 将加载的url和结果result都传出去，方便以后进行使用
    static NSString * const requestUrl = @"requestUrl";
    static NSString * const resquestResult = @"resquestResult";
    [[NSNotificationCenter defaultCenter] postNotificationName:kSinaWeiboRequestGetResult object:@{requestUrl:request.url,resquestResult:result}];
}

- (void)request:(SinaWeiboRequest *)request didReceiveRawData:(NSData *)data{


}
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error{
    
    static NSString * const requestUrl = @"requestUrl";
    static NSString * const requestError = @"requestError";
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kSinaWeiboRequestError object:@{requestUrl:request.url,requestError: error}];
}


-(void)request:(SinaWeiboRequest *)request didReceiveResponse:(NSURLResponse *)response{


}
@end
