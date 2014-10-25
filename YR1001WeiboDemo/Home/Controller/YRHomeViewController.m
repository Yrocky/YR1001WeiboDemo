//
//  YRHomeViewController.m
//  YRTestOne
//
//  Created by Rocky on 14-9-26.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import "YRHomeViewController.h"
#import "YRStatusCell.h"
#import "YRUser.h"
#import "YRStatus.h"
#import "YRStatusFrame.h"
#import "CustomTitleButton.h"
#import "MJExtension.h"
#import "YRWeiboDataBase.h"
//#import "YRSinaRequestDelegate.h"
#import "YRStatusToolBar.h"
#import "YRRCAButton.h"
#import "YRUserViewController.h"
#import "YRStatusTopView.h"

@interface YRHomeViewController ()<SinaWeiboRequestDelegate,YRStatusCellDelegate,YRStatusToolBarDelegate,YRStatusTopViewDelegate>

@property (nonatomic ,retain) UIImageView *rightImageView;

@property (nonatomic ,retain) UIImageView *titleImageView;

@property (nonatomic ,retain) UIRefreshControl *refresh;

@property (nonatomic ,retain) NSArray *statusListArray;

@property (nonatomic ,retain) NSDictionary *userInfoDict;

@property (nonatomic ,retain) NSMutableArray *statusFrameArray;

@end

@implementation YRHomeViewController

- (NSMutableArray *)statusFrameArray{
    /**
     *   进行一个懒加载
     */
    if (!_statusFrameArray) {
        _statusFrameArray = [NSMutableArray array];
    }
    return _statusFrameArray;
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    // 这里是进行数据库的值的判断,
//    NSArray *array = [[YRWeiboDataBase shareWeiboDataBase] queryTimeLinesFromDataBase];
//    _statusListArray = [YRStatus objectArrayWithKeyValuesArray:array];
//    if (_statusListArray == nil) {
//        [self requestWeiboData];
//    }
//    _userInfoDict = [[YRWeiboDataBase shareWeiboDataBase] queryUserInfoFromDataBaseFromUserId:@""];
//    if (_userInfoDict == nil) {
////        [self requestWeiboData];
//    }
    
//    self.navigationController.tabBarController.tabBar.hidden = NO;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    /**
     *  自定义导航栏
     */
    [self customNavigationBar];

    [self setRefresh];
    
    self.tableView.backgroundColor = YRColor(236, 236, 236, 1);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(70, 0, 0, 0);
    
//    self.hidesBottomBarWhenPushed = YES;
}


