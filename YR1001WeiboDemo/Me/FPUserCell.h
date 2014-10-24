//
//  FPUserCell.h
//  FPWeibot
//
//  Created by Rocky on 14-9-28.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FPUserCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *currentImageView;
@property (weak, nonatomic) IBOutlet UILabel *currentUserName;
@property (weak, nonatomic) IBOutlet UILabel *currentUserInfo;
@property (weak, nonatomic) IBOutlet UIImageView *vip;
@property (weak, nonatomic) IBOutlet UIButton *friendCount;
@property (weak, nonatomic) IBOutlet UIButton *followersCount;
@property (weak, nonatomic) IBOutlet UIButton *statusCount;

+ (FPUserCell *)userCell;
+ (NSString *)cellID;
- (void) currentUserIconWithString:(NSString *)userIcon currentUserInfo:(NSString *)info currentUserName:(NSString *)name;
- (void) buttonTitleWithStatusCount:(id)statusCount friendsCount:(id)friendCount followersCount:(id)followersCount;
@end
