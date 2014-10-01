//
//  YRLoginViewController.m
//  YRTestOne
//
//  Created by Rocky on 14-9-26.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import "YRLoginViewController.h"

@interface YRLoginViewController ()
@property (nonatomic ,retain) UIButton *button;
@end

@implementation YRLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

            self.view.backgroundColor = [UIColor greenColor];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [YRNSDC addObserver:self selector:@selector(onWeinoLogin:) name:kYRNotificationNameLogin object:nil];
}

- (void) viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    [YRNSDC removeObserver:self name:kYRNotificationNameLogoff object:self];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _button = [[UIButton alloc] initWithFrame:CGRectMake(200, 300, 40, 40)];
    [_button setTitle:@"Login" forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(onButtonCliclk:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];

    // Do any additional setup after loading the view.
}
/**
 *  登陆成功的时候微博delegate发送一个通知，在这里进行通知里面的方法
 *
 */
- (void) onWeinoLogin:(NSNotification *)notify{

    [YRViewControllerMangers presentViewCotrllerWithType:YRViewControllerMangerTypeMainViewController];
}
- (void) onButtonCliclk:(UIButton *)sender{

    [appDelegate.sinaWeibo logIn];

}

@end
