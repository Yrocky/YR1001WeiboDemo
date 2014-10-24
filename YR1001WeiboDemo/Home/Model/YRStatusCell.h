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
@class YRStatusToolBar;
@class YRStatusTopView;

@protocol YRStatusCellDelegate <NSObject>

@optional
/** cell中的用户头像被点击 */
- (void) statusIconDidClick:(YRStatusCell *)statusCell;

@end

@interface YRStatusCell : UITableViewCell
/**
 *  代理用weak
 */
@property (nonatomic ,weak) id<YRStatusCellDelegate> delegate;

@property (nonatomic ,retain) YRStatusFrame *statusFrame;


/** 顶部的view */  
@property (nonatomic, weak) YRStatusTopView *topView;

/** 微博的工具条 */
@property (nonatomic, weak) YRStatusToolBar *statusToolbar;



+ (YRStatusCell *) creatCellWithTableView:(UITableView *)tableView;



@end
