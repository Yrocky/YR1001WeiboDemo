//
//  YRHeaderView.h
//  YR1001WeiboDemo
//
//  Created by YeungRocky on 14-10-12.
//  Copyright (c) 2014年 YeungRocky. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YRStatusFrame;
@interface YRHeaderView : UIView

@property (nonatomic ,weak) UIImageView *bgImageView;
@property (nonatomic ,weak) UIImageView *iconImageView;
@property (nonatomic ,weak) UILabel *nameLabel;
@property (nonatomic ,weak) UILabel *friendsLabel;// 关注数
@property (nonatomic ,weak) UILabel *followersLabel;// 粉丝数
@property (nonatomic ,weak) UIButton *senderButton;
@property (nonatomic ,weak) UIButton *friendButton;
@property (nonatomic ,weak) UILabel *descripitionLabel;
@property (nonatomic ,weak) UIView *buttonBgView;
@property (nonatomic ,weak) UILabel *bgLabel;

@property (nonatomic ,retain) YRStatusFrame *statusFrame;
@property (nonatomic ,assign) CGFloat viewH;

@end
