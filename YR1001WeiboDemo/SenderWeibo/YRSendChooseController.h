//
//  YRSendChooseController.h
//  YR1001WeiboDemo
//
//  Created by YeungRocky on 14-10-12.
//  Copyright (c) 2014年 YeungRocky. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol YRSendChooseControllerDelegate <NSObject>

@optional
- (void)senderChooseControllerDidCancel;

@end
@interface YRSendChooseController : UIViewController

@property (nonatomic ,weak) id <YRSendChooseControllerDelegate> delegate;
@end
