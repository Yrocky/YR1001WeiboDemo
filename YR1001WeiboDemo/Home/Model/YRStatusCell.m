//
//  YRStatusCell.m
//  YRTestOne
//
//  Created by Rocky on 14-9-29.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import "YRStatusCell.h"
#import "YRStatus.h"
#import "YRStatusFrame.h"
#import "YRRCAButton.h"
#import "YRUser.h"
#import "UIImageView+WebCache.h"
#import "YRStatusToolBar.h"


@interface YRStatusCell ()

/** 顶部的view */  //这里为什么使用weak？
@property (nonatomic, weak) UIImageView *topView;

/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;

/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;

/** 配图 */
@property (nonatomic, weak) UIImageView *photoView;

/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;

/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;

/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;

/** 正文\内容 */
@property (nonatomic, weak) UILabel *contentLabel;


/** 被转发微博的view(父控件) */
@property (nonatomic, weak) UIImageView *retweetView;

/** 被转发微博作者的昵称 */
@property (nonatomic, weak) UIButton *retweetNameButton;

/** 被转发微博的正文\内容 */
@property (nonatomic, weak) UILabel *retweetContentLabel;

/** 被转发微博的配图 */
@property (nonatomic, weak) UIImageView *retweetPhotoView;


/** 微博的工具条 */
@property (nonatomic, weak) YRStatusToolBar *statusToolbar;

/** 底部的三个按钮*/
@property (nonatomic, weak) YRRCAButton *rButton;
@property (nonatomic, weak) YRRCAButton *cButton;
@property (nonatomic, weak) YRRCAButton *aButton;

@end


@implementation YRStatusCell

+ (YRStatusCell *)creatCellWithTableView:(UITableView *)tableView{

    static NSString *ID = @"status";
    YRStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[YRStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if ( self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]){
    
        // 1. 添加原创微博控件
        [self setOriginStatus];
        
        // 2. 添加转发微博控件
        [self setRetweetedStatus];
        
        // 3. 添加底部微博工具条
        [self setBottomView];
    }
    
    return self;
}

- (void) setOriginStatus{

//    self.selectedBackgroundView = [[UIView alloc] init];
    
    // 1. 底部的视图，是个UIImageView
     UIImageView *topView = [[UIImageView alloc] init];
    [self.contentView addSubview:topView];
//    topView.image = [UIImage imageWithName:@"timeline_card_top_background"];
//    topView.highlightedImage = [UIImage imageWithName:@"timeline_card_top_background_highlighted"];
    self.topView = topView;
    
    // 2. 用户头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [topView addSubview:iconView];
    self.iconView = iconView;
    
    // 3. 用户昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = kScreenNameFont;
    [topView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    // 4. VIP
    UIImageView *vipView = [[UIImageView alloc] init];
    [topView addSubview:vipView];
    self.vipView = vipView;
    
    // 5. 微博发送时间
    UILabel *timeLabel = [[UILabel alloc] init];
    [topView addSubview:timeLabel];
    timeLabel.textColor = [UIColor orangeColor];
    timeLabel.font = kCreatAndSourceFont;
    self.timeLabel = timeLabel;
    
    // 6. 微博发送来源
    UILabel *sourceLabel = [[UILabel alloc] init];
    [topView addSubview:sourceLabel];
    sourceLabel.font = kCreatAndSourceFont;
    self.sourceLabel = sourceLabel;
    
    // 7. 微博正文，没有图片
    UILabel *contentLabel = [[UILabel alloc] init];
    [topView addSubview:contentLabel];
    contentLabel.numberOfLines = 0;
    contentLabel.font = kTextFont;
    self.contentLabel = contentLabel;
    
    // 8. 微博图片
    UIImageView *photoImageView = [[UIImageView alloc] init];
    [topView addSubview:photoImageView];
    self.photoView = photoImageView;
    
}

- (void) setRetweetedStatus{
    
    // 1. 转发微博底部的视图，也是UIImageView
    UIImageView *retweetView = [[UIImageView alloc] init];
    retweetView.image = [UIImage imageWithName:@"timeline_retweet_background"withTop:0.5 left:0.9];
    [self.topView addSubview:retweetView];
    self.retweetView = retweetView;
    
    // 2. 转发微博的作者
    UIButton *retweetNameButton = [[UIButton alloc] init];
    [retweetNameButton setTitle:self.statusFrame.status.retweeted_status.user.name forState:UIControlStateNormal];
    retweetNameButton.titleLabel.font = kTextFont;
    [retweetNameButton setTitle:self.statusFrame.status.retweeted_status.user.name forState:UIControlStateHighlighted];
    [retweetNameButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [retweetNameButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [retweetView addSubview:retweetNameButton];
    self.retweetNameButton = retweetNameButton;
    
    // 3. 转发微博的内容
    UILabel *retweetContentLabel = [[UILabel alloc]init];
    [retweetView addSubview:retweetContentLabel];
//    retweetContentLabel.backgroundColor = [UIColor lightGrayColor];
    retweetContentLabel.numberOfLines = 0;
    retweetContentLabel.font = kTextFont;
    self.retweetContentLabel = retweetContentLabel;
    
    // 4. 转发微博的图片
    UIImageView *retweetPhotoView = [[UIImageView alloc] init];
    [retweetView addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;
    
    
}

- (void) setBottomView{

    YRStatusToolBar *statusToolbar = [[YRStatusToolBar alloc] init];
    [self.contentView addSubview:statusToolbar];
    self.statusToolbar = statusToolbar;
    
}

- (void)setFrame:(CGRect)frame{

//    frame.origin.x += kGarp;
    frame.size.height -= kGarp + 1;
//    frame.size.width -= 2 * kGarp;
//    frame.origin.x = kGarp;
//    frame.origin.y += 2 *kGarp;
    
    [super setFrame:frame];
}

- (void)setStatusFrame:(YRStatusFrame *)statusFrame{

    _statusFrame = statusFrame;
    
    // 1. 设置原创微博
    [self setOriginFrame];
    
    // 2. 设置转发微博
    [self setRetweetFrame];
    
    // 3. 设置底部的按钮栏
    [self setButtomViewFrame];
    
}

- (void) setOriginFrame{

    YRStatus *status = _statusFrame.status;
    YRUser *user = status.user;
    
    _topView.frame = _statusFrame.topViewF;
    
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
    if (_statusFrame.status.thumbnail_pic) {
        
        _photoView.hidden = NO;
        _photoView.frame = _statusFrame.photoViewF;
        [_photoView setImageWithURL:[NSURL URLWithString:status.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted_os7"]];
    }else{
    
        _photoView.hidden = YES;
    }
    
}

- (void) setRetweetFrame{
    
    YRStatus *retweetStatus = _statusFrame.status.retweeted_status;
    YRUser *retweetUser = retweetStatus.user;
    
    if (retweetStatus) {
        
        _retweetView.hidden = NO;
        _retweetView.frame = _statusFrame.retweetViewF;
        
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
        
    }else{
    
        _retweetView.hidden = YES;
    }

}

- (void) setButtomViewFrame{

    _statusToolbar.frame = _statusFrame.statusToolbarF;
    _statusToolbar.status = _statusFrame.status;

}
@end