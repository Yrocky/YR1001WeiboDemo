//
//  YRViewControllerMangers.h
//  YRTestOne
//
//  Created by Rocky on 14-9-26.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, YRViewControllerMangerType) {

    YRViewControllerMangerTypeGuideViewController,
    YRViewControllerMangerTypeLognViewController,
    YRViewControllerMangerTypeMainViewController
    
};

@interface YRViewControllerMangers : NSObject


+ (void) presentViewCotrllerWithType:(YRViewControllerMangerType)viewControllerMangerType;

@end
