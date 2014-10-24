//
//  YRDiscoverViewController.m
//  YR1001WeiboDemo
//
//  Created by YeungRocky on 14-10-12.
//  Copyright (c) 2014年 YeungRocky. All rights reserved.
//

#import "YRDiscoverViewController.h"
#import "CustomSearchBar.h"


@interface YRDiscoverViewController ()<UITextFieldDelegate>

@end

@implementation YRDiscoverViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CustomSearchBar *searchBar = [CustomSearchBar searchBar];
    searchBar.frame = CGRectMake(0, 0, 300, 34);
    searchBar.delegate = self;
    searchBar.placeholder = @"大家都在搜：吃饭须先画押";
    self.navigationItem.titleView = searchBar;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/
#pragma mark - searchBar的代理事件 
- (BOOL) textFieldShouldReturn:(UITextField *)textField{

    NSString *searchText = textField.text;
    
    NSLog(@"您搜索的内容是:%@",searchText);
    
    [textField resignFirstResponder];

    return YES;
}
@end
