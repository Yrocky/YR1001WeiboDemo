//
//  YRUserViewController.m
//  YR1001WeiboDemo
//
//  Created by Rocky on 14-10-10.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import "YRUserViewController.h"
#import "UIImageView+WebCache.h"
#import "YRHeaderView.h"
#import "YRStatusCell.h"
#import "YRStatusFrame.h"
#import "YRStatusTopView.h"

@interface YRUserViewController ()
@property (nonatomic ,retain) YRHeaderView *headerView;
@end

@implementation YRUserViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.tableView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
    self.navigationController.navigationBarHidden = YES;
//    self.tableView.
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self addViewToTableViewHeaderView];
    
    UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(addGuestForView:)];
    swip.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swip];
}

- (void) addGuestForView:(UISwipeGestureRecognizer *)guest{


    [self.navigationController popViewControllerAnimated:YES];

}

- (void)viewWillDisappear:(BOOL)animated{

    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}
- (void) addViewToTableViewHeaderView{

    _headerView = [[YRHeaderView alloc] init];
    _headerView.statusFrame = _starusFrame;
    _headerView.frame = CGRectMake(0, 0, kViewBoundsW, _headerView.viewH);
    self.tableView.tableHeaderView = _headerView;
   
    
}

#pragma mark - Table view data source

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YRSmartTableViewCell *cell = nil;
    switch (indexPath.row) {
        case 0:
        {
            
            YRStatusCell *cell = [YRStatusCell creatCellWithTableView:tableView];

            cell.statusFrame = _starusFrame;
            return cell;
        }
            break;
            
        default:
        {
        
            YRSmartTableViewCell *cell = [YRSmartTableViewCell cellWithTableView:tableView style:UITableViewCellStyleDefault];
            cell.textLabel.text = @"faerz";
            return cell;
        }
            break;
    }
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    CGFloat rowHeight;
    switch (indexPath.row) {
        case 0:
            rowHeight = _starusFrame.cellHeight;
            break;
            
        default:
            rowHeight = 44;
            break;
    }
    
    return rowHeight;
}

@end