//
//  UIBarButtonItem+BackButton.h
//  FPWeibot
//
//  Created by qingyun on 14-9-26.
//  Copyright (c) 2014年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BackButton)
/**
 *  静态方法，返回一个拥有normal和highlight两种状态图片的buttonItem作为导航栏的返回item
 *
 *  @param target button的点击目标
 *  @param action 相应事件
 *
 */
+ (UIBarButtonItem *)backButtonWithTarget:(id)target action:(SEL)action;
@end
