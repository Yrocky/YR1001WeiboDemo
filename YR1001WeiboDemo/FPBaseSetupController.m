//
//  FPBaseSetupController.m
//  FPWeibot
//
//  Created by qingyun on 14-9-26.
//  Copyright (c) 2014年 qingyun. All rights reserved.
//

#import "FPBaseSetupController.h"
#import "UIBarButtonItem+BackButton.h"

@interface FPBaseSetupController ()

@end

@implementation FPBaseSetupController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
//    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
/**
 *  为每个继承的视图控制器添加一个返回的按钮
 *
 *  @param backNextViewController: UIBarButtonItem 的一个分类方法，里面有一个image为返回箭头的button
 */
    UIBarButtonItem *backBarButtonItem = [UIBarButtonItem backButtonWithTarget:self action:@selector(backNextViewController:)];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    self.navigationItem.hidesBackButton = YES;

    self.tableView.showsVerticalScrollIndicator = NO;

}


#pragma mark - 返回根视图控制器
/**
 *  统一响应一个返回上一个页面的事件
 *
 *  @param sender 传件来一个按钮
 */
- (void) backNextViewController:(UIButton *)sender{

    NSLog(@"back viewController");
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (int) indexCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    
    NSInteger index = 0;
    
    for (int i = 0; i < indexPath.section; i ++) {
        index += [tableView numberOfRowsInSection:i];
    }
    
    index += indexPath.row ;
    
    return index;
    
}


- (UIImageView *)cellAddImageView{
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]]  ;
    imageView.frame = CGRectMake(70, 7, 16, 16);
    return imageView;
}

@end
