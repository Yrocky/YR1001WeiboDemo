//
//  FPBaseSetupController.h
//  FPWeibot
//
//  Created by qingyun on 14-9-26.
//  Copyright (c) 2014年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface FPBaseSetupController : UITableViewController
/**
 *  计算cell的全局位置
 *
 */
- (int) indexCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
/**
 *  为cell添加一个固定大小并且拥有一个图片的UIImageView
 *
 */
- (UIImageView *)cellAddImageView;
@end
