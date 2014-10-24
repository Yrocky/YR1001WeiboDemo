//
//  YRSendWeiboController.h
//  YR1001WeiboDemo
//
//  Created by Rocky on 14-10-9.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol YRSendWeiboControllerDelegate <NSObject>

@optional
- (void)senderWeiboConreollerDidCancel;

@end
@interface YRSendWeiboController : UIViewController

@property (nonatomic ,weak) id <YRSendWeiboControllerDelegate> delegate;
@end
