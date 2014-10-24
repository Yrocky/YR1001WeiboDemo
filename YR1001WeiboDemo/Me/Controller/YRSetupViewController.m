//
//  YRSetupViewController.m
//  YR1001WeiboDemo
//
//  Created by YeungRocky on 14-10-13.
//  Copyright (c) 2014年 YeungRocky. All rights reserved.
//

#import "YRSetupViewController.h"

@interface YRSetupViewController ()
@property (nonatomic ,retain) NSDictionary *SetupInfo;
@end

@implementation YRSetupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _SetupInfo = @{@"0" : @[@"清除缓存",@"夜间模式"],
                   @"1" : @[@"提醒和通知",@"通用设置",@"隐私与安全"],
                   @"2" : @[@"意见反馈",@"关于微博"],
                   @"3" : @[@"账号管理"],
                   };
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    // Do any additional setup after loading the view.
}
#pragma mark - UItableViewDelegate
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    NSArray *key = [_SetupInfo allKeys];
    return [[_SetupInfo valueForKey:key[section]] count];
}


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{


    return [[_SetupInfo allKeys] count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YRSmartTableViewCell *cell = [YRSmartTableViewCell cellWithTableView:tableView style:UITableViewCellStyleDefault];

    NSArray *key = [_SetupInfo allKeys];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [_SetupInfo valueForKey:key[indexPath.section]][indexPath.row];
    
    return cell;
}

@end
