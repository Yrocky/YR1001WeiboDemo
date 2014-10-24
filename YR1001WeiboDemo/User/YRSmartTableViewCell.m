//
//  YRSmartTableViewCell.m
//  YR1001WeiboDemo
//
//  Created by YeungRocky on 14-10-13.
//  Copyright (c) 2014年 YeungRocky. All rights reserved.
//

#import "YRSmartTableViewCell.h"

@implementation YRSmartTableViewCell

- (id) initWithIdentifier:(NSString *)identifier style:(UITableViewCellStyle)style{

    return [self initWithStyle:style reuseIdentifier:identifier];
}


+ (id) cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{

    NSString *identifier = [self cellIdentifier];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[self alloc] initWithIdentifier:identifier style:style];
    }
    
    return cell;

}

+ (NSString *) cellIdentifier{

    return NSStringFromClass([self class]);
}

- (void)layoutSubviews{

    [super layoutSubviews];
    // 在这里进行一些子控件的排列
}
@end
