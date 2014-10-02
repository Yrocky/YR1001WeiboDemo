//
//  YRPhotosView.h
//  YR1001WeiboDemo
//
//  Created by Rocky on 14-10-2.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YRPhotosView : UIView
@property (nonatomic ,retain) NSArray *photos;

+ (CGSize) photoViewWithPhoutCount:(int)count;
@end
