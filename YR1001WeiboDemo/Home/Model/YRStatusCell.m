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
@property (nonatomic, weak) UIImageView *statusToolbar;




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

    // 1. 底部的视图，是个UIImageView
     UIImageView *topView = [[UIImageView alloc] init];
    [self.contentView addSubview:topView];
    self.topView = topView;
    
    // 2. 用户头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [topView addSubview:iconView];
    self.iconView = iconView;
    
    // 3. 用户昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    [topView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    // 4. VIP
    UIImageView *vipView = [[UIImageView alloc] init];
    [topView addSubview:vipView];
    self.vipView = vipView;
    
    // 5. 微博发送时间
    UILabel *timeLabel = [[UILabel alloc] init];
    [topView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    // 6. 微博发送来源
    UILabel *sourceLabel = [[UILabel alloc] init];
    [topView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    // 7. 微博正文，没有图片
    UILabel *contentLabel = [[UILabel alloc] init];
    [topView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    // 8. 微博图片
    UIImageView *photoImageView = [[UIImageView alloc] init];
    [topView addSubview:photoImageView];
    self.photoView = photoImageView;
    
}

- (void) setRetweetedStatus{
    
    // 1. 转发微博底部的视图，也是UIImageView
    UIImageView *retweetView = [[UIImageView alloc] init];
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    
    // 2. 转发微博的作者
    UIButton *retweetNameButton = [[UIButton alloc] init];
    [retweetNameButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [retweetNameButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [retweetView addSubview:retweetNameButton];
    self.retweetNameButton = retweetNameButton;
    
    // 3. 转发微博的内容
    UILabel *retweetContentLabel = [[UILabel alloc]init];
    [retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    // 4. 转发微博的图片
    UIImageView *retweetPhotoView = [[UIImageView alloc] init];
    [retweetView addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;
    
    
}

- (void) setBottomView{

    UIImageView *statusToolbar = [[UIImageView alloc] init];
    [self.contentView addSubview:statusToolbar];
    self.statusToolbar = statusToolbar;
    // 这上面再添加3个button
}




@end