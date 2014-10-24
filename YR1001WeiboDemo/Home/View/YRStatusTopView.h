//
//  YRStatusTopView.h
//  YR1001WeiboDemo
//
//  Created by Rocky on 14-10-2.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YRStatusFrame;
@class YRStatusTopView;

@protocol YRStatusTopViewDelegate <NSObject>

@optional
- (void) statusTopViewUserIconDidClick:(YRStatusTopView *)topView withStatusFrame:(YRStatusFrame *)statusFrame;


@end


@interface YRStatusTopView : UIImageView

/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic ,weak) id<YRStatusTopViewDelegate>delegate;

@property (nonatomic ,retain) YRStatusFrame *statusFrame;

@end
