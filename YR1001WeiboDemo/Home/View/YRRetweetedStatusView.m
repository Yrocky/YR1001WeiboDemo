//
//  YRRetweetedStatusView.m
//  YR1001WeiboDemo
//
//  Created by Rocky on 14-10-2.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import "YRRetweetedStatusView.h"
#import "YRStatusFrame.h"
#import "YRStatus.h"
#import "YRUser.h"
#import "UIImageView+WebCache.h"


@interface YRRetweetedStatusView ()


/** 被转发微博作者的昵称 */
@property (nonatomic, weak) UIButton *retweetNameButton;

/** 被转发微博的正文\内容 */
@property (nonatomic, weak) UILabel *retweetContentLabel;

/** 被转发微博的配图 */
@property (nonatomic, weak) UIImageView *retweetPhotoView;

@end

@implementation YRRetweetedStatusView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 设置背景图片
        self.image = [UIImage imageWithName:@"timeline_retweet_background"withTop:0.5 left:0.9];

        // 2. 转发微博的作者
        UIButton *retweetNameButton = [[UIButton alloc] init];
        retweetNameButton.titleLabel.font = kTextFont;
        [retweetNameButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [retweetNameButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self addSubview:retweetNameButton];
        self.retweetNameButton = retweetNameButton;
        
        // 3. 转发微博的内容
        UILabel *retweetContentLabel = [[UILabel alloc]init];
        [self addSubview:retweetContentLabel];
        retweetContentLabel.numberOfLines = 0;
        retweetContentLabel.font = kTextFont;
        self.retweetContentLabel = retweetContentLabel;
        
        // 4. 转发微博的图片
        UIImageView *retweetPhotoView = [[UIImageView alloc] init];
        [self addSubview:retweetPhotoView];
        self.retweetPhotoView = retweetPhotoView;

        
    }
    return self;
}

- (void)setStatusFrame:(YRStatusFrame *)statusFrame{

    _statusFrame = statusFrame;
    YRStatus *retweetStatus = _statusFrame.status.retweeted_status;
    YRUser *retweetUser = retweetStatus.user;

    
    // 1. 转发微博的昵称
    [_retweetNameButton setTitle:[NSString stringWithFormat:@"%@",retweetUser.name] forState:UIControlStateHighlighted];

    [_retweetNameButton setTitle:retweetUser.name forState:UIControlStateNormal];
    _retweetNameButton.frame = _statusFrame.retweetNameLabelF;
    
    // 2. 转发微博的内容
    _retweetContentLabel.text = retweetStatus.text;
    _retweetContentLabel.frame = _statusFrame.retweetContentLabelF;
    
    // 3. 转发微博的图片
    if (retweetStatus.thumbnail_pic) {
        
        _retweetPhotoView.hidden = NO;
        [_retweetPhotoView setImageWithURL:[NSURL URLWithString:retweetStatus.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted_os7"]];
        _retweetPhotoView.frame = _statusFrame.retweetPhotoViewF;
        
    }else{
        
        _retweetPhotoView.hidden = YES;
    }
}


@end
