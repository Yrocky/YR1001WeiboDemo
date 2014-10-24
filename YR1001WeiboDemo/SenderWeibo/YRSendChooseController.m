//
//  YRSendChooseController.m
//  YR1001WeiboDemo
//
//  Created by YeungRocky on 14-10-12.
//  Copyright (c) 2014年 YeungRocky. All rights reserved.
//

#import "YRSendChooseController.h"
#import "YRChooseButton.h"
#import "YRCancelButton.h"
#import "YRSendWeiboController.h"

// button的父视图的高度
#define kBGImageH  300

// 底部button的高度
#define kBGButtonH  40

// button的高度
#define buttonWH 100

// 动画的时间
#define kAnimation 0.3


@interface YRSendChooseController ()<YRSendWeiboControllerDelegate>
@property (nonatomic ,retain) UIImageView *firstBGImage;
@property (nonatomic ,retain) UIImageView *secondBGImage;
@property (nonatomic ,retain) UIScrollView *bottomScrollerView;
@end

@implementation YRSendChooseController

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
    
    [self titleImageView];

    [self scrollerViewLayoutsubView];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_compose_below_background"]];
}

- (void) titleImageView{

    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"compose_slogan"]];
    CGSize currentImageSize = titleImageView.frame.size;
    CGFloat imageViewW = currentImageSize.width ;
    CGFloat imageViewH = currentImageSize.height ;
    CGFloat imageViewY = 100;
    CGFloat imageViewX = (self.view.frame.size.width - imageViewW) * 0.5;
    titleImageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    [self.view addSubview:titleImageView];
    
}

