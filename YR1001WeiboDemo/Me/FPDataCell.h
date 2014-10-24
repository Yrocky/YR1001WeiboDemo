//
//  FPDataCell.h
//  FPWeibot
//
//  Created by Rocky on 14-9-28.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FPDataCell;
@protocol FPDataCellDelegate <NSObject>

@optional
- (void) dataCell:(FPDataCell *)dataCell statusButtonDidClick:(UIButton *)statusButton;
- (void) dataCell:(FPDataCell *)dataCell likeButtonDidClick:(UIButton *)likeButton;
- (void) dataCell:(FPDataCell *)dataCell obverButtonDidClick:(UIButton *)obverButton;

@end

@interface FPDataCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *statusButton;// 微博数
@property (weak, nonatomic) IBOutlet UIButton *likeButton;// 粉丝数
@property (weak, nonatomic) IBOutlet UIButton *obverButton;// 关注数

@property (weak ,nonatomic) id<FPDataCellDelegate> delegate;

+ (FPDataCell *)dataCell;
+ (NSString *)cellID;

- (void) buttonTitleWithStatusCount:(NSString *)statusCount friendsCount:(NSString *)friendCount followersCount:(NSString *)followersCount;
@end
