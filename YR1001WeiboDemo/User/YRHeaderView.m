//
//  YRHeaderView.m
//  YR1001WeiboDemo
//
//  Created by YeungRocky on 14-10-12.
//  Copyright (c) 2014年 YeungRocky. All rights reserved.
//

#import "YRHeaderView.h"
#import "YRUser.h"
#import "UIImageView+WebCache.h"
#import "YRStatus.h"
#import "YRStatusFrame.h"

#define kColorGray [UIColor grayColor]
#define kColorWhite [UIColor whiteColor]
#define kColorBlack [UIColor blackColor]
#define kColorOrange [UIColor orangeColor]
#define kIconWH 60
#define kBorder 10

#define kBgImageY 100
#define kNameH 20
#define kFriendH 20
#define kDescriH 15

@interface YRHeaderView ()

@end
@implementation YRHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

//        self.backgroundColor = YRColor(255, 255, 255, 1);
        UIImageView *bgImageView = [[UIImageView alloc] init];
        bgImageView.image = [UIImage imageNamed:@"page_cover_radio_background@2x.jpg"];
        [self addSubview:bgImageView];
//        bgImageView.backgroundColor = [UIColor blueColor];
        self.bgImageView = bgImageView;
        
        UIImageView *iconImageView = [[UIImageView alloc] init];
        [self addSubview:iconImageView];
//        iconImageView.image = [UIImage imageNamed:@"avatar_default_big"];
        iconImageView.layer.cornerRadius = kIconWH * 0.5;
        iconImageView.clipsToBounds = YES;
        iconImageView.layer.borderWidth = 4;
//        iconImageView.layer.shadowOffset = CGSizeMake(2, 2);
//        iconImageView.layer.shadowColor = kColorGray.CGColor;
        iconImageView.layer.borderColor = [UIColor colorWithRed:244 green:244 blue:244 alpha:0.5].CGColor;
        iconImageView.layer.opaque = YES;
//        iconImageView.backgroundColor = [UIColor greenColor];
        self.iconImageView = iconImageView;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = kTextFont;
//        nameLabel.backgroundColor = [UIColor purpleColor];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.textColor = kColorWhite;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UILabel *friendsLabel = [[UILabel alloc] init];
        friendsLabel.font = kTextFont;
//        friendsLabel.backgroundColor = [UIColor orangeColor];
        friendsLabel.textAlignment = NSTextAlignmentRight;
        friendsLabel.textColor = kColorWhite;
        [self addSubview:friendsLabel];
        self.friendsLabel = friendsLabel;

        UILabel *followersLabel = [[UILabel alloc] init];
        followersLabel.font = kTextFont;
//        followersLabel.backgroundColor = [UIColor redColor];
        followersLabel.textAlignment = NSTextAlignmentLeft;
        followersLabel.textColor = kColorWhite;
        [self addSubview:followersLabel];
        self.followersLabel = followersLabel;
        
        UILabel *bgLabel = [[UILabel alloc] init];
        bgLabel.backgroundColor = YRColor(255, 255, 255, 1);
        
        [self addSubview:bgLabel];
        self.bgLabel = bgLabel;
        
        UIButton *senderButton = [[UIButton alloc] init];
        senderButton.titleLabel.font = kTextFont;
        senderButton.layer.cornerRadius = 3;
        senderButton.layer.borderWidth = 1;
        senderButton.layer.borderColor = kColorGray.CGColor;
        senderButton.contentEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0);
        [senderButton setImage:[UIImage imageNamed:@"statusdetail_icon_comment"] forState:UIControlStateNormal];
        [senderButton setTitle:@"私信" forState:UIControlStateNormal];
        [senderButton setTitle:@"私信" forState:UIControlStateHighlighted];
        [senderButton setTitleColor:kColorGray forState:UIControlStateNormal];
//        [senderButton setTitleColor:kColorGray forState:UIControlStateHighlighted];
        [self addSubview:senderButton];
        self.senderButton = senderButton;
        
        UIButton *friendButton = [[UIButton alloc] init];
