//
//  FPTextCell.h
//  FPWeibot
//
//  Created by Rocky on 14-9-28.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FPTextCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *meLabel;
@property (weak, nonatomic) IBOutlet UIImageView *setImageView;


+ (FPTextCell *) textCell;
+ (NSString *)cellID;

@end
