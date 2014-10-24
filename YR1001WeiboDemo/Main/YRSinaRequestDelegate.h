//
//  YRSinaRequestDelegate.h
//  YR1001WeiboDemo
//
//  Created by Rocky on 14-10-9.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YRSinaRequestDelegate : NSObject<SinaWeiboRequestDelegate>

+ (instancetype) shareSinaWeiboResuestDelegate;
- (void) request:(NSString *)urlString withParams:(NSMutableDictionary *)params httpMethod:(NSString *)method;


@end