- (void)customNavigationBar
{
    /**
     *  设置导航栏右边按钮
     *
     */
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithNormalImageName:@"navigationbar_pop_os7" highlightedImageName:@"navigationbar_pop_highlighted_os7" andTarget:self action:@selector(onRightButton:)];
    /**
     *  设置导航栏左边按钮
     *
     */
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNormalImageName:@"navigationbar_friendsearch_os7" highlightedImageName:@"navigationbar_friendsearch_highlighted_os7" andTarget:self action:@selector(onLeftButton:)];
    /**
     *  设置导航栏中间视图
     */
    CustomTitleButton *titleButton = [CustomTitleButton titleButton];
    titleButton.frame = CGRectMake(0, 0, 100, 30);
    [titleButton setTitle:@"测试用户" forState:UIControlStateNormal];
    titleButton.tag = kDownImageTag;
    [titleButton addTarget:self action:@selector(onTitleButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
}

- (void) setRefresh{
    /**
     加载一个刷新控件
     
     */
    _refresh = [[UIRefreshControl alloc] initWithFrame:CGRectMake(10, 20, 30, 30)];
    
    _refresh.backgroundColor = [UIColor clearColor];
    
    [_refresh addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    
    //每一个tableView控制器都有一个refresh控制器
    self.refreshControl = _refresh;
    
    [self refresh:_refresh];
}

#pragma mark - BarButtonItem

- (void) onRightButton:(UIButton *)sender{

    NSLog(@"RightButton : pop出二维码视图");
    
    if (!sender.tag == kPopRightImageTag) {
        
        _rightImageView = [UIImage popImageViewWithImageName:@"popover_background_right" frame:CGRectMake(kViewBoundsW - kPopRightAndLeftImageW - 5, kPopImageY, kPopRightAndLeftImageW, kPopRightAndLeftImageH)];
        
        [self.navigationController.navigationBar addSubview:_rightImageView];
        sender.tag = 1;
        NSLog(@"pop出现");
    }else{
        sender.tag = 0;
        [_rightImageView removeFromSuperview];
        NSLog(@"pop消失");
    }
}

- (void) onLeftButton:(UIButton *)sender{

    NSLog(@"LeftButton :进入添加好友界面");
}

- (void) onTitleButton:(CustomTitleButton *)sender{


    if (sender.tag == kDownImageTag) {
        
        [sender setImage:[UIImage imageNamed:@"navigationbar_arrow_up_os7"] forState:UIControlStateNormal];
        sender.tag = kUpImageTag;
        NSLog(@"出现pop");
        
        _titleImageView = [UIImage popImageViewWithImageName:@"popover_background" frame:CGRectMake((kViewBoundsW - kPopTitleImageW) * 0.5, kPopImageY, kPopTitleImageW, kPopTitleImaheH)];
        
        [self.navigationController.navigationBar addSubview:_titleImageView];
        
    }else{
    
        [sender setImage:[UIImage imageNamed:@"navigationbar_arrow_down_os7"] forState:UIControlStateNormal];
        sender.tag = kDownImageTag;
        NSLog(@"消失pop");
        
        [_titleImageView removeFromSuperview];
    }
}



#pragma  mark - UITableViewContoller delegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [_statusFrameArray count];
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//
//    return [_statusFrameArray count];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    // 这里使用cell的一个方法，返回一个封装好的cell
    YRStatusCell *cell = [YRStatusCell creatCellWithTableView:tableView];
    cell.delegate = self;
    cell.statusFrame = _statusFrameArray[indexPath.row];
    cell.statusToolbar.delegate = self;
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [_statusFrameArray[indexPath.row] cellHeight];
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
}

#pragma mark - refresh控制器的方法
- (void) refresh:(UIRefreshControl *)sender{

    [_refresh beginRefreshing];
    
    [self requestWeiboData];
}

- (void) requestWeiboData{

    //微博对象进行网络请求数据 (通过网络接口)
    /**
     *  加载用户消息列表
     */
    NSMutableDictionary *paramsDict = [NSMutableDictionary dictionary];
    paramsDict[@"uid"] = appDelegate.sinaWeibo.userID;
//    paramsDict[@"count"] = @20;
    
    if (_statusFrameArray.count) {
        
        YRStatusFrame *lastObj = self.statusFrameArray[0];
        paramsDict[@"since_id"] = lastObj.status.idstr;
    }
    [appDelegate.sinaWeibo requestWithURL:@"statuses/home_timeline.json" params:paramsDict httpMethod:@"GET" delegate:self];
    
    /**
     *  加载用户基本信息
     */
    [appDelegate.sinaWeibo requestWithURL:@"users/show.json" params:[NSMutableDictionary dictionaryWithObject:appDelegate.sinaWeibo.userID forKey:@"uid"] httpMethod:@"GET" delegate:self];
}

#pragma mark - sinaWeiboResquestDelegate的通知方法
/**
 *  当加载完数据的时候在这里进行调用，接收返回的数据
 *
 */
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    
    // 请求的语句
    NSString *requestUrl = request.url;

    /**
     *  将加载控件关闭，并且进行数据的采集
     */
    if ([requestUrl isEqualToString:@"https://open.weibo.cn/2/statuses/home_timeline.json"]) {//微博列表
        
        _statusListArray = [YRStatus objectArrayWithKeyValuesArray:[result valueForKey:@"statuses"]];
        
#warning 这里肯定会出错，因为写的是两个不同的方法，
//        [[YRWeiboDataBase shareWeiboDataBase] saveTimeLinesToDataBase:[result valueForKey:@"statuses"]];
        

        NSMutableArray *statusFrameArray = [NSMutableArray array];
        
        // 从装有模型的数组中取出模型进行frame模型的属性分配，然后使用frame数组装载frame模型，然后进行数据的展示
        for (YRStatus *status in _statusListArray) {
            
            YRStatusFrame *statusFrame = [[YRStatusFrame alloc] init];
            
            statusFrame.status = status;
            
            [statusFrameArray addObject:statusFrame];
        }
        // 这里将新请求得来的数据追加进临时数组，然后将老数据也追加进去，再把临时数组赋给要展示的数组里
        
        NSMutableArray *tmpArray = [NSMutableArray array];
        [tmpArray addObjectsFromArray:statusFrameArray];
        [tmpArray addObjectsFromArray:self.statusFrameArray];
        self.statusFrameArray = tmpArray;

        [self.tableView reloadData];
        
        [self showNewStatusCount:statusFrameArray.count];
    
    }else if([requestUrl isEqualToString:@"https://open.weibo.cn/2/users/show.json"]){//用户信息
        
        _userInfoDict = (NSDictionary *)result;// 获得加载返回的数据,有json事例看到是个字典
        
#warning 这里也一样，可能会出错
//        [[YRWeiboDataBase shareWeiboDataBase] saveUserInfoToDataBase:_userInfoDict withStatusID:nil];
        
        NSString *screen_name = [_userInfoDict objectForKey:@"screen_name"];
        UIButton *titleView = (UIButton *)self.navigationItem.titleView;
        
        [titleView setTitle:screen_name forState:UIControlStateNormal];
        [titleView setTitle:screen_name forState:UIControlStateHighlighted];
    }else{

        return;
    }
    [_refresh endRefreshing];
    NSLog(@"endRefreshing");
}

