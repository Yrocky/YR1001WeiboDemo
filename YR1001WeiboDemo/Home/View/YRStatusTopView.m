//
//  YRStatusTopView.m
//  YR1001WeiboDemo
//
//  Created by Rocky on 14-10-2.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import "YRStatusTopView.h"
#import "YRStatusFrame.h"
#import "YRStatus.h"
#import "YRUser.h"
#import "YRPhotosView.h"
#import "UIImageView+WebCache.h"
#import "YRRetweetedStatusView.h"


@interface YRStatusTopView ()

/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;

/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;

/** 配图 */
@property (nonatomic, weak) YRPhotosView *photosView;

/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;

/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;

/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;

/** 正文\内容 */
@property (nonatomic, weak) UILabel *contentLabel;

/** 被转发微博的view(父控件) */
@property (nonatomic, weak) YRRetweetedStatusView *retweetView;

@end

@implementation YRStatusTopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 1. 用户头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        // 2. 用户昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = kScreenNameFont;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // 3. VIP
        UIImageView *vipView = [[UIImageView alloc] init];
        [self addSubview:vipView];
        self.vipView = vipView;
        
        // 4. 微博发送时间
        UILabel *timeLabel = [[UILabel alloc] init];
        [self addSubview:timeLabel];
        timeLabel.textColor = [UIColor orangeColor];
        timeLabel.font = kCreatAndSourceFont;
        self.timeLabel = timeLabel;
        
        // 5. 微博发送来源
        UILabel *sourceLabel = [[UILabel alloc] init];
        [self addSubview:sourceLabel];
        sourceLabel.font = kCreatAndSourceFont;
        self.sourceLabel = sourceLabel;
        
        // 6. 微博正文，没有图片
        UILabel *contentLabel = [[UILabel alloc] init];
        [self addSubview:contentLabel];
        contentLabel.numberOfLines = 0;
        contentLabel.font = kTextFont;
        self.contentLabel = contentLabel;
        
        // 7. 微博图片
        YRPhotosView *photosView = [[YRPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
        
        // 8. 转发微博的底部视图
        YRRetweetedStatusView *retweetView = [[YRRetweetedStatusView alloc] init];
        [self addSubview:retweetView];
        self.retweetView = retweetView;

    }
    return self;
}

- (void)setStatusFrame:(YRStatusFrame *)statusFrame{

    _statusFrame = statusFrame;
    
    YRStatus *status = _statusFrame.status;
    YRUser *user = status.user;
    
    // 1. 头像的frame
    _iconView.frame = _statusFrame.iconViewF;
    [_iconView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted_os7"] ];
    
    // 2. 微博作者
    _nameLabel.text = user.name;
    _nameLabel.frame =_statusFrame.nameLabelF;
    
    // 3. 会员
    _vipView.frame = _statusFrame.vipViewF;
    
    // 4. 发送时间
    _timeLabel.text = status.created_at;
    CGFloat timeX = self.nameLabel.frame.origin.x;
    CGFloat timeY = CGRectGetMaxY(self.nameLabel.frame) + kGarp;
    CGFloat timeH = kContentH;
    CGSize timeSize = CGSizeMake(MAXFLOAT, timeH);
    CGFloat timeW = [status.created_at sizeWithFont:kCreatAndSourceFont maxSize:timeSize].width;
    _timeLabel.frame  = CGRectMake(timeX, timeY, timeW, timeH);
    
    // 5. 发送来源
    _sourceLabel.text = status.source;
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + kGarp;
    CGFloat sourceY = timeY;
    CGFloat sourceH = kContentH;
    CGSize sourceSize = CGSizeMake(MAXFLOAT, sourceH);
    CGFloat sourceW =[status.source sizeWithFont:kCreatAndSourceFont maxSize:sourceSize].width;
    _sourceLabel.frame = CGRectMake(sourceX, sourceY, sourceW, sourceH);
    
    // 6. 微博原文
    _contentLabel.text = status.text;
    _contentLabel.frame = _statusFrame.contentLabelF;
    
    // 7. 微博图片
    if (_statusFrame.status.pic_urls.count) {
        
        _photosView.hidden = NO;
        _photosView.frame = _statusFrame.photoViewF;
        
        _photosView.photos = _statusFrame.status.pic_urls;

    }else{
        
        _photosView.hidden = YES;
    }
    
    YRStatus *retweetStatus = status.retweeted_status;
    
    if (retweetStatus) {
        
        _retweetView.hidden = NO;
        
        _retweetView.statusFrame = _statusFrame;
        
        _retweetView.frame = _statusFrame.retweetViewF;
        
    }else{
        _retweetView.hidden = YES;
    }

}

@end