//        friendButton.backgroundColor = [UIColor purpleColor];
        friendButton.layer.borderWidth = 1;
        friendButton.layer.cornerRadius = 3;
        friendButton.layer.borderColor = kColorGray.CGColor;
        friendButton.titleLabel.font = kTextFont;
        [friendButton setTitle:@"取消关注" forState:UIControlStateHighlighted];
        [friendButton setTitle:@"取消关注" forState:UIControlStateNormal];
        [friendButton setTitleColor:kColorOrange forState:UIControlStateHighlighted];
        [friendButton setTitleColor:kColorGray forState:UIControlStateNormal];
        [self addSubview:friendButton];
        self.friendButton = friendButton;
        
        UILabel *descripitionLabel = [[UILabel alloc] init];
        [self addSubview:descripitionLabel];
        descripitionLabel.numberOfLines = 0;
//        descripitionLabel.backgroundColor = [UIColor orangeColor];
        descripitionLabel.font = [UIFont systemFontOfSize:12];
        descripitionLabel.textAlignment = NSTextAlignmentCenter;
        descripitionLabel.textColor = kColorGray;
        self.descripitionLabel = descripitionLabel;
        
    }
    return self;
}

- (void)setStatusFrame:(YRStatusFrame *)statusFram{

    _statusFrame = statusFram;
    YRStatus *status = _statusFrame.status;
    YRUser *user = status.user;
    [_iconImageView setImageWithURL:[NSURL URLWithString:user.avatar_large] placeholderImage:[UIImage imageNamed:@"avatar_default_big"]];
    _nameLabel.text = user.name;

    if ([user.verified_reason isEqualToString:@""]) {

        _descripitionLabel.text = [NSString stringWithFormat:@"用户描述: %@",user.description];
    }else{
    
        _descripitionLabel.text = [NSString stringWithFormat:@"用户认证: %@",user.verified_reason];
    }

    
    NSString *followerStr = [NSString stringWithCount:user.followers_count];
    _followersLabel.text = [NSString stringWithFormat:@"粉丝 %@",followerStr];

    NSString *friendStr = [NSString stringWithCount:user.friends_count];
    _friendsLabel.text = [NSString stringWithFormat:@"关注 %@",friendStr];


    CGFloat viewW = 320;
    CGFloat viewH = 0;
    
    CGFloat iconX = 160 - kIconWH * 0.5;
    CGFloat iconY = 50;
    _iconImageView.frame = CGRectMake(iconX, iconY, kIconWH, kIconWH);
    
    _nameLabel.frame = CGRectMake(0, CGRectGetMaxY(_iconImageView.frame) + kBorder, viewW, kNameH);
    
    _friendsLabel.frame = CGRectMake(0, CGRectGetMaxY(_nameLabel.frame) + kBorder, (viewW - kBorder) * 0.5 , kFriendH);
    
    _followersLabel.frame = CGRectMake(CGRectGetMaxX(_friendsLabel.frame) + kBorder , CGRectGetMinY(_friendsLabel.frame), CGRectGetWidth(_friendsLabel.frame), CGRectGetHeight(_friendsLabel.frame));
    
    _bgImageView.frame = CGRectMake(0, - kBgImageY, viewW, CGRectGetMaxY(_friendsLabel.frame) + kBorder + kBgImageY);
    
    CGSize desSize = [user.description sizeWithFont:kTextFont maxSize:CGSizeMake(viewW - 2 * kBorder, 40)];
    _descripitionLabel.frame = CGRectMake(kBorder, CGRectGetMaxY(_bgImageView.frame) + kBorder * 0.5, desSize.width, desSize.height);
    
    CGFloat senderW = 80;
    CGFloat senderH = 30;
    CGFloat senderX = (viewW - kBorder) * 0.5  - senderW;
    CGFloat senderY = CGRectGetMaxY(_descripitionLabel.frame) + kBorder;
    _senderButton.frame = CGRectMake(senderX, senderY, senderW, senderH);
    
    _friendButton.frame = CGRectMake(CGRectGetMaxX(_senderButton.frame) + kBorder , CGRectGetMinY(_senderButton.frame), CGRectGetWidth(_senderButton.frame), CGRectGetHeight(_senderButton.frame));
    

    CGFloat bgLabelY = CGRectGetMaxY(_bgImageView.frame);
    CGFloat bgLabelH = CGRectGetMaxY(_friendButton.frame) + kBorder - bgLabelY;
    _bgLabel.frame = CGRectMake(0, bgLabelY, 320, bgLabelH);
    
    viewH = CGRectGetMaxY(_senderButton.frame) + 3 * kBorder;

    self.viewH = viewH;

}



@end
