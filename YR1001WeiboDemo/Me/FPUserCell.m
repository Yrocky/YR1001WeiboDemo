//
//  FPUserCell.m
//  FPWeibot
//
//  Created by Rocky on 14-9-28.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import "FPUserCell.h"
#import "UIImageView+WebCache.h"

@implementation FPUserCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (NSString *)cellID{


    return @"user";
}

+ (FPUserCell *)userCell{

    return [[NSBundle mainBundle] loadNibNamed:@"FPSetupCell" owner:nil options:nil][1];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void) currentUserIconWithString:(NSString *)userIcon currentUserInfo:(NSString *)info currentUserName:(NSString *)name{

    [self.currentImageView setImageWithURL:[NSURL URLWithString:userIcon]];
    self.currentUserInfo.text = info;
    self.currentUserName.text = name;
}

- (void)buttonTitleWithStatusCount:(id)statusCount friendsCount:(id)friendCount followersCount:(id)followersCount{


    NSString *adsfds = [NSString stringWithFormat:@"%@",statusCount];
    [_statusCount setTitle:adsfds forState:UIControlStateNormal];
    
    [_statusCount setTitle:adsfds forState:UIControlStateHighlighted];
    
    NSString *fsdgk = [NSString stringWithFormat:@"%@",friendCount];
    [_friendCount setTitle:fsdgk forState:UIControlStateNormal];
    
    [_friendCount setTitle:fsdgk forState:UIControlStateHighlighted];
    
    NSString *ikk = [NSString stringWithFormat:@"%@",followersCount];
    [_followersCount setTitle:ikk forState:UIControlStateNormal];
    
    [_followersCount setTitle:ikk forState:UIControlStateHighlighted];
    
}
@end
