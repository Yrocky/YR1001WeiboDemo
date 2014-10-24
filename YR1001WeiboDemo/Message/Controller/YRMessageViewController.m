//
//  YRMessageViewController.m
//  YRTestOne
//
//  Created by Rocky on 14-9-26.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import "YRMessageViewController.h"
#import "YRSendWeiboController.h"
#import "TSActionSheet.h"
#import "YRQRCodeController.h"
#import "YRSinaRequestDelegate.h"
#import "UIImageView+WebCache.h"
#import "ChineseToPinyin.h"
#import "CustomSearchBar.h"

#define kBorder         10
#define kIconWH         30
#define kCellHeight     50
#define kCellWidth      cell.contentView.bounds.size.width

#define kViewWidth      self.view.frame.size.width
#define kSearchBarHeight 44


@interface YRMessageViewController ()<UISearchBarDelegate,SinaWeiboRequestDelegate>
/**
 *  装有最原始的每一个用户的信息的数组
 */
@property (nonatomic ,retain) NSArray *users;
/**
 *  装有section的title和对应的用户信息的字典
 */
@property (nonatomic ,retain) NSDictionary *titleAndUsersDict;
/**
 *  装有每一个section的title的数组
 */
@property (nonatomic ,retain) NSArray *sectionTitleArray;
@end

@implementation YRMessageViewController

- (id)initWithStyle:(UITableViewStyle)style{

    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.rowHeight = kCellHeight;
    
    // 加载数据
    [self loadData];

    // 添加左右item
    [self sendWeiboItem];
    
    // 添加searchBar到tableViewHeaderView
    [self addSearchBar];
}

- (void) loadData{

    // 用于查询好友列表的API接口  next_cursor
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    [parmas setObject:appDelegate.sinaWeibo.userID forKey:@"uid"];
//    [parmas setObject:@100 forKey:@"next_cursor"];
    [appDelegate.sinaWeibo requestWithURL:@"friendships/friends.json" params:parmas httpMethod:@"GET" delegate:self];
}

- (void) sendWeiboItem{

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNormalImageName:@"userinfo_tabicon_search" highlightedImageName:@"userinfo_tabicon_search_highlighted" andTarget:self action:@selector(senderWeibo:)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithNormalImageName:@"navigationbar_pop_os7" highlightedImageName:@"navigationbar_pop_highlighted_os7" andTarget:self action:@selector(qRCode:touch:)];
// 这里的button事件可以传三个参数，一个是本身(UIButton)，一个是点击点(UIEvent)，最后一个是什么也不传
    
}
- (void) senderWeibo:(UIBarButtonItem *)sender{

}

- (void) qRCode:(UIBarButtonItem *)sender touch:(UIEvent *)event{

    TSActionSheet *actionSheet = [[TSActionSheet alloc] initWithTitle:@""];
    actionSheet.titleColor = [UIColor orangeColor];
    actionSheet.popoverBaseColor = [UIColor grayColor];
    actionSheet.alpha = 0.7;
    actionSheet.cornerRadius = 0;
    [actionSheet addButtonWithTitle:@"扫描二维码" block:^{
        YRQRCodeController *qrCode = [[YRQRCodeController alloc] init];
        [self presentViewController:qrCode animated:YES completion:^{
        
        }];
        NSLog(@"glehl");
    }];
    [actionSheet showWithTouch:event];
}

#pragma mark - 添加searchBar到tableViewheaderView
- (void) addSearchBar{

    CustomSearchBar *searchBar = [CustomSearchBar searchBar];
    searchBar.frame = CGRectMake(kBorder, kBorder, kViewWidth, kSearchBarHeight);
    self.tableView.tableHeaderView = searchBar;
}

#pragma mark - UITableViewController Delegate
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    // 每一个title对应下的用户的个数
    return [_titleAndUsersDict[_sectionTitleArray[section]] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
// 还可以写成 _sectionTitleArray.count
    return _titleAndUsersDict.allKeys.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
// 返回每一个section的title
    return _sectionTitleArray[section];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifity = @"friend";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifity];
    if (nil == cell) {
     
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifity];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kBorder, kBorder, kCellHeight - 2 * kBorder, kCellHeight - 2 * kBorder)];
        imageView.tag = 10000;
        [cell.contentView addSubview:imageView];

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + kBorder, kBorder, kCellWidth - kCellHeight - 5 * kBorder , kCellHeight)];
        label.tag = 10001;
        [cell.contentView addSubview:label];

    }
    // 取出来的都是一个个的用户 -->数组
    NSArray *usersArray = _titleAndUsersDict[_sectionTitleArray[indexPath.section]];
    
    // 取出来的是每一个用户 -->字典
    NSDictionary *user = usersArray[indexPath.row];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:10000];
    NSString *url = [user valueForKey:@"avatar_large"];
    [imageView setImageWithURL:[NSURL URLWithString:url]];
    
    UILabel *label = (UILabel *) [cell viewWithTag:10001];
    label.text = [user valueForKey:@"screen_name"];
    
    return cell;
}

// 在右边显示快速搜索方法
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{

    return _sectionTitleArray;
}

#pragma mark - sinaWeiboRequestDelegate
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{

    NSArray *users = [result valueForKeyPath:@"users"];
    self.users = users;
    [self doSomthing];
    [self.tableView reloadData];
    
}

- (void) doSomthing{

    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    
    for (NSDictionary *dict in _users) {
        NSString *nameString = dict[kUserScreenName];
        NSString *firstLetter = nil;
        // 可以转化成ASCII说明是字母或者汉字
        if ([nameString canBeConvertedToEncoding:NSASCIIStringEncoding]) {
            firstLetter = [[NSString stringWithFormat:@"%c",[nameString characterAtIndex:0]] uppercaseString];
        }else{
            firstLetter = [[NSString stringWithFormat:@"%c", pinyinFirstLetter([nameString characterAtIndex:0])] uppercaseString];
        }
        
        // 如果首字符不是字母，就归为#  这是为什么??
        if (!isalpha([firstLetter characterAtIndex:0])) {
            firstLetter = @"#";
        }
     
        // 这句就是说将可变字典里面的firstLetter键的值设置为tempDict
        NSMutableArray *tempArr = mutableDict[firstLetter];
        
        if (tempArr == nil) {// 数组中没有值，进行初始化数组
            
            tempArr = [NSMutableArray array];
            [tempArr addObject:dict];
            [mutableDict setObject:tempArr forKey:firstLetter];
            
        }else{// 说明字典中已经有值，直接添加
        
            [tempArr addObject:dict];
        }
        // 这个语句走完就说明已经进行了针对于首字母区分不同数组的操作
    }
    
    _titleAndUsersDict = mutableDict;
    // 对数组中的title进行排序
    NSMutableArray *sortArray = [[[_titleAndUsersDict allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] mutableCopy];// 这里为什么要进行mutableCopy？？？？
    
    // 取出#所在数组中的位置
    NSInteger indexOf = [sortArray indexOfObject:@"#"];
    if (indexOf != NSNotFound) {
        [sortArray removeObjectAtIndex:indexOf];
        [sortArray addObject:@"#"];
    }
    _sectionTitleArray = sortArray;
    
}

@end
