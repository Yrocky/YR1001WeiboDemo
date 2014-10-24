//
//  YRStatusToolBar.h
//  YR1001WeiboDemo
//
//  Created by Rocky on 14-10-1.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YRStatus;
@class YRStatusToolBar;
@class YRRCAButton;

/** 底部按钮的代理方法 */
@protocol YRStatusToolBarDelegate <NSObject>

@optional
/** 转发按钮被点击 */
- (void) statusToolBar:(YRStatusToolBar *)statusToolBar repostsButtonDidClick:(YRRCAButton *)reposts;
/** 评论按钮被点击 */
- (void)statusToolBar:(YRStatusToolBar *)statusToolBar commentsButtonDidClick:(YRRCAButton *)comments;
/** 点赞按钮被点击 */
- (void)statusToolBar:(YRStatusToolBar *)statusToolBar attitudesButtonDidClick:(YRRCAButton *)attitudes;

@end

@interface YRStatusToolBar : UIImageView

@property (nonatomic ,weak) id<YRStatusToolBarDelegate>delegate;

@property (nonatomic ,retain) YRStatus *status;
@end
