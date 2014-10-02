//
//  YRHomeViewController.m
//  YRTestOne
//
//  Created by Rocky on 14-9-26.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import "YRHomeViewController.h"
#import "YRStatusCell.h"
#import "YRStatus.h"
#import "YRStatusFrame.h"
#import "CustomTitleButton.h"
#import "MJExtension.h"



@interface YRHomeViewController ()<SinaWeiboRequestDelegate,YRStatusCellDelegate>

@property (nonatomic ,retain) UIImageView *rightImageView;

@property (nonatomic ,retain) UIImageView *titleImageView;

@property (nonatomic ,retain) UIRefreshControl *refresh;

@property (nonatomic ,retain) NSArray *statusListArray;

@property (nonatomic ,retain) NSDictionary *userInfoDict;

@property (nonatomic ,retain) NSMutableArray *statusFrameArray;

@end

@implementation YRHomeViewController



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
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0);
    
    // 开始就刷新数据
    [self requestWeiboData];
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
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down_os7"] forState:UIControlStateNormal];
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    [_rightImageView removeFromSuperview];
    [_titleImageView removeFromSuperview];
}

#pragma  mark - UITableViewContoller delegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [_statusFrameArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    // 这里使用cell的一个方法，返回一个封装好的cell
    YRStatusCell *cell = [YRStatusCell creatCellWithTableView:tableView];
    
    cell.statusFrame = _statusFrameArray[indexPath.row];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [_statusFrameArray[indexPath.row] cellHeight];
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
    [appDelegate.sinaWeibo requestWithURL:@"statuses/home_timeline.json" params:[NSMutableDictionary dictionaryWithObject:appDelegate.sinaWeibo.userID forKey:@"uid"] httpMethod:@"GET" delegate:self];
    
    /**
     *  加载用户基本信息
     */
    [appDelegate.sinaWeibo requestWithURL:@"users/show.json" params:[NSMutableDictionary dictionaryWithObject:appDelegate.sinaWeibo.userID forKey:@"uid"] httpMethod:@"GET" delegate:self];
}

#pragma mark - sinaWeiboResquestDelegate
/**
 *  当加载完数据的时候在这里进行调用，接收返回的数据
 *
 */
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{

    /**
     *  将加载控件关闭，并且进行数据的采集
     */
    NSString *urlString = request.url;
    
    if ([urlString isEqualToString:@"https://open.weibo.cn/2/statuses/home_timeline.json"]) {//微博列表
        
//        _statusListArray = [result valueForKey:@"statuses"];// 以前的方法
        // 使用第三方库将一个字典里面的键值对赋值给模型里面的属性,这中间不用进行其他修改,现在_statusListArray数组里面装是模型数据
        _statusListArray = [NSArray array];
        _statusListArray = [YRStatus objectArrayWithKeyValuesArray:[result valueForKey:@"statuses"]];
        [self loadData];

        [self.tableView reloadData];
        /*
         // 将字典数组转为模型数组(里面放的就是IWStatus模型)
         NSArray *statusArray = [IWStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
         
         // 创建frame模型对象
         NSMutableArray *statusFrameArray = [NSMutableArray array];
         
         for (IWStatus *status in statusArray) {
             
             IWStatusFrame *statusFrame = [[IWStatusFrame alloc] init];
             // 传递微博模型数据
             
             statusFrame.status = status;
             
             [statusFrameArray addObject:statusFrame];
         }
         
         // 赋值
         self.statusFrames = statusFrameArray;
         

         */
        
    }else if([urlString isEqualToString:@"https://open.weibo.cn/2/users/show.json"]){//用户信息
        
        _userInfoDict = (NSDictionary *)result;// 获得加载返回的数据,有json事例看到是个字典
        
        NSString *screen_name = [_userInfoDict objectForKey:@"screen_name"];
        UIButton *titleView = (UIButton *)self.navigationItem.titleView;
        
        [titleView setTitle:screen_name forState:UIControlStateNormal];
        [titleView setTitle:screen_name forState:UIControlStateHighlighted];


        
    }else{
    
    }
    [_refresh endRefreshing];
    NSLog(@"endRefreshing");
}

/**
 *  加载数据到模型中，然后对界面进行刷新
 */
- (void) loadData{
    /**
     *   进行一个懒加载
     */
    if (self.statusFrameArray == nil) {
        _statusFrameArray = [NSMutableArray array];
    }
    
    for (YRStatus *status in _statusListArray) {// 从装有模型的数组中取出模型记性frame模型的属性分配，然后使用frame数组装载frame模型，然后进行数据的展示
        
        YRStatusFrame *statusFrame = [[YRStatusFrame alloc] init];
        
        statusFrame.status = status;
        
        [_statusFrameArray addObject:statusFrame];
    }

}

@end