#pragma mark - 加载提示

- (void) showNewStatusCount:(int) count{
    
    UIButton *button = [[UIButton alloc] init];
    button.userInteractionEnabled = NO;
    [button setBackgroundImage:[UIImage imageWithName:@"timeline_new_status_background"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    
    NSString *title;
    if (count) {
        title = [NSString stringWithFormat:@"加载%d条新微博",count];
    }else{
        title = [NSString stringWithFormat:@"没有新微博加载"];
        
    }
    [button setTitle:title forState:UIControlStateNormal];
    CGFloat buttonW = self.view.frame.size.width;
    CGFloat buttonH = 30;
    CGFloat buttonY = 64 - buttonH;
    button.frame = CGRectMake(0, buttonY, buttonW, buttonH);
    [self.navigationController.view insertSubview:button belowSubview:self.navigationController.navigationBar];
    
    [UIView animateWithDuration:0.7 animations:^{
        
        button.transform = CGAffineTransformMakeTranslation(0, buttonH);
        
    } completion:^(BOOL finished) {
       [UIView animateWithDuration:0.7 delay:1 options:UIViewAnimationOptionCurveLinear animations:^{
           // 这个属性是将所有的transForm改变置为空
           button.transform = CGAffineTransformIdentity;
       } completion:^(BOOL finished) {
           [button removeFromSuperview];
       }];
        
    }];
}

#pragma mark - 点击头像的代理方法
- (void)statusIconDidClick:(YRStatusCell *)statusCell{
    
    YRUserViewController *userVC = [[YRUserViewController alloc] init];

    userVC.starusFrame = statusCell.statusFrame;
    
    [self.navigationController pushViewController:userVC animated:YES];
    
}


#pragma mark - 转发评论点赞按钮的代理事件 

/** 转发按钮被点击 */
- (void) statusToolBar:(YRStatusToolBar *)statusToolBar repostsButtonDidClick:(YRRCAButton *)reposts{

    NSLog(@"进入转发页面");
}
/** 评论按钮被点击 */
- (void)statusToolBar:(YRStatusToolBar *)statusToolBar commentsButtonDidClick:(YRRCAButton *)comments{
    NSLog(@"进入评论页面");
}

- (void)statusToolBar:(YRStatusToolBar *)statusToolBar attitudesButtonDidClick:(YRRCAButton *)attitudes{

}



@end
