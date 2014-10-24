//
//  YRCurrentUserViewController.m
//  YR1001WeiboDemo
//
//  Created by Rocky on 14-10-11.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import "YRCurrentUserViewController.h"
#import "FPDataCell.h"
#import "FPUserCell.h"
#import "FPTextCell.h"
#import "UIImageView+WebCache.h"
#import "UIBarButtonItem+BackButton.h"
#import "YRSinaRequestDelegate.h"
#import "YRUserViewController.h"
#import "YRStatusFrame.h"
#import "YRSetupViewController.h"

#define kUserCellHight 127

//#define DBUG

@interface YRCurrentUserViewController ()<SinaWeiboRequestDelegate>
/**
 *  装当前用户的字典
 */
@property (nonatomic ,retain) NSDictionary *currentUser;
/**
 *  装界面上cell的文字
 */
@property (nonatomic ,retain) NSArray *meArray;
/**
 *  相册数，收藏数和点赞数
 */
@property (nonatomic ,retain) NSArray *countArray;
/**
 *  装微博数，关注数和粉丝数
 */
@property (nonatomic ,retain) NSArray *dataArray;
/**
 *  装用户基本设置的数组
 */
@property (nonatomic ,retain) NSArray *userArray;
/**
 *  装其他设置cell图片的数组
 */
@property (nonatomic ,retain) NSArray *otherSetArray;

@property (nonatomic ,retain) YRStatusFrame *statusFrame;
@end

@implementation YRCurrentUserViewController

- (id)initWithStyle:(UITableViewStyle)style{

    if (self == [super initWithStyle:style]) {
        
        [self setNavigationBarButtonItem];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    UINavigationController *navigation = self.tabBarController.viewControllers[0];
    _currentUser = [navigation.visibleViewController valueForKeyPath:@"userInfoDict"];
    
    
    
    
}

- (void) setNavigationBarButtonItem{
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    // 设置字体
    NSMutableDictionary *itemAttribut = [NSMutableDictionary dictionary];
    
    itemAttribut[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    itemAttribut[NSForegroundColorAttributeName] = [UIColor orangeColor] ;
    
    [item setTitleTextAttributes:itemAttribut forState:UIControlStateNormal];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *setupButton = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(setButtonClick:)];
    self.navigationItem.rightBarButtonItem = setupButton;
    [self loadDataToArray];
    
//    [appDelegate.sinaWeibo requestWithURL:@"users/show.json" params:[NSMutableDictionary dictionaryWithObject:appDelegate.sinaWeibo.userID forKey:@"uid"] httpMethod:@"GET" delegate:self];

}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
    
    _currentUser = result;
    [self.tableView reloadData];

}

- (void) setButtonClick:(UIBarButtonItem *)setButton{
    
    NSLog(@"setup button click...");
    YRSetupViewController *setViewController = [[YRSetupViewController alloc] init];

    [self.navigationController pushViewController:setViewController animated:YES];
}
/**
 *  为数组添加数据
 */
- (void) loadDataToArray{
    
    _meArray = [NSArray array];
    _meArray = @[@[[NSNull null]],
                @[@"新的好友",@"完善资料"],
                @[@"我的相册",@"我的收藏",@"赞"],
                @[@"微博支付",@"个性化"],
                @[@"我的名片",@"草稿箱"]];
    
    _countArray = [NSArray arrayWithObjects:@"345", @"123",@"34",nil];
    
    NSString *profileImageUrl = [_currentUser valueForKey:kUserAvatarlager];
    NSString *screenName = [_currentUser valueForKey:kUserScreenName];
    NSString *description = [_currentUser valueForKey:kUserDescription];
    _userArray = [NSArray arrayWithObjects:profileImageUrl,screenName,description, nil];
    
    //    _userArray = @[profileImageUrl,screenName,description];
    
    /**
     *  这个数组装微博，关注，赞
     */
    _dataArray = [NSArray arrayWithObjects: [_currentUser valueForKey:kUserStatusesCount],
                                            [_currentUser valueForKey:kUserFriendsCount],
                                            [_currentUser valueForKey:kUserFollowersCount],nil];
    
    _otherSetArray = [NSArray arrayWithObjects:@[[NSNull null] ],
                                              @[@"new_friend",@"draft"],
                                              @[@"album",@"collect",@"like"],
                                              @[@"pay",@"vip"],
                                              @[@"card",@"draft"],nil];
    
}
#pragma mark - Table view data source
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    NSArray *tempArray = _meArray[section];
    return tempArray.count;// 0x00000002
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [_meArray count];
}

#ifdef DBUG
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *ad = @"faeg";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ad];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ad];
    }
    
    return cell;
}
#else
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        // 微博用户信息cell
        FPUserCell *cell = [tableView dequeueReusableCellWithIdentifier:[FPUserCell cellID]];
        if (nil == cell) {
            
            cell = [FPUserCell userCell];
        }
        if (_userArray.count > 0 ) {
            
            [cell currentUserIconWithString:_userArray[0] currentUserInfo:_userArray[2] currentUserName:_userArray[1]];
        }
        if (_dataArray.count > 0) {
            [cell buttonTitleWithStatusCount:_dataArray[0] friendsCount:_dataArray[1] followersCount:_dataArray[2]];
        }
        return cell;
    }else{
        // 其他的微博信息cell
        
        FPTextCell *cell = [tableView dequeueReusableCellWithIdentifier:[FPTextCell cellID]];
        
        if (nil == cell) {
            cell = [FPTextCell textCell];
            
        }
        if (indexPath.section == 2) {
            
            NSString *string = [NSString stringWithFormat:@"%@ (%@)",_meArray[indexPath.section][indexPath.row],_countArray[indexPath.row]];
            
            cell.meLabel.text = string;
            
        }else{
            
            cell.meLabel.text = _meArray[indexPath.section][indexPath.row];
            
        }
        cell.setImageView.image = [UIImage imageNamed: _otherSetArray[indexPath.section][indexPath.row]];
        
        return cell;
        
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        return kUserCellHight;
        
    }else{
        return 44;
        
    }
}
#endif

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0 && indexPath.row == 0 ) {
        
        YRUserViewController *userVC = [[YRUserViewController alloc] init];
//        userVC.starusFrame = 
        [self.navigationController pushViewController:userVC animated:YES];
    }
}
@end