- (void) scrollerViewLayoutsubView{

    CGFloat scrollerW = kViewBoundsW;
    CGFloat scrollerH = kBGImageH + kBGButtonH;
    CGFloat scrollerY = kViewBoundsH - scrollerH;
    _bottomScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, scrollerY, scrollerW, scrollerH)];
    _bottomScrollerView.scrollEnabled = NO;
    _bottomScrollerView.showsHorizontalScrollIndicator = NO;
    _bottomScrollerView.pagingEnabled = YES;
    UISwipeGestureRecognizer *swipGestuer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipScrollerViewHome:)];
    swipGestuer.direction = UISwipeGestureRecognizerDirectionRight;
    [_bottomScrollerView addGestureRecognizer:swipGestuer];
    _bottomScrollerView.contentSize = CGSizeMake(2 * kViewBoundsW, scrollerH);
    
    [self.view addSubview:_bottomScrollerView];

    
    NSArray *imageArray = @[@"tabbar_compose_idea",@"tabbar_compose_photo",@"tabbar_compose_camera",@"tabbar_compose_lbs",@"tabbar_compose_review",@"tabbar_compose_more"];
    NSArray *titleArray = @[@"文字",@"相册",@"相机",@"签到",@"点评",@"更多"];
    [self bottomView:_firstBGImage withImageArray:imageArray tileArray:titleArray location:0];
    
    titleArray = @[@"好友圈",@"有声照片",@"秒拍",@"定时删",@"长微博",@"私信"];
    imageArray = @[@"tabbar_compose_friend",@"tabbar_compose_voice",@"tabbar_compose_shooting",@"tabbar_compose_delete",@"tabbar_compose_weibo",@"tabbar_compose_envelope"];
    [self bottomView:_secondBGImage withImageArray:imageArray tileArray:titleArray location:kViewBoundsW];
    
    CGFloat cancelButtonY = _bottomScrollerView.frame.size.height - kBGButtonH;
    YRCancelButton *cancel = [YRCancelButton cancelButtonWithImage:@"tabbar_compose_background_icon_close"];

    cancel.frame = CGRectMake(0, cancelButtonY, kViewBoundsW, kBGButtonH);
    [cancel addTarget:self action:@selector(cancelButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomScrollerView addSubview:cancel];
    
    YRCancelButton *back = [YRCancelButton cancelButtonWithImage:@"tabbar_compose_background_icon_return"];
    back.frame = CGRectMake(kViewBoundsW, cancelButtonY, kViewBoundsW * 0.5, kBGButtonH);
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomScrollerView addSubview:back];
    
    YRCancelButton *cancelT = [YRCancelButton cancelButtonWithImage:@"tabbar_compose_background_icon_close"];
    [cancelT addTarget:self action:@selector(cancelButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    cancelT.frame = CGRectMake(CGRectGetMaxX(back.frame), cancelButtonY, CGRectGetWidth(back.frame), kBGButtonH);
    [_bottomScrollerView addSubview:cancelT];
}

#pragma mark -  对button进行图片和文字的加载

- (void) bottomView:(UIImageView *)bottomView withImageArray:(NSArray *)imageArray tileArray:(NSArray *)titleArray location:(CGFloat)locationX{

    bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(locationX, 0, kViewBoundsW, kBGImageH)];
    bottomView.userInteractionEnabled = YES;
    
    for (int index = 0; index < 6; index ++) {
        
        YRChooseButton *button = [YRChooseButton createChooseButtonWithImage:imageArray[index] withTitle:titleArray[index]];
        int row = index % 3;
        int clom = index / 3;
        button.tag = index + locationX;
        [button addTarget:self action:@selector(senderButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(row * buttonWH + 10, clom * (buttonWH + 10) + 10, buttonWH, buttonWH);

        [bottomView addSubview:button];
    }
    
    [_bottomScrollerView addSubview:bottomView];
}

- (void) senderButtonDidClick:(YRChooseButton *)button{

    switch (button.tag) {
        case 0:
        {
            NSLog(@"%@",button.titleLabel.text);
            YRSendWeiboController *sender = [[YRSendWeiboController alloc] init];
            sender.delegate = self;
            [self presentViewController:sender animated:YES completion:^{
            
            }];
        }
            break;
        case 1:
        {
            NSLog(@"%@",button.titleLabel.text);
        }
            break;
        case 2:
        {
             NSLog(@"%@",button.titleLabel.text);
        }
            break;
        case 3:
        {
             NSLog(@"%@",button.titleLabel.text);
        }
            break;
        case 4:
        {
             NSLog(@"%@",button.titleLabel.text);
        }
            break;
        case 5:
        {
            [UIView animateWithDuration:kAnimation animations:^{

                _bottomScrollerView.contentOffset = CGPointMake(320, 0);
            }];

             NSLog(@"%@",button.titleLabel.text);
        }
            break;
        case 320:
        {
             NSLog(@"%@",button.titleLabel.text);
        }
            break;
        case 321:
        {
             NSLog(@"%@",button.titleLabel.text);
        }
            break;
        case 322:
        {
             NSLog(@"%@",button.titleLabel.text);
        }
            break;
        case 323:
        {
             NSLog(@"%@",button.titleLabel.text);
        }
            break;
        case 324:
        {
             NSLog(@"%@",button.titleLabel.text);
        }
            break;
        case 325:
        {
             NSLog(@"%@",button.titleLabel.text);
        }
            break;
        default:
            break;
    }
    
}
#pragma mark - 点击取消按钮页面消失
- (void) cancelButtonDidClick:(YRCancelButton *)cancel{

    
    if ([self.delegate respondsToSelector:@selector(senderChooseControllerDidCancel)]) {
        
        [self.delegate senderChooseControllerDidCancel];
    }
//    [self dismissViewControllerAnimated:YES completion:nil];

}
- (void)senderWeiboConreollerDidCancel{

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) back:(YRCancelButton *)cancel{

    [UIView animateWithDuration:kAnimation animations:^{

        _bottomScrollerView.contentOffset = CGPointMake(0, 0);
    }];

}

#pragma mark - 手势动作将scrollerView回原
- (void) swipScrollerViewHome:(UISwipeGestureRecognizer *)swip{

    [UIView animateWithDuration:kAnimation animations:^{
        _bottomScrollerView.contentOffset = CGPointMake(0, 0);
    }];

}
- (void)dealloc{

    YRLog(@"选择发微博界面dealloc");
}

@end
