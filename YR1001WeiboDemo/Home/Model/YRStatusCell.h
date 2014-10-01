//
//  YRStatusCell.h
//  YRTestOne
//
//  Created by Rocky on 14-9-29.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YRStatusFrame;
@class YRStatusCell;


@protocol YRStatusCellDelegate <NSObject>

@optional
/** cell中的用户头像被点击 */
- (void) statusCell:(YRStatusCell *)statusCell avatarLargeButtonDidClick:(UIButton *)avatarLargeButton;

@end

@interface YRStatusCell : UITableViewCell

@property (nonatomic ,retain) id<YRStatusCellDelegate> delegate;

@property (nonatomic ,retain) YRStatusFrame *statusFrame;




+ (YRStatusCell *) creatCellWithTableView:(UITableView *)tableView;



@end
